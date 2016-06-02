 /*
Here the variables  u,a,b,c,d are used to handle the number of Grade Undefined, Grade A,B,C,D fruits detected.
                    a2,b2,c2,d2 are for setting the sorter back to uts stable position after current fruit is sorted.
                    mechanismDelay(milliseconds) is the amount of time the mechanism takes between giving command to set itself and actually setting properly
                    t is the amount of delay time between imager and sorter and defDelayTime is its default value
                    del(milliseconds) holds the value after which we are sure the fruit has fallen into the right grade basket
                    sort is used to handle incoming fruit grades

                    t must always be greater than mechanismDelay; look at their definitions above.
*/

int u=0, a=0, b=0, c=0, d=0, a2=0, b2=0, c2=0, d2=0;
int defDelayTime=6000, mechanismDelay = 200;
unsigned long t=0;
signed long del=2000;
char sort;

class gate
{
    /*
      a[50] holds the time values for when the sorter mechanism needs to be shifted to a particular grade
      s and e are used to impliment the 'circular - queue' data-structure
    */
    unsigned long a[50];  //This takes up a lot of dynamic memory. More grades, more memory will be taken up.
    int s,e;
public:
    gate()
    {
        s = 0;
        e = 0;

    }
    void push(unsigned long fallTime)
    {
        a[e++] = fallTime;
        e%=50; //Circular queue
    }
    void pop()
    {
        a[s++] = 0;
        s%=50; //Circular queue
    }
    unsigned long rea()
    {
        return(a[s]);
    }
}A, B, C, D;

/*void setGrade(char s)
{
    switch(s)
    {
        case 'A':   //North
            Serial.println("Grade A High");
            digitalWrite(22,HIGH);
            digitalWrite(23,LOW);
            digitalWrite(24,LOW);
            digitalWrite(25,HIGH);
            break;
        case 'B':   //South
            Serial.println("Grade B High");
            digitalWrite(22,LOW);
            digitalWrite(23,HIGH);
            digitalWrite(24,HIGH);
            digitalWrite(25,LOW);
            break;
        case 'C':   //East
        case 'D':   //West
            Serial.println("Grade CD High");
            digitalWrite(22,LOW);
            digitalWrite(23,HIGH);
            digitalWrite(24,LOW);
            digitalWrite(25,HIGH);
            break;
        default:   //stable
            Serial.println("Stable High");
            digitalWrite(22,LOW);
            digitalWrite(23,HIGH);
            digitalWrite(24,LOW);
            digitalWrite(25,HIGH);
    }
    switch(s)
    {
        case 'A': //North
        case 'B': //South
            Serial.println("Grade AB LOW");
            digitalWrite(26,LOW);
            digitalWrite(27,HIGH);
            digitalWrite(28,LOW);
            digitalWrite(29,HIGH);
            break;
        case 'D': //West
            Serial.println("Grade D LOW");
            digitalWrite(26,HIGH);
            digitalWrite(27,LOW);
            digitalWrite(28,LOW);
            digitalWrite(29,HIGH);
            break;
        case 'C': //East
            Serial.println("Grade C LOW");
            digitalWrite(26,LOW);
            digitalWrite(27,HIGH);
            digitalWrite(28,HIGH);
            digitalWrite(29,LOW);
            break;
        default:   //stable
            Serial.println("Stable LOW");
            digitalWrite(26,LOW);
            digitalWrite(27,HIGH);
            digitalWrite(28,LOW);
            digitalWrite(29,HIGH);
    }
}*/

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
    Serial.begin(9600);
    delay(2000);
    Serial.println("Enter delay from imager to sorter if available");
    Serial.print("Waiting...");
    while (millis() < 3000)
    {
        if(Serial.available() > 0)
        {
            t*=10;
            t+=(Serial.read() - 48); //Because Serial.read can read only one byte at a time
        }
    }
    if(t==0)
    {
        t=defDelayTime;
    }
    else
    {
      t*=10; //To convert to milliseconds
    }
    Serial.print("Chosen delay time is : ");
    Serial.print(t);
    Serial.println(" seconds.");
    pinMode(22,OUTPUT);
    pinMode(23,OUTPUT);
    pinMode(24,OUTPUT);
    pinMode(25,OUTPUT);
    pinMode(26,OUTPUT);
    pinMode(27,OUTPUT);
    pinMode(28,OUTPUT);
    pinMode(29,OUTPUT);
    setGrade('E');  //To set it to stable position. Grade 'E' activates default in setGrade()
/*    int pin1=22, pin2=23;
    for(;;)
    {
      delay(1000);
      setGrade('D');
      delay(1000);
      setGrade('C');
      delay(1000);
      setGrade('B');
      delay(1000);
      setGrade('A');
      delay(1000);
      setGrade('E');
      Serial.println(millis());
      if(Serial.available()>0)
      {
        Serial.println("Exiting...");
        break;  
      }  
    }*/
//digitalWrite(22,HIGH);digitalWrite(23,HIGH);digitalWrite(24,HIGH);digitalWrite(25,HIGH);digitalWrite(26,HIGH);digitalWrite(27,HIGH);digitalWrite(28,HIGH);digitalWrite(29,HIGH);
}

void loop() {
    if((Serial.available()>0) && (analogRead(A4)>450))
    {
        Serial.println("entering time into queue");
        while((analogRead(A4)>450))
          while((millis()%10!=0))
            Serial.println(analogRead(A4));
        sort = char(Serial.read());
        switch(sort)  //Used to store the time when the sorting mechanism has to be set to a particular grade
        {
            case 'A': 
                A.push(millis()+t);
                Serial.println("A seviced");
                ++a;
                break;
            case 'B':
                B.push(millis()+t);
                Serial.println("B seviced");
                ++b;
                break;
            case 'C':
                C.push(millis()+t);
                Serial.println("C seviced");
                ++c;
                break;
            case 'D':
                D.push(millis()+t);
                Serial.println("D seviced");
                ++d;
                break;
            default:
                ++u;
                Serial.print("Fruit scanned at t = ");
                Serial.print(millis()/1000);
                Serial.println(" secs doesn't fit into any grade!");
        }
    }
    if(((A.rea() - millis()) < mechanismDelay) && a2==0)  //Check this
    {
        a2 = 1;
        setGrade('A');
    }
    if(((signed long)(millis() - A.rea()) > del) && a2==1)             //Check necessity of a2 variable
    {
        A.pop();
        a2 = 0;
        setGrade('E');                                    //Check if setting to default might affect the state of sorter catering to other fruits
        //Maybe instead of del, use interrupt of when the fruit has falled out of sorter?
    }
    if(((B.rea() - millis()) < mechanismDelay) && b2==0)
    {
        b2 = 1;
        setGrade('B');
    }
    if(((signed long)(millis() - B.rea()) > del) && b2==1)
    {
        B.pop();
        b2 = 0;
        setGrade('E');
    }
    if(((C.rea() - millis()) < mechanismDelay) && c2==0)
    {
        c2 = 1;
        setGrade('C');
    }
    if(((signed long)(millis() - C.rea()) > del) && c2==1)
    {
        C.pop();
        c2 = 0;
        setGrade('E');
    }
    if(((D.rea() - millis()) < mechanismDelay) && d2==0)
    {
        d2 = 1;
        setGrade('D');
    }
    if(((signed long)(millis() - D.rea()) > del) && d2==1)
    {
        D.pop();
        d2 = 0;
        setGrade('E');
    }

    if((millis()%60000) < 5)  //After every 5 minutes, accounting for a 5 millisecond program runtime to get to this if statement
    {
        Serial.println();
        Serial.println();
        Serial.print("After ");
        Serial.print(millis()/3600000);
        Serial.print("hr(s) and ");
        Serial.print((millis()%3600000)/60000);
        Serial.println("mins : ");
        Serial.println();
        Serial.println(" Objects Scanned ");
        Serial.print("GRADE A: ");
        Serial.println(a);
        Serial.print("GRADE B: ");
        Serial.println(b);
        Serial.print("GRADE C: ");
        Serial.println(c);
        Serial.print("GRADE D: ");
        Serial.println(d);
        Serial.print("Unknown : ");
        Serial.println(u);
    }
}

