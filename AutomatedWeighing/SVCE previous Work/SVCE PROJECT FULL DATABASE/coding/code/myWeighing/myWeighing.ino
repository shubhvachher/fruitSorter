#include <FreqCount.h>
#include <LiquidCrystal.h>

LiquidCrystal lcd(12, 11, 8, 4, 3, 2);
#define MAXCOUNT 100
int Contrast=30;
int Light=28836;
int row = 0;
float weight=0;
float T_weight=0;
float Fweight[MAXCOUNT];
float freq=0;
float freq0=0;
float freq1=0;
float m=0;
float mx=0;
float thousandgram=0;
int wcount=0;
int wcount1=0;
int x;
int y;
int j;
float arr;
int Frcount=0;
int Fruitcount=0;
float array[10];
const int IRSensor = A0;
int IRvalue=0;
float mean=0;
int prevIRvalue;

void IR();
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
 // lcd.clear();
  IR(); // Fruit Count
  if (FreqCount.available())
  {

    float count = FreqCount.read();
    freq=((count*10)/1000);
    weight=(((freq-freq0)/mx));//.01959
  do
   {
    T_weight  = weight + T_weight;
    wcount++;
    array[wcount] = weight;
   }
   while(weight !=0);

   mean = T_weight/wcount;
   x =mean +2;
   y =mean -2;

   for(j=1;j<wcount;j++)
   {
     if(array[j]<x && array[j]>y)
     {
       arr=  array[j] + arr;
       wcount1++;
     }
   }
    wcount =0;
    wcount1 = 0;
   }

if(prevIRvalue == IRvalue)
{
  Fruitcount++;
}
  Fweight[Fruitcount-2] = arr/wcount1; // Final Weight per Fruit
  prevIRvalue = IRvalue;

    lcd.print("Fruit No:");
    lcd.setCursor(9, 0);
    lcd.print(IRvalue);
    lcd.setCursor(0, 1);
    lcd.print("Weight:");
    lcd.setCursor(7, 1);
    lcd.print(Fweight[MAXCOUNT],1);
    lcd.setCursor(12, 1);
    lcd.print("grams");

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
  delay(100);
}

void excelExport()
{
 Serial.print("DATA,TIME,"); Serial.print(IRvalue); Serial.print(","); Serial.println(Fweight[MAXCOUNT]);
 row++;
 delay(1000);
}

////////////////////////////////////////////////////////////////////////////////////
