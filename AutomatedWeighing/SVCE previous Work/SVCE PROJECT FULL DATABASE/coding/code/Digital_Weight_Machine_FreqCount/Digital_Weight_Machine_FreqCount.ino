#include <FreqCount.h>
#include <LiquidCrystal.h>

LiquidCrystal lcd(12, 11, 8, 4, 3, 2);

int Contrast=30;
int Light=28836;
int weight=0;
int row = 0;
int fruit = 0;
float freq=0;
float freq0=0;
float freq1=0;
float m=0;
float mx=0;
float thousandgram=0;
const int IRSensor = A0;
int IRvalue=0;
int Fruitcount=0;

void setup() 
{
  Serial.begin(9600);
  FreqCount.begin(100);
  analogWrite(6,Contrast);
  analogWrite(7,Light);
  lcd.begin(16, 2);
  Serial.println("CLEARDATA"); //clears any residual data
  Serial.println("LABEL,Time,Fruit No.,Frequency(kHz),Weight(g)");
  delay(1500);
  if (FreqCount.available())
   {
    float count = FreqCount.read();
    freq0=((count*10)/1000);
    freq1=(count*10);
    thousandgram=freq1+19233.333;//+10.10;//105.555
    m=(thousandgram-freq1);
    mx=(m/1000000);
   }
}

void loop() 
{
  IR();
  lcd.print("Fruit No:");
  lcd.setCursor(8, 0);
  lcd.print(IRvalue);
    
  if (FreqCount.available())
  {
    lcd.clear();
    float count = FreqCount.read();
    freq=((count*10)/1000);
    weight=(((freq-freq0)/mx));//.01959
    lcd.setCursor(0, 1);
    lcd.print("Weight:");
    lcd.setCursor(7, 1);
    Serial.print(weight);
    lcd.setCursor(12, 1);
    Serial.println(" grams");
  }
  excelExport();  
}

void IR()
{
  if(IRvalue = digitalRead(IRSensor))  //read the value from the sensor
  {
    Fruitcount++;
    IRvalue=Fruitcount;
  }
  else
  {
    IRvalue=Fruitcount;
    //Serial.println(IRvalue);
  }
  delay(1000);
}

void excelExport()
{
 Serial.print("DATA,TIME,"); Serial.print(fruit); Serial.print(","); Serial.print(freq); Serial.print(","); Serial.println(weight);
row++;
fruit++;
delay(100);
}

/*
///////////////////////////////////////////////////////////////////////////

#include <SoftwareSerial.h>

SoftwareSerial mySerial(10,5); // RX, TX


float weigh;
int array[15];
unsigned long int count =0 ,mean, T_weigh =0,count1,arr,Weight,x,y;
int i,j;


void loop() {
  
  boolean condition = false;
  if (Serial.available()) {
    while(Serial.available()) {
      Serial.read();
    }
    condition = true;
  }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
 if(condition)
 {
   do
   {
     
     weigh  = Serial.read();
     T_weigh  = weigh + T_weigh; 
     count++;
     for(i=0;weigh !=0;i++)
     {
       array[i] = weigh;
     }
     
   }while(weigh !=0);
   mean = T_weigh/count;
   
   x =mean +2;
   y =mean -2;  
   for(j=0;j<i;j++)
   {
     if(array[j]<x && array[j]>y)
     {
       arr=  array[j] + arr;
       count1++;
     }
   }
  Weight = arr/count1;
   Serial.println(Weight);
   mySerial.println(Weight);
   count =0;
 }

}

////////////////////////////////////////////////////////////////////////////////////
*/




