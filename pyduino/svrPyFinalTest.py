"""
Computer Control of Online Fruit Sorting System
===============================================
Controller that acts to take inputs from PhotoElectric Sensor through an Arduino; Take an image when the trigger arives; Process the image to get the grade of the imaged fruit; Send the grade back to the Arduino.

Processes the image taken and grades the fruit in the image based on criteria that need to be set.
See https://github.com/shubhvachher/fruitSorter for the complete project.
"""
import serial
import time
import cv2
import numpy as np
import threading

#Setup
ardDir = input("Enter the directory of your board : ")
bRate = input("Enter the baud rate for serial comm. : ")

fruitSorter = serial.Serial(port=ardDir, baudrate=bRate, timeout=5)
time.sleep(5); #To allow serial connection to stabilise.

#Funtion Definitions
def showImage(image, title="Test"):
	cv2.imshow(title,image)
	cv2.waitKey(30)
	cv2.destroyWindow(title)

def takeImage(ramp_frames = 30, verbosity = 0, camera = False, filenn = "takeImageTest"):
	"""Returns an image taken from the cv2.VideoCapture() camera object"""
	temp1=0
	if(not camera):
		camera = cv2.VideoCapture(0)
		temp1=1
	for i in range(ramp_frames):
		temp = camera.read()
	if verbosity>0:
		print("Taking image now.")
	retval, image = camera.read()
	#cv2.imwrite(filenn+".bmp", image)
	showImage(image, "image"+filenn)
	if(temp1==1):
		del(camera) #Cleanup
	return image

def radFinder(image):
	"""Given an image of a fruit, it finds the center of the fruit and its radius."""
	image_bw = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
	th1 = cv2.adaptiveThreshold(image_bw, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY_INV, 11, 2)
	image2 = image.copy()

	radMax = 0
	dpMax =0
	for dp in range(1,10,1):
		image = image2.copy()
		circ = cv2.HoughCircles(th1, cv2.HOUGH_GRADIENT, dp, minDist = 400, minRadius=100)
		if(circ is not None):
			for c in circ:
				x,y,r =c[0].astype("int")
				cv2.circle(image,(x,y),r,(0,255,0),2)
				if(radMax<r):
				    radMax=r
				    dpMax=dp
	            #time.sleep(1)
	        #print(dp)
	        #plt.imshow(image)
			#plt.show()e
		else:
			#print("Helllo",dp)
			pass
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
	    #plt.imshow(th1)
	    #plt.figure(2)
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
	    radFinal=-2.15
	return radFinal

def radiusBasedGrading(image, threadPrev=None, filenn="TestradBasedGrading", A=[50, 62], B=[62, 66], C=[67, 75], convFactor=2.15):
	"""
	Returns grade of image based on its fruit size(radius).
	Grade sizes are entered in A,B,C in list form. If no match then D(Unknown) is returned.
	convFactor is the factor the A,B,C list's numbers are multiplied with to convert their dimensions to pixels.
	"""
	aaa = time.time()
	A = np.multiply(A,convFactor)
	B = np.multiply(B,convFactor)
	C = np.multiply(C,convFactor)

	rad = radFinder(image)

	if(rad!=-2.15):
		if(A[0]<=rad<=A[1]):
			grade = 'A'
		elif(B[0]<=rad<=B[1]):
			grade = 'B'
		elif(C[0]<=rad<=C[1]):
			grade = 'C'
		else:
			grade = 'D'

		prevName = "NONE"
		if(threadPrev):
			threadPrev.join() #Waits for previous thread to send the grade before this thread sends.
			prevName=threadPrev.getName()
			#print(prevName,"is done")
		fruitSorter.write(grade.encode())
		cv2.imwrite(grade+filenn+".bmp", image)
		if(grade=='A'):
			pass
			print("A Reported",filenn)
		elif(grade=='B'):
			pass
			print("B Reported",filenn)
		elif(grade=='C'):
			pass
			print("C Reported",filenn)
		elif(grade=='D'):
			pass
			print("D Reported",filenn)
		else:
			print("ERROR! Something went wrong.",filenn)
	else:
		if(threadPrev):
			threadPrev.join()
			prevName=threadPrev.getName()
			#print(prevName,"is done")
		print("No fruit in this basket",filenn)
		cv2.imwrite("U"+filenn+".bmp", image)
	#if(threadPrev):
	#	print(prevName,"plus 1 finished in time", time.time()-aaa)
	#else:
	#	print("thread 1 finished in time ", time.time()-aaa)


if __name__ == '__main__':
	timingUtility=0
	threadPrev=None #Previous Thread
	threadNow=None #Thread to start now
	ImagerDelay=1.2 #Used to fine tune the position of the fruit on the conveyer when image is taken.
	filenn="0"
	camera = cv2.VideoCapture(1)
	print("Sleeping now")
	time.sleep(5)
	dump = fruitSorter.flushInput() #Clear Serial input from arduino
	while True:
		#print("TOP")
		timingUtility=time.time()
		line_received = fruitSorter.readline().decode().strip()
		#print("Line Waiting time is ",time.time()-timingUtility)
		print(line_received)
		if('P' in line_received):
			time.sleep(ImagerDelay) #To wait for the fruit to come under the camera
			filenn = str(int(filenn)+1)
			print(filenn)
			#print("Taking Image Started...")
			timeTrackInternal = time.time()
			image = takeImage(ramp_frames=10, verbosity=0, camera = camera, filenn = filenn)
			#print("Image taking time is", time.time()-timeTrackInternal)
			#print("Processing Starts...")
			threadNow = threading.Thread(target = radiusBasedGrading, args = (image,threadPrev,filenn))
			#print("starting Thread",threadNow.getName())
			threadNow.start()
			threadPrev = threadNow
		elif('Quant' in line_received):
			Quants = line_received.split(':')
			print("The Quantities of fruits sorted are : ")
			print("A : " + Quants[1])
			print("B : " + Quants[2])
			print("C : " + Quants[3])
			print()
			print("Unknown : " + Quants[4])
		else:
			#print("Unknown Line")
			pass
		#print("Total time in loop is : ",time.time()-timingUtility)
