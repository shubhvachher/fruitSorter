void setup() {
Serial.begin(9600);
}

float input=0, weight=0;

void loop() {
input = analogRead(A2);
weight = (input/1024);
weight = (weight*500);
Serial.print("Input is : ");
Serial.println(input);
Serial.print("Weight is : ");
Serial.println(weight);
Serial.println();
delay(1000);
}
