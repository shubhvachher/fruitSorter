int gradeGot[] = {
  'A', 'B', 'C', 'D', 'E'
};

char currGrade;
char nextGrade;
int iteration=0;

void setGrade(char s)
{
    switch(s)
    {
        case 'A':   //North
            Serial.println("Grade A");
            digitalWrite(22,HIGH);
            digitalWrite(23,LOW);
            digitalWrite(24,LOW);
            digitalWrite(25,HIGH);
            digitalWrite(26,LOW);
            digitalWrite(27,HIGH);
            digitalWrite(28,LOW);
            digitalWrite(29,HIGH);
            
            //digitalWrite(22,HIGH);digitalWrite(23,HIGH);digitalWrite(24,HIGH);digitalWrite(25,HIGH);digitalWrite(26,HIGH);digitalWrite(27,HIGH);digitalWrite(28,HIGH);digitalWrite(29,HIGH);
            break;
        case 'B':   //South
            Serial.println("Grade B");
            digitalWrite(22,LOW);
            digitalWrite(23,HIGH);
            digitalWrite(24,HIGH);
            digitalWrite(25,LOW);
            digitalWrite(26,LOW);
            digitalWrite(27,HIGH);
            digitalWrite(28,LOW);
            digitalWrite(29,HIGH);
            break;
        case 'C':   //East
            Serial.println("Grade C");
            digitalWrite(22,LOW);
            digitalWrite(23,HIGH);
            digitalWrite(24,LOW);
            digitalWrite(25,HIGH);
            digitalWrite(26,LOW);
            digitalWrite(27,HIGH);
            digitalWrite(28,HIGH);
            digitalWrite(29,LOW);
            break;
        case 'D':   //West
            Serial.println("Grade D");
            digitalWrite(22,LOW);
            digitalWrite(23,HIGH);
            digitalWrite(24,LOW);
            digitalWrite(25,HIGH);
            digitalWrite(26,HIGH);
            digitalWrite(27,LOW);
            digitalWrite(28,LOW);
            digitalWrite(29,HIGH);
            break;
        default:   //stable
            Serial.println("Stable");
            digitalWrite(22,LOW);
            digitalWrite(23,HIGH);
            digitalWrite(24,LOW);
            digitalWrite(25,HIGH);
            digitalWrite(26,LOW);
            digitalWrite(27,HIGH);
            digitalWrite(28,LOW);
            digitalWrite(29,HIGH);
    }
}

void setup() {
    Serial.begin(115200);
    delay(3000);
    Serial.println("Starting Now...");
    pinMode(22,OUTPUT);
    pinMode(23,OUTPUT);
    pinMode(24,OUTPUT);
    pinMode(25,OUTPUT);
    pinMode(26,OUTPUT);
    pinMode(27,OUTPUT);
    pinMode(28,OUTPUT);
    pinMode(29,OUTPUT);
    currGrade = 'E';
    setGrade(currGrade);
    delay(1000);
    randomSeed(analogRead(A0));
}

void loop() {
    Serial.println();
    Serial.print("Iteration Number ");
    Serial.println(++iteration);
    Serial.print("Grade was ");
    Serial.println(currGrade);
    nextGrade = gradeGot[random(5)];
    while(nextGrade == currGrade)nextGrade = gradeGot[random(5)];
    Serial.print("Grade Setting to ");
    Serial.println(nextGrade);
    delay(500);
    setGrade(nextGrade);
    currGrade = nextGrade;
    delay(500);
}

