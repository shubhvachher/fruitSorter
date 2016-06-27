# coding: utf-8
import numpy as np
import matplotlib.pyplot as plt
import cv2
filename=input("Please Enter the filename : ")
image = cv2.imread(filename)
image_bw = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
img = cv2.Canny(image_bw,100,200)
a=[[],[]]
for i in range(0,len(img)):
    for j in range(0,len(img[i])):
        if(img[i][j]>150):
            a[0].append(i)
            a[1].append(j)

a=np.transpose(a)
a = np.array(a)
center,rad=cv2.minEnclosingCircle(a)
center = tuple(np.roll(center,1))
fig,ax=plt.subplots(1,1)
ax.imshow(image_bw)
circ=plt.Circle(center,rad,fill=False)
ax.add_patch(circ)
plt.show()
