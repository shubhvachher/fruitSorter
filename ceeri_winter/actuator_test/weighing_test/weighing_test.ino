void setup()
{
  Serial.begin(9600);
  analogReference(INTERNAL);
}

float val=0;
void loop() 
{
  val = analogRead(A0);
  Serial.print(val*(1.1/1024));
  Serial.print(" : ");
  Serial.println(val);
  delay(1000);
}
