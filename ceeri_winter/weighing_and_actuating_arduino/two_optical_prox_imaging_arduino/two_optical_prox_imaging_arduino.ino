/*
 * The arduino needs to perfrom two operations simultaneously. One is to measure the weight of the incoming fruit and send the same to a computer as a trigger for the camera.
 * The second is to be used as a controller for the two actuators for the entrances of the baskets the fruit needs to be sorted into
 */


//Variables for weight calculations
int weightValue=0;



//Variables for sorting table actuation
char fruitList[50];
int fruitQuant[3]={0,0,0};    //Holds number of 'A', 'B', UNKNOWN

unsigned long t=700, tAB=2000, setTime[50], setTimeAB[50]; //t holds the time between getting a trigger from the roller crossing proximity sensor 2 and the roller reaching the sorting station
//tAB is the time taken between basket A and B
//setTimeAB will hold all baskets time after A that hold B fruit
unsigned long ATimer=0, BTimer=0;
signed long del=1200;
int mechanismDelay=100;   //mechanismDelay is the time the sorting station mechanism takes to open

int lastFruit = 0, nextToBeSet=0, ABTracker=0, nextToBeSetAB=0, Aset=0, Bset=0;
int canBeServiced=1, startedService=0;
int photoElec=0;
char sort;

int quantDel=0;

void setGrade(char s)
{
  switch(s)
  {
    case 'A':     //First basket
        digitalWrite(7,HIGH);
        Aset=1;
        ATimer = millis();
        Serial.println("Grade A set");
        break;
    case 'B':     //Second basket
        digitalWrite(8,HIGH);
        Bset=1;
        BTimer = millis();
        Serial.println("Grade B set");
        break;
    case 'Z':     //Unset A
        digitalWrite(7,LOW);
        Serial.println("Grade A UNSet");
        Aset=0;
        break;
    case 'Y':     //Unset B
        digitalWrite(8,LOW);
        Serial.println("Grade B UNSet");
        Bset=0;
        break;
    default :     //All closed, default state
        digitalWrite(7,LOW);
        digitalWrite(8,LOW);
        Serial.println("Default State now");
  }
}
void setup()
{
  Serial.begin(9600);
  pinMode(7,OUTPUT);
  pinMode(8,OUTPUT);
  delay(2000);
  setGrade('X');    //Default positions where all the baskets are closed
}

void loop()
{
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

  if(analogRead(A1)>450)
  {
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

  if((startedService==1) || (analogRead(A4)>450) && ((canBeServiced==1) && ((lastFruit-(fruitQuant[0]+fruitQuant[1]+fruitQuant[2]))>0)))
  {
    //Serial.println(analogRead(A4));
    if(analogRead(A4)>450)canBeServiced=0;
    if(startedService==0)startedService=1;
    if(startedService==1 && canBeServiced==1)
    {
      sort = fruitList[(fruitQuant[0]+fruitQuant[1]+fruitQuant[2])%50];
      setTime[(fruitQuant[0]+fruitQuant[1]+fruitQuant[2])%50] = (millis()+t);
      //Serial.println(millis());
      //Serial.println(t);

      fruitQuant[sort-65]++;

      startedService=0; //Service Ends
      Serial.print(sort);
      Serial.println(" serviced...");
     }
  }

  if(((setTime[nextToBeSet] - millis()) < mechanismDelay) && nextToBeSet!=((fruitQuant[0]+fruitQuant[1]+fruitQuant[2])%50))
  {
    //Serial.println(setTime[nextToBeSet]);
    //Serial.println(millis());
    if(fruitList[nextToBeSet]=='A')
    {
      setGrade('A');
    }
    else if(fruitList[nextToBeSet]=='B')
    {
      Serial.println("B found, waiting...");
      setTimeAB[ABTracker%50] = (millis()+tAB);
      ABTracker++;
    }
    //Grade 'X' if part of the list is ignored so it falls off the end of the conveyer
    nextToBeSet++;
    if(nextToBeSet==50)nextToBeSet=0;
  }
  if(((setTimeAB[nextToBeSetAB] - millis() < mechanismDelay) && nextToBeSetAB!=(ABTracker%50)))
  {
    setGrade('B');
    nextToBeSetAB++;
    if(nextToBeSetAB==50)nextToBeSetAB=0;
  }

  if(Aset==1 && ((millis()-ATimer) > del))
  {
    setGrade('Z');
  }
  if(Bset==1 && ((millis()-BTimer) > del))
  {
    setGrade('Y');
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
    Serial.println();
    quantDel=1;
  }
}
