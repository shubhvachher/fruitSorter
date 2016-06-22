# coding: utf-8
import cv2
image = cv2.imread('12.bmp')
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
#blurred = cv2.GaussianBlur(gray,(5,5),0)
blurred = gray
thresh = cv2.threshold(blurred,125,255,cv2.THRESH_BINARY)[1]
cnts = cv2.findContours(thresh.copy(),cv2.RETR_EXTERNAL,cv2.CHAIN_APPROX_SIMPLE)
cnts = cnts[1]
b=[]
for i in range(0,len(cnts)):
    if(len(cnts[i])>10):
        b.append(cnts[i])

maxM = []
maxM.append(b[0].copy())
maxM.append(cv2.moments(b[0]).copy())

for c in b:
    M = cv2.moments(c)
    if(M["m00"]>maxM[1]["m00"]):
        maxM[0]=c.copy()
        maxM[1]=M.copy()
"""
M = maxM[1]
c = maxM[0]
# compute the center of the contour
cX = int(M["m10"] / M["m00"])
cY = int(M["m01"] / M["m00"])
# draw the contour and center of the shape on the image
cv2.drawContours(image, [c], -1, (0, 255, 0), 2)
cv2.circle(image, (cX, cY), 7, (255, 255, 255), -1)
print(M["m00"])
cv2.putText(image, "center", (cX - 20, cY - 20),cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 255), 2)
# show the image
cv2.imshow("Image", image)
cv2.waitKey(100)
"""
points = maxM[0]
minx=points[0][0][0]
miny=points[0][0][1]
maxx=points[0][0][0]
maxy=points[0][0][1]
for i in range(0,len(points)):
    if(maxx<points[i][0][0]):
        maxx=points[i][0][0]
    if(maxy<points[i][0][1]):
        maxy=points[i][0][1]
    if(minx>points[i][0][0]):
        minx=points[i][0][0]
    if(miny>points[i][0][1]):
        miny=points[i][0][1]

cropped = image[miny:maxy,minx:maxx]
image_bw = cv2.cvtColor(cropped,cv2.COLOR_BGR2GRAY)
circ = cv2.HoughCircles(image_bw,cv2.HOUGH_GRADIENT,2,100,minRadius=50,maxRadius=200)
circ = circ[0]
for i in circ:
    x,y,r = i.astype(int)
    cv2.circle(image2,(x,y),r,(0,255,0))

cv2.imshow("test",image2)
cv2.waitKey(500)
