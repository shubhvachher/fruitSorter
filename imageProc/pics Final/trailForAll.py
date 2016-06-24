import cv2
import numpy as np
import matplotlib.pyplot as plt
import time
arrayOfAnswers=[]
arrayOfTimes=[]
for blah in range(1,44):
	aaa = time.time()
	print(blah)
	image = cv2.imread(str(blah)+".bmp")
	image_bw = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
	retval, threshimg = cv2.threshold(image_bw,0,255,cv2.THRESH_BINARY+cv2.THRESH_OTSU)
	th1 = cv2.adaptiveThreshold(image_bw, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY_INV, 11, 2)
	image2 = image.copy()

	radMax = 0
	dpMax =0
	for dp in range(1,10,1):
	    #image = image2.copy()
	    circ = cv2.HoughCircles(th1, cv2.HOUGH_GRADIENT, dp, minDist = 400, minRadius=100)
	    if(circ is not None):
	        for c in circ:
	            x,y,r =c[0].astype("int")
	            #cv2.circle(image,(x,y),r,(0,255,0),2)
	            if(radMax<r):
	                radMax=r
	                dpMax=dp
	            #time.sleep(1)
	        #print(dp)
	        #plt.imshow(image)
	        #plt.show()
	    else:
	        print("Helllo",dp)

	circ = cv2.HoughCircles(th1, cv2.HOUGH_GRADIENT, dpMax, minDist = 400, minRadius=100)
	if(circ is not None):
	    x,y,r = circ[0,0].astype("int")

	    mask = np.zeros((480,640))
	    for i in range(0,480):
	        for j in range(0,640):
	            dx = i-y
	            dy = j-x
	            mask[i,j]= ((dx**2)+(dy**2))<=(r+20)**2

	    ans = np.multiply(th1,mask)
	    #plt.figure(1)
	    #plt.imshow(threshimg)
	    #plt.figure(2)
	    #plt.imshow(th1)
	    #plt.figure(3)
	    #plt.imshow(ans)
	    #plt.show()
	else:
	    r=-1

	image = image2.copy()
	ans1=ans.copy()
	ans1 = cv2.convertScaleAbs(ans1)
	a,cnts,b=cv2.findContours(ans1,cv2.RETR_LIST,cv2.CHAIN_APPROX_SIMPLE)
	max_area=0
	for c in cnts:
	    area=cv2.contourArea(c)
	    if area>max_area:
	        max_area=area
	        best_cnt=c

	M=cv2.moments(best_cnt)
	a1=cv2.contourArea(best_cnt)
	image2=image.copy()
	cv2.drawContours(image2,[best_cnt],-1,(0,255,0),2)
	#plt.imshow(image2)
	#plt.show()
	r1=(a1/3.14159)**0.5
	closing = cv2.morphologyEx(ans.copy(), cv2.MORPH_CLOSE, np.ones((3,3),np.uint8))
	closing = cv2.convertScaleAbs(closing)
	a,cnts,b=cv2.findContours(closing.copy(),cv2.RETR_LIST,cv2.CHAIN_APPROX_SIMPLE)
	max_area=0
	for c in cnts:
	    area=cv2.contourArea(c)
	    if area>max_area:
	        max_area=area
	        best_cnt=c

	M=cv2.moments(best_cnt)
	a2=cv2.contourArea(best_cnt)
	image2=image.copy()
	cv2.drawContours(image2,[best_cnt],-1,(0,255,0),2)
	#plt.imshow(image2)
	#plt.show()
	r2=(a2/3.14159)**0.5

	if(r1>100 and r2>100):
	    radFinal = (r1+r2)/2
	elif(r1>100):
	    radFinal=r1
	elif(r2>100):
	    radFinal=r2
	else:
	    radFinal=-1
	#print(radFinal)
	print(radFinal/2.15)
	arrayOfTimes.append(time.time()-aaa)
	arrayOfAnswers.append(radFinal/2.15)
