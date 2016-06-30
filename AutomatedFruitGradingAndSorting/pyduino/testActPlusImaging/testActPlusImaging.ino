/*
 * Variable List
 *
 * Variable t holds the time required for the fruit to travel from the imager to the end of the conveyer belt.
 * defDelayTime(milliseconds) holds the default value of t.
 * mechanismDelay(milliseconds) holds the time it takes for the mechanism to settle into a particular grade postion.
 * del(milliseconds) holds the time it takes between a fruit falling onto the sorter and falling into its basket.
 * fruitList holds a list of the fruits that have been identified by the imager.
 * fruitQuant holds the quantity of fruits that have passed the IR sensor point.
 * setTime holds the times when the sorter needs to be set to a particular postition.
 *
 */

unsigned long t=0, setTime[50];
signed long del=2000;
int defDelayTime=2300,mechanismDelay = 200;
int fruitQuant[4]={0,0,0,0}; //Holds number of 'A', 'B', 'C', 'Undefined'
char fruitList[50];

int lastFruit=0, nextToBeSet=0, nextToBeDeleted=0;
int canBeServiced=1, startedService=0;
char sort;

int photoElec=0, quantDel=0;


void setGrade(char s)
{
    switch(s)
    {
        case 'A':   //North
            //Serial.println("Grade A");
            digitalWrite(22,HIGH);
            digitalWrite(23,LOW);
            digitalWrite(24,LOW);
            digitalWrite(25,HIGH);
            digitalWrite(26,LOW);
            digitalWrite(27,HIGH);
            digitalWrite(28,LOW);
            digitalWrite(29,HIGH);
            break;
        case 'B':   //South
            //Serial.println("Grade B");
            digitalWrite(22,LOW);
            digitalWrite(23,HIGH);
            digitalWrite(24,HIGH);
            digitalWrite(25,LOW);
            digitalWrite(26,LOW);
            digitalWrite(27,HIGH);
            digitalWrite(28,LOW);
            digitalWrite(29,HIGH);
            break;
        case 'C':   //East
            //Serial.println("Grade C");
            digitalWrite(22,LOW);
            digitalWrite(23,HIGH);
            digitalWrite(24,LOW);
            digitalWrite(25,HIGH);
            digitalWrite(26,LOW);
            digitalWrite(27,HIGH);
            digitalWrite(28,HIGH);
            digitalWrite(29,LOW);
            break;
        case 'D':   //West ; Undefined Fruit
            //Serial.println("Undefined Fruit");
            digitalWrite(22,LOW);
            digitalWrite(23,HIGH);
            digitalWrite(24,LOW);
            digitalWrite(25,HIGH);
            digitalWrite(26,HIGH);
            digitalWrite(27,LOW);
            digitalWrite(28,LOW);
            digitalWrite(29,HIGH);
            break;
        default:   //Mid-Position
            //Serial.println("Mid_Position");
            digitalWrite(22,LOW);
            digitalWrite(23,HIGH);
            digitalWrite(24,LOW);
            digitalWrite(25,HIGH);
            digitalWrite(26,LOW);
            digitalWrite(27,HIGH);
            digitalWrite(28,LOW);
            digitalWrite(29,HIGH);
    }
}

void setup() {
    Serial.begin(9600);
    delay(2000);
    t=defDelayTime;
    //Serial.print("Chosen delay time is : ");
    //Serial.print(t);
    //Serial.println(" milliseconds.");
    pinMode(22,OUTPUT);
    pinMode(23,OUTPUT);
    pinMode(24,OUTPUT);
    pinMode(25,OUTPUT);
    pinMode(26,OUTPUT);
    pinMode(27,OUTPUT);
    pinMode(28,OUTPUT);
    pinMode(29,OUTPUT);
    setGrade('E');  //To set it to mid position. Grade 'E' activates default clause in setGrade() function
}
unsigned long test =0;
void loop() {

    if(Serial.available()>0)
    {
      fruitList[lastFruit++]=Serial.read();
      if(lastFruit==50)lastFruit=0;
    }

    if(analogRead(A1)<450 && photoElec==1 && millis()%100==0)//A1 is the Prox1 Sensor
    {
      delay(20);
      if(analogRead(A1)<450)
      {
        photoElec=0;
        Serial.println("ProxMark"); //Tells the Python Code that Proximity sensor 1 was triggered before and has just switched off.
        //Serial.println(millis());
      }
    }
    //Serial.println(analogRead(A1));
    if(analogRead(A1)>450)
    {
      //Serial.println(analogRead(A1));
      photoElec=1;
    }

    if(analogRead(A4)<450 && canBeServiced==0)//A4 is the Prox2 Sensor
    {
      delay(20);
      if(analogRead(A4)<450)
      {
        canBeServiced=1;
      }
    }

    if((startedService==1) || (analogRead(A4)>450) && ((canBeServiced==1) && ((lastFruit-(fruitQuant[0]+fruitQuant[1]+fruitQuant[2]+fruitQuant[3]))>0)))
    {
      //Serial.println(analogRead(A4));
      if(analogRead(A4)>450)canBeServiced=0;
      if(startedService==0)startedService=1;
      if(startedService==1 && canBeServiced==1)
      {
        sort = fruitList[(fruitQuant[0]+fruitQuant[1]+fruitQuant[2]+fruitQuant[3])%50];
        setTime[(fruitQuant[0]+fruitQuant[1]+fruitQuant[2]+fruitQuant[3])%50] = (millis()+t);
        //Serial.println(millis());
        //Serial.println(t);

        if(sort=='A' || sort=='B' || sort=='C')
          fruitQuant[sort-65]++;
        else
          fruitQuant[3]++;

        startedService=0; //Service Ends
        Serial.print(sort);
        Serial.println(" serviced...");
      }
    }

    if(((setTime[nextToBeSet] - millis()) < mechanismDelay) && nextToBeSet<((fruitQuant[0]+fruitQuant[1]+fruitQuant[2]+fruitQuant[3])%50))
    {
      //Serial.println(setTime[nextToBeSet]);
      //Serial.println(millis());
      setGrade(fruitList[nextToBeSet]);
      nextToBeSet++;
    }
    if((nextToBeDeleted<nextToBeSet) && ((signed long)(millis() - setTime[nextToBeDeleted]) > del))
    {
      //Serial.println((signed long)(millis() - setTime[nextToBeDeleted]));
      if(fruitList[nextToBeDeleted+1]!=fruitList[nextToBeDeleted])
        setGrade('E');//To set it to mid position. Grade 'E' activates default clause in setGrade() function
      nextToBeDeleted++;
    }

    if(quantDel==1 && millis()%1000==0)
    {
      quantDel=0;
    }
    if(((millis()%60000) < 5) && quantDel==0)  //After every 1 minute, accounting for a 5 millisecond program runtime to get to this if statement
    {
      Serial.print("Quant:");
      Serial.print(fruitQuant[0]);
      Serial.print(":");
      Serial.print(fruitQuant[1]);
      Serial.print(":");
      Serial.print(fruitQuant[2]);
      Serial.print(":");
      Serial.print(fruitQuant[3]);
      Serial.println();
      quantDel=1;
    }

}
