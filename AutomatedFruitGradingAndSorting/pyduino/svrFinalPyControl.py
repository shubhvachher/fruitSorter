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
def showImage(image, title="Test", waitTime=1000):
	"""Display image and block for  a given waitTime"""
	cv2.imshow(title,image)
	cv2.waitKey(waitTime)
	cv2.destroyWindow(title) #This works only once the next image is shown

def distCalc(pt1,pt2):
	"""Find the geometric distance between two points of the format (x,y)"""
	x1,y1 = pt1
	x2,y2 = pt2
	dist = (((y2-y1)**2)+((x2-x1)**2))**0.5
	return dist

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

def minVarRadius(contour, toShowImg, verbosity=0):
	"""Finds the true center of a convex controur and thus approximates its radius. Uses the math that the array of distances of the center of a circle from all the points on the circle's perimeter will have a statistical variance of zero."""
	image = toShowImg.copy()
	M=cv2.moments(contour)
	cx = M['m10']/M['m00']
	cy = M['m01']/M['m00']
	dx=0
	dy=0
	counter = 0
	if(verbosity>0):
		print("START of center finding")
	while True:
		centroid =(cx+dx,cy+dy)
		cx=centroid[0]
		cy=centroid[1]
		sumRad = 0
		minRadpt = contour[0][0]
		allRad = []
		for i in range(0,len(contour)):
			allRad.append(distCalc(centroid,contour[i][0]))
			sumRad = sumRad+allRad[i]
			if(allRad[i]<distCalc(centroid,minRadpt)):
				minRadpt=contour[i][0]
		std = np.std(allRad)
		if(verbosity>0):
			image = toShowImg.copy()
			cv2.circle(image, (int(centroid[0]),int(centroid[1])), 2, (0,0,255), 2)
			cv2.circle(image, (int(minRadpt[0]),int(minRadpt[1])), 2, (255,0,0), 2)
			showImage(image)
			print(std)

		if(std<7):
			if(verbosity>0):
				print("END")
				time.sleep(3)
			rad = sumRad/len(contour)
			return rad,std
		else: #Update the center here
			dx = 1*std*np.sin(np.arctan2((centroid[0]-minRadpt[0]),(centroid[1]-minRadpt[1])))
			dx = dx+((-1)**np.random.randint(0,2))*4
			dy = 1*std*np.cos(np.arctan2((centroid[0]-minRadpt[0]),(centroid[1]-minRadpt[1])))
			dy = dy+((-1)**np.random.randint(0,2))*4
		counter+=1
		if(counter>20):
			if(verbosity>0):
				print("Counter Exceeded. Ending with radius ZERO.")
			return 0,0

def radFinder(image, verbosity=0):
	"""Given an image of a fruit, it finds the center of the fruit and its radius using any or all of the methods of finding radius via Area of contour or the minVarRadius function."""
	image_bw = cv2.cvtColor(image.copy(), cv2.COLOR_BGR2GRAY)
	th1 = cv2.adaptiveThreshold(image_bw.copy(), 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY_INV, 11, 2)
	image_copy = image.copy()

	radMax = 0
	dpMax =0
	for dp in range(1,10,1):
		if(verbosity>1):
			image = image_copy.copy()
		circ = cv2.HoughCircles(image_bw.copy(), cv2.HOUGH_GRADIENT, dp, minDist = 400, minRadius=100)
		if(circ is not None):
			for c in circ:
				x,y,r =c[0].astype("int")
				if(radMax<r and r<200):
					radMax=r
					dpMax=dp
				if(verbosity>1):
					print(dp)
					cv2.circle(image,(x,y),r,(0,255,0),2)
					showImage(image,title=str(dp),waitTime=500)
		else:
			if(verbosity>1):
				print("Helllo",dp)
	if(verbosity>1):
		image = image_copy.copy()

	circ = cv2.HoughCircles(image_bw.copy(), cv2.HOUGH_GRADIENT, dpMax, minDist = 400, minRadius=100)
	if(circ is not None):
		x,y,r = circ[0,0].astype("int")
		mask = np.zeros(th1.shape)
		for i in range(0,th1.shape[0]):
			for j in range(0,th1.shape[1]):
				dx = i-y
				dy = j-x
				mask[i,j]= ((dx**2)+(dy**2))<=(r+20)**2
				#mask[i,j]= mask[i,j]*(((dx**2)+(dy**2))>=(r-20)**2)  #Untested but should work better
		ans = np.multiply(th1,mask) #This focuses our efforts on the part of the image that is most likely to have a fruit

		if(verbosity>0):
			showImage(ans, title="Masked image", waitTime=5000)

		ans_scaled = cv2.convertScaleAbs(ans.copy())
		a,cnts,b=cv2.findContours(ans_scaled.copy(),cv2.RETR_LIST,cv2.CHAIN_APPROX_SIMPLE)
		max_area=0
		for c in cnts:
		    area=cv2.contourArea(c)
		    if area>max_area:
		        max_area=area
		        best_cnt=c
		areaNormal=cv2.contourArea(best_cnt)
		cv2.drawContours(image,[best_cnt],-1,(0,255,0),2)
		radAreaNormal=(areaNormal/3.14159)**0.5
		radPtsNormal, stdDevNormal = minVarRadius(best_cnt, image, verbosity)
		radPtsNormal = radPtsNormal - (stdDevNormal/2)
		image = image_copy.copy()

		closing = cv2.morphologyEx(ans.copy(), cv2.MORPH_CLOSE, np.ones((3,3),np.uint8))
		closing = cv2.convertScaleAbs(closing)
		a,cnts,b=cv2.findContours(closing.copy(),cv2.RETR_LIST,cv2.CHAIN_APPROX_SIMPLE)
		max_area=0
		for c in cnts:
		    area=cv2.contourArea(c)
		    if area>max_area:
		        max_area=area
		        best_cnt=c

		areaClosed=cv2.contourArea(best_cnt)
		cv2.drawContours(image,[best_cnt],-1,(0,255,0),2)
		radAreaClosed=(areaClosed/3.14159)**0.5
		radPtsClosed, stdDevClosed = minVarRadius(best_cnt, image, verbosity)
		radPtsClosed = radPtsClosed - (stdDevClosed/2)
		image = image_copy.copy()

		if(verbosity>0):
			print("radAreaNormal is",radAreaNormal)
			print("radAreaClosed is",radAreaClosed)
			print("radPtsNormal is",radPtsNormal)
			print("radPtsCent is",radPtsClosed)
			print("stdDecNormal is",stdDevNormal)
			print("stdDevClosed is",stdDevClosed)

		radii = [radAreaNormal, radAreaClosed, radPtsNormal, radPtsClosed]
		radii = [f for f in radii if f>100]
		if(len(radii)>0):
			cv2.destroyAllWindows()
			return np.mean(radii)
		else:
			cv2.destroyAllWindows()
			return -2.34
	else:
		cv2.destroyAllWindows()
		return -2.34


def radiusBasedGrading(threadPrev=None, filenn="TestradBasedGrading", imagerDelay=1.5,camera=False, A=[50, 62.5], B=[62.5, 68.5], C=[68.5, 75], convFactor=2.34):
	"""
	Catures and returns grade of image based on its fruit size(radius).
	Grade sizes are entered in A,B,C in list form. If no match then D(Unknown) is returned.
	convFactor is the factor the A,B,C list's numbers are multiplied with to convert their dimensions to pixels.
	"""
	time.sleep(imagerDelay)
	aaa = time.time()
	image = takeImage(ramp_frames=30, verbosity=0, camera = camera, filenn = filenn)
	#print("Image taking time is", time.time()-aaa)
	aaa = time.time()
	A = np.multiply(A,convFactor)
	B = np.multiply(B,convFactor)
	C = np.multiply(C,convFactor)

	rad = radFinder(image.copy(),verbosity=0)

	if(rad!=-convFactor):
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
			threadPrev.join() #Waits for previous thread to send its grade to the arduino so that the baskets are in sync.
			#prevName=threadPrev.getName()
			#print(prevName,"is done")
		fruitSorter.write(grade.encode())
		cv2.imwrite(str(rad/convFactor)+grade+filenn+".bmp", image)
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
			threadPrev.join() #Waits for previous thread to send its grade to the arduino so that the baskets are in sync.
			#prevName=threadPrev.getName()
			#print(prevName,"is done")
		print("ERROR! No fruit DETECTED in this basket",filenn)
		grade = 'D'
		print("Sending to D")
		fruitSorter.write(grade.encode())
		cv2.imwrite("U"+filenn+".bmp", image)
	#if(threadPrev):
	#	print(prevName,"plus 1 finished in time", time.time()-aaa)
	#else:
	#	print("thread 1 finished in time ", time.time()-aaa)


if __name__ == '__main__':
	timingUtility=0
	threadPrev=None #Previous Thread
	threadNow=None #Thread to start now
	imagerDelay=3.2 #Used to fine tune the position of the fruit on the conveyer when image is taken.
	filenn="0" #Used to store the images taken in the same folder as where the code is run from
	camera = cv2.VideoCapture(0)
	print("Sleeping now")
	time.sleep(5)
	dump = fruitSorter.flushInput() #Clear Serial input from arduino
	print("GO")
	while True:
		#print("TOP")
		timingUtility=time.time()
		line_received = fruitSorter.readline().decode().strip()
		#print("Line Waiting time is ",time.time()-timingUtility)
		print(line_received)
		if('P' in line_received):
			filenn = str(int(filenn)+1)
			print(filenn)
			#print("Processing Starts...")
			threadNow = threading.Thread(target = radiusBasedGrading, args = (threadPrev,filenn,imagerDelay,camera))
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
