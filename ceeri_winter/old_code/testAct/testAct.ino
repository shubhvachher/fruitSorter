/*
 * Variable List
 * Variable t holds the time required for the fruit to travel from the imager to the end of the conveyer belt.
 * defDelayTime(milliseconds) holds the default value of t.
 * mechanismDelay(milliseconds) holds the time it takes for the mechanism to settle into a particular grade postion.
 * del(milliseconds) holds the time it takes between a fruit falling onto the sorter and falling into its basket.
 * fruitList holds a list of the fruits that have been identified by the imager.
 * fruitQuant holds the quantity of fruits that have passed the IR sensor point.
 * setTime holds the setting time for the mechanism for a particular fruit in the fruitList.
 * 
 */

unsigned long t=0, del=2000, setTime[50];
int defDelayTime=6000,mechanismDelay = 200;
int lastFruit=0, nextToBeSet=0, nextToBeDeleted=0;
int canBeServiced=1, startedService=0;
int fruitQuant[5]={0,0,0,0,0}; //Holds number of 'A', 'B', 'C', 'D', 'Undefined'
char sort,command;
char fruitList[50];



void setGrade(char s)
{
    switch(s)
    {
        case 'A':   //North
            Serial.println("Grade A");
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
            Serial.println("Grade B");
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
            Serial.println("Grade C");
            digitalWrite(22,LOW);
            digitalWrite(23,HIGH);
            digitalWrite(24,LOW);
            digitalWrite(25,HIGH);
            digitalWrite(26,LOW);
            digitalWrite(27,HIGH);
            digitalWrite(28,HIGH);
            digitalWrite(29,LOW);
            break;
        case 'D':   //West
            Serial.println("Grade D");
            digitalWrite(22,LOW);
            digitalWrite(23,HIGH);
            digitalWrite(24,LOW);
            digitalWrite(25,HIGH);
            digitalWrite(26,HIGH);
            digitalWrite(27,LOW);
            digitalWrite(28,LOW);
            digitalWrite(29,HIGH);
            break;
        default:   //stable
            Serial.println("Stable");
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
    Serial.println("Enter delay from imager to sorter depending on size of belt; if available.");
    Serial.print("Waiting...");
    while (millis() < 3000)
    {
        if(Serial.available() > 0)
        {
            t*=10;
            t+=(Serial.read() - 48); //Because Serial.read can read only one byte at a time
        }
    }
    if(t==0)
    {
        t=defDelayTime;
    }
    else
    {
      t*=10; //To convert to milliseconds
    }
    Serial.print("Chosen delay time is : ");
    Serial.print(t);
    Serial.println(" milliseconds.");
    pinMode(22,OUTPUT);
    pinMode(23,OUTPUT);
    pinMode(24,OUTPUT);
    pinMode(25,OUTPUT);
    pinMode(26,OUTPUT);
    pinMode(27,OUTPUT);
    pinMode(28,OUTPUT);
    pinMode(29,OUTPUT);
    setGrade('E');  //To set it to stable position. Grade 'E' activates default in setGrade()
}

void loop() {
    if(Serial.available()>0)
    {
      fruitList[lastFruit++]=Serial.read();
      if(lastFruit==50)lastFruit=0;
    }

    if(analogRead(A4)<450 && canBeServiced==0)//A4 is the IR Sensor
    {
      delay(2);
      if(analogRead(A4)<450)
      {
        canBeServiced=1; 
      }
    }
    
    if((startedService==1) || ((canBeServiced==1) && (analogRead(A4)>450) && ((lastFruit-(fruitQuant[0]+fruitQuant[1]+fruitQuant[2]+fruitQuant[3]+fruitQuant[4]))>0)))
    {
      Serial.println(analogRead(A4));
      if(analogRead(A4)>450)canBeServiced=0;
      if(startedService==0)startedService=1;
      if(startedService==1 && canBeServiced==1)
      {
        sort = fruitList[(fruitQuant[0]+fruitQuant[1]+fruitQuant[2]+fruitQuant[3]+fruitQuant[4])%50];
        setTime[(fruitQuant[0]+fruitQuant[1]+fruitQuant[2]+fruitQuant[3]+fruitQuant[4])%50] = (millis()+t);
        if(sort=='A' || sort=='B' || sort=='C' || sort=='D')
          fruitQuant[sort-65]++;
        else
          fruitQuant[4]++;
          
        startedService=0; //Service Ends
        Serial.print(sort);
        Serial.println(" serviced...");
      }
    }

    if(((setTime[nextToBeSet] - millis()) < mechanismDelay) && nextToBeSet<((fruitQuant[0]+fruitQuant[1]+fruitQuant[2]+fruitQuant[3]+fruitQuant[4])%50))
    {
      setGrade(fruitList[nextToBeSet]);
      nextToBeSet++;
    }
    if((nextToBeDeleted<nextToBeSet) && ((signed long)(millis() - setTime[nextToBeDeleted]) > del))
    {
      if(fruitList[nextToBeDeleted+1]!=fruitList[nextToBeDeleted])
        setGrade('E');
      nextToBeDeleted++;
    }
    
    if((millis()%60000) < 5)  //After every 1 minute, accounting for a 5 millisecond program runtime to get to this if statement
    {
        Serial.println();
        Serial.println();
        Serial.print("After ");
        Serial.print(millis()/3600000);
        Serial.print("hr(s) and ");
        Serial.print((millis()%3600000)/60000);
        Serial.println("mins : ");
        Serial.println();
        Serial.println(" Objects Scanned ");
        Serial.print("GRADE A: ");
        Serial.println(fruitQuant[0]);
        Serial.print("GRADE B: ");
        Serial.println(fruitQuant[1]);
        Serial.print("GRADE C: ");
        Serial.println(fruitQuant[2]);
        Serial.print("GRADE D: ");
        Serial.println(fruitQuant[3]);
        Serial.print("Unknown : ");
        Serial.println(fruitQuant[4]);
    }
}

