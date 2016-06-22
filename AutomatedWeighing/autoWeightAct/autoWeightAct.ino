/*
 * Variable List
 */

int fruitWeighed=0, fruitPassed=-1;//First pass of loop() will ensure fruitPassed will be set to zero.
int startedDetect=1;//We start with 1 to ensure correct performance of sensor in the presence of no fruit in front of it.

int photoElec=0, quantDel=0;

void setup() {
    Serial.begin(9600);
    delay(2000);
}

void loop() {

    if(analogRead(A4)<450 && startedDetect==1)//A4 is the Prox Sensor
    {
      delay(10);
      if(analogRead(A4)<450)
      {
        fruitPassed+=1;
        startedDetect=0;
      }
    }
    if(analogRead(A4)>450 && startedDetect==0)
    {
      startedDetect=1;
    }

    if(analogRead(A1)>50 && fruitWeighed<fruitPassed)//A1 is the Weighing Machine input
    {
      delay(20);
      while(analogRead(A1)>50)
      {
         Serial.println(analogRead(A1));
         delay(20);
      }
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
