#include <SoftwareSerial.h>

SoftwareSerial mySerial(10, 11); // RX, TX


float weigh;
int array[15];
unsigned long int count =0 ,mean, T_weigh =0,count1,arr,Weight,x,y;
int i,j;
void setup() {
  Serial.begin(9600);
  mySerial.begin(9600);

}

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
