/*
 * The arduino needs to perfrom two operations simultaneously. One is to measure the weight of the incoming fruit and send the same to a computer as a trigger for the camera.
 * The second is to be used as a controller for the two actuators for the entrances of the baskets the fruit needs to be sorted into
 */


//Variables for weight calculations
int weightValue=0;



//Variables for sorting table actuation
char fruitList[50];
int fruitQuant[2]={0,0};    //Holds number of 'A', 'B'

unsigned long t=500, setTime[50]; //t holds the time between getting a trigger from the proximity sensor and the basket reaching the sorting station
signed long del=2000;
int mechanismDelay=200;   //mechanismDelay is the time the sorting station mechanism takes to open

int lastFruit = 0, nextToBeSet=0, nextToBeDeleted=0;
int canBeServiced=1, startedService=0;
char sort;

int quantDel=0;

void setGrade(char s)
{
  switch(s)
  {
    case 'A':     //First basket
        Serial.println("Grade A set");
        break;
    case 'B':     //Second basket
        Serial.println("Grade B set");
        break;
    default :     //All closed, default state
        Serial.println("Default State now");
    
  }
}
void setup()
{
  Serial.begin(9600);
  setGrade('X');    //Default positions where all the baskets are closed
}

void loop()
{
  //weightValue = waitForWeight();
  Serial.print("Weight Value : ");
  Serial.println(weightValue);

  if(Serial.available()>0)
  {
    fruitList[lastFruit++]=Serial.read();
    if(lastFruit==50)lastFruit=0;
  }

  if(analogRead(A4)<450 && canBeServiced==0)//A4 is the Prox Sensor
  {
    delay(20);
    if(analogRead(A4)<450)
    {
      canBeServiced=1;
    }
  }

  if((startedService==1) || (analogRead(A4)>450) && ((canBeServiced==1) && ((lastFruit-(fruitQuant[0]+fruitQuant[1]))>0)))
  {
    //Serial.println(analogRead(A4));
    if(analogRead(A4)>450)canBeServiced=0;
    if(startedService==0)startedService=1;
    if(startedService==1 && canBeServiced==1)
    {
      sort = fruitList[(fruitQuant[0]+fruitQuant[1])%50];
      setTime[(fruitQuant[0]+fruitQuant[1])%50] = (millis()+t);
      //Serial.println(millis());
      //Serial.println(t);

      fruitQuant[sort-65]++;

      startedService=0; //Service Ends
      Serial.print(sort);
      Serial.println(" serviced...");
     }
  }

  if(((setTime[nextToBeSet] - millis()) < mechanismDelay) && nextToBeSet<((fruitQuant[0]+fruitQuant[1])%50))
  {
    //Serial.println(setTime[nextToBeSet]);
    //Serial.println(millis());
    setGrade(fruitList[nextToBeSet]);
    nextToBeSet++;
    if(nextToBeSet==50)nextToBeSet=0;
  }
  if((nextToBeDeleted<nextToBeSet) && ((signed long)(millis() - setTime[nextToBeDeleted]) > del))
  {
    //Serial.println((signed long)(millis() - setTime[nextToBeDeleted]));
    if(fruitList[nextToBeDeleted+1]!=fruitList[nextToBeDeleted])
      setGrade('X');//To set it to mid position. Grade 'X' activates default clause in setGrade function
    nextToBeDeleted++;
    if(nextToBeDeleted==50)nextToBeDeleted=0;
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
    Serial.println();
    quantDel=1;
  }
}
