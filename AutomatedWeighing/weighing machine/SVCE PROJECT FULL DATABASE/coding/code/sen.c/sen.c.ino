/*  The circuit:
 * LCD RS pin to digital pin 12
 * LCD Enable pin to digital pin 11
 * LCD D4 pin to digital pin 5
 * LCD D5 pin to digital pin 4
 * LCD D6 pin to digital pin 3
 * LCD D7 pin to digital pin 2
 * LCD R/W pin to ground
 * LCD VSS pin to ground
 * LCD VCC pin to 5V
 * 10K resistor:
 * ends to +5V and ground
 * wiper to LCD VO pin (pin 3)*/ 


#include <SoftwareSerial.h>
#include <LiquidCrystal.h>

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

const int IRSensor = A0;
int IRvalue,tempF,count=0;

SoftwareSerial mySerial(5, 4); // RX, TX
void setup() 
{
  lcd.begin(16, 1);
  Serial.begin(9600);       // use the serial port  
  mySerial.begin(9600);
}
void loop() 
{
   lcd.setCursor(1,0);
   lcd.print("Count");
  IR();
}

void IR()
{
  if(IRvalue == digitalRead(IRSensor))  //read the value from the sensor
  {
    count++;
    lcd.setCursor(1,1);
    lcd.print(count);
    Serial.println(IRvalue);
    Serial.println(millis());
  }
  else
  {
   // count++;
    Serial.println(IRvalue);
  }
  delay(1000);
}
