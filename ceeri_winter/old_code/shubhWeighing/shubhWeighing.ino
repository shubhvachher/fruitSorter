/*
 * Our weighing machine gives a wave output. The frequency of this wave has a linear realtion wrt to weight on the weighing machine's scale.
 * Conversion between wave frequency and weight of object on scale is done using convFactor after the zero error has been subtracted out.
 * readInterval refers to the interval for which the number of peaks in the incoming wave is calculated. This is used then to calculate wave frequency.
 * fruitWeights is used as a curcular array and it will hold at max the weights of the previous 50 fruits.
 * fruitCount refers to the number of fruits that have been indexed as the program proceeds.
 */

#include <FreqCount.h>

float convFactor = (1/19.3); 
unsigned long zeroError = 0, zeroThreshold=1000;

int readInterval = 100;
float intervalFactor = (1000/readInterval);
float fruitWeights[50];
int fruitCount=0;

float mean(float total, int count) 
{
  
  if (count==0)
  {
    return 0;
  }
  return ((float)total / (float)count);
}

float stddev(float arr[50], float total, int count) 
{
  if(count==0)
  {
    return 0;
  }
  float mn = mean(total,count);
  float diff=0;
  float sumSq=0;
  int i;
  for(i=0;i<count;i++)
  {
    diff = arr[i]-mn;
    sumSq += (diff*diff);
  }
  return(sqrt((float)sumSq/(float)(count-1)));
}


float readNReturn()
{
  int count = 0;
  unsigned long readNow;
  float allRead[50], totalRead=0, mn=0, stdd=0;
  float properTotal=0;
  int properCount=0;
  delay(readInterval+20);//To allow for a new value of frequency to be available
  readNow = FreqCount.read();
  readNow = readNow*intervalFactor;
  while(readNow>zeroError)
  {
    //Serial.print("subCount : ");
    //Serial.println(count);
    //Serial.print("Normally read : ");
    //Serial.println(readNow);
    readNow = readNow-zeroError+zeroThreshold;
    readNow = (float)readNow;
    readNow = readNow*convFactor;
    //Serial.print("Weight calculated : ");
    //Serial.println(readNow);
    if(count>3)
    {
      totalRead+=readNow;
      allRead[(count-4)%50]=readNow;
    }
    count+=1;
    delay(readInterval+20);
    readNow=FreqCount.read();
    readNow=readNow*intervalFactor;
  }
  count = count-4;
  if(count>50) //To calculate the average of values in circular array properly
    count=50;
  mn = mean(totalRead,count);
  stdd = stddev(allRead,totalRead,count);
  //Serial.println(stdd);
  //Serial.println("Actual");
  for(int i=0;i<count;i++)
  {
    if(allRead[i]>(mn-stdd) && allRead[i]<(mn+stdd))
    {
      //Serial.println(allRead[i]);
      properTotal += allRead[i];
      properCount+=1;
    }
  }
  return(properTotal/properCount);
}

void setup()
{
  Serial.begin(9600);
  FreqCount.begin(readInterval);
  delay(2000);
  if(FreqCount.available())
  {
    zeroError = FreqCount.read();
    zeroError = zeroError*intervalFactor;
    Serial.println(zeroError);
    delay(readInterval+20);
    int zc2=zeroError;
    if(FreqCount.available())
    {
      zc2 = FreqCount.read();
      zc2 = zc2*intervalFactor;
      Serial.println(zc2);
    }
    zeroError = (zeroError+zc2)/2;
  }
  zeroError = zeroError+zeroThreshold; //Threshold is to allow for minor variations in the scale balance
  Serial.print("Beginning : ");
  Serial.println(zeroError);
}

void loop()
{
  unsigned long readValue=0;
  if(FreqCount.available())
  {
    readValue = FreqCount.read();
    readValue = readValue*intervalFactor;
    //Serial.println(readValue);
    if(readValue>zeroError) //If the balance is offset by a value greater than the zeroError threshold value, i.e, a fruit is present on the weighing scale
    {
      //Serial.println("Start service");
      fruitWeights[fruitCount%50]=readNReturn();
      //if(fruitWeights[fruitCount]!=0);
      fruitCount+=1;
      Serial.print("Weight Found ");
      Serial.print(fruitCount);
      Serial.print(" : ");
      Serial.println(fruitWeights[(fruitCount-1)%50]);
      //Serial.println(millis());
    }
  }
}

