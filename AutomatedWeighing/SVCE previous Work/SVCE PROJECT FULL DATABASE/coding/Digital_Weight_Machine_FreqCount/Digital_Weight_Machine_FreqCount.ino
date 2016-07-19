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
float onegram=0;
float tengram=0;
float hundredgram=0;
float thousandgram=0;
float thousand=0;

///*
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
    onegram=freq1+19.233;
    tengram=freq1+192.333;
    hundredgram=freq1+1923.333+10.00;
    thousandgram=freq1+19233.333;//+10.10;//105.555
    m=(thousandgram-freq1);
    mx=(m/1000000);
   }
}

void loop() 
{
  if (FreqCount.available())
  {
    lcd.clear();
    float count = FreqCount.read();
    freq=((count*10)/1000);
    
    weight=(((freq-freq0)/mx));//.01959
    //Serial.println(mx,9);
    // Serial.print(freq);
    //Serial.println(" g");
    lcd.print("Freq:");
    lcd.setCursor(5, 0);
    lcd.print(freq);
    lcd.setCursor(12, 0);
    lcd.print("kHz");
    lcd.setCursor(0, 1);
    lcd.print("Weight:");
    lcd.setCursor(7, 1);
    lcd.print(weight);
    lcd.setCursor(12, 1);
    lcd.print("grams");
  }
excelExport();  
}

void excelExport()
{
 Serial.print("DATA,TIME,"); Serial.print(fruit); Serial.print(","); Serial.print(freq); Serial.print(","); Serial.println(weight);
row++;
fruit++;
delay(100);
}
// */


/*
void setup() 
{
  Serial.begin(57600);
  FreqCount.begin(1000);
  analogWrite(6,Contrast);
  analogWrite(7,Light);
  lcd.begin(16, 2);
  delay(1500);
  if (FreqCount.available())
   {
    float count = FreqCount.read();
    freq1=(count);
    onegram=freq1+19.233;
    tengram=freq1+192.333;
    hundredgram=freq1+1923.333+10.00;
    thousandgram=freq1+19233.333+285.00;
    m=(thousandgram-freq1);
    mx=(m/1000);
   }
}

void loop() 
{
  if (FreqCount.available())
  {
    lcd.clear();
    float count = FreqCount.read();
    freq=(count);
    
    weight=((freq-freq1)/mx);//.01959
    //Serial.println(mx,9);
    // Serial.print(freq);
    //Serial.println(" g");
    lcd.print("Freq:");
    lcd.setCursor(5, 0);
    lcd.print(freq);
    lcd.setCursor(14, 0);
    lcd.print("Hz");
    lcd.setCursor(0, 1);
    lcd.print("Weight:");
    lcd.setCursor(7, 1);
    lcd.print(weight);
    lcd.setCursor(14, 1);
    lcd.print("grams");
  }
}
*/
