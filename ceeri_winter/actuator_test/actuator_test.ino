void setup()
{
  Serial.begin(9600);
  pinMode(7,OUTPUT);
  pinMode(8,OUTPUT);
  digitalWrite(7,LOW);
  digitalWrite(8,LOW);
}
char want1='0';
void loop()
{
  if(Serial.available()>0)
  {
    want1 = Serial.read();
    Serial.print(want1);
  }
  if(want1=='1')
  {
    digitalWrite(7,HIGH);
    digitalWrite(8,HIGH);
  }
  else if(want1=='0')
  {
    digitalWrite(7,LOW);
    digitalWrite(8,LOW);
  }
}

