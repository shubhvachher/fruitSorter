# coding: utf-8
import cv2
image = cv2.imread('1.bmp')
image_bw = cv2.cvtColor(image,cv2.COLOR_BGR2GRAY)
circ = cv2.HoughCircles(image_bw,cv2.HOUGH_GRADIENT,1.2,100,minRadius=50,maxRadius=300)
print(circ)
x,y,r=circ[0][0]
x=int(x)
y=int(y)
r=int(r)
caaa = image.copy()
cv2.circle(caaa,(x,y),r,(0,255,0))
cv2.imshow("test",caaa)
cv2.waitKey(5000)
