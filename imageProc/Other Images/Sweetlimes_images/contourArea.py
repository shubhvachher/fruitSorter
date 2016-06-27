import numpy as np
import matplotlib.pyplot as plt
import cv2

def distCalc(pt1,pt2):       #calculation of sistance from centroid to point on the edge of the contour.
    x1,y1=pt1
    x2,y2=pt2
    dist = (((y2-y1)**2)+((x2-x1)**2))**0.5
    return dist

filename=input("Please Enter the filename : ")
image = cv2.imread(filename)

image_bw = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
img = cv2.Canny(image_bw,10,245)

a=[[],[]]      #Getting the points on the edge of the contour.
for i in range(0,len(img)):
    for j in range(0,len(img[i])):
        if(img[i][j]>150):
            a[0].append(i)
            a[1].append(j)

a=np.transpose(a)
a = np.array(a)
center,rad=cv2.minEnclosingCircle(a)    #Getting the minimum enclosing circle so that we can get the radius of the fruits that have an opened contour.
center = tuple(np.roll(center,1))
fig,ax=plt.subplots(1,1)
ax.imshow(image_bw)
circ=plt.Circle(center,rad,fill=False)
ax.add_patch(circ)
plt.show()

im,contours,hierarchy=cv2.findContours(img,cv2.RETR_CCOMP,cv2.CHAIN_APPROX_SIMPLE)
cnt=contours[0]
M=cv2.moments(cnt)
cx=M['m10']/M['m00']
cy=M['m01']/M['m00']
centroid=(cx,cy)



sumRad = 0
allRad = []
for i in range(0,len(a)):
    sumRad = sumRad + distCalc(centroid,a[i])
    allRad.append(distCalc(centroid,a[i]))
radFinal = sumRad/len(a) #calculation of the average radius of fruits.

kernel = np.ones((5,5),np.uint8)
closing = cv2.morphologyEx(image,cv2.MORPH_CLOSE,kernel)
new_image_bw = cv2.cvtColor(closing,cv2.COLOR_BGR2GRAY)
new_img = cv2.Canny(new_image_bw,100,200)
new_img=cv2.convertScaleAbs(new_img)
im1,contours1,hierarchy1=cv2.findContours(new_img,cv2.RETR_CCOMP,cv2.CHAIN_APPROX_SIMPLE)
cnt1=contours1[0]
area1=cv2.contourArea(cnt1) #calculation of area of the contour
r1=(area1/3.14159)**0.5


print("radius of minimum Enclosing Circle = " + str(rad))
im,contours,hierarchy=cv2.findContours(img,cv2.RETR_CCOMP,cv2.CHAIN_APPROX_SIMPLE)
if  (hierarchy1[0][0][2]<0): #if the contour obtained from Canny is open,we take the radius as the average radius that we calculated from the centroid to the points on the edges.
        avg_rad = radFinal

else: #if the contour is closed we take the radius as the average of the radius obtained from area calculation and the average radius obtained from centroid.
        avg_rad = (r1 + radFinal)*0.5



print("area calc radius = " + str(r1))
print("radFinal = "+ str(radFinal))
print("average radius of the fruit is " + str(avg_rad))
