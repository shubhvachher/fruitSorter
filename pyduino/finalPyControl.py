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

#Setup
ardDir = input("Enter the directory of your board : ")
bRate = input("Enter the baud rate for serial comm. : ")

fruitSorter = serial.Serial(port=ardDir, baudrate=bRate, timeout=5)
time.sleep(5); #To allow serial connection to stabilise.

#Funtion Definitions
def takeImage(ramp_frames = 30, verbosity = 0, camPort = None):
	"""Returns an image taken from the camera at camPort"""
	if(camPort):
		camera = cv2.VideoCapture(camPort)
	for i in range(ramp_frames):
		temp = camera.read()
	if verbosity>0:
		print("Taking image now.")
	retval, image = camera.read()
	cv2.imshow("image",image)
	cv2.waitKey(30)
	if(camPort):
		del(camera)
	return image

def sizeProcessing(image, A=[50, 59.5], B=[60, 62], C=[62.5, 64.5], convFactor=2, thresh1=10, thresh2=245):
	"""
	Returns grade of image based on its size(diameter) as well as fruit radius.
	Grade sizes are entered in A,B,C in list form. If no match then D(Unknown) is returned.
	convFactor is the factor the list's numbers are multiplied with to convert their dimensions to pixels.
	"""
	A = A*convFactor
	B = B*convFactor
	C = C*convFactor

	#image Processing starts
	image_bw = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
	edge = cv2.Canny(image_bw,threshold1=thresh1,threshold2=thresh2)
	pointForm=[[],[]]
	for i in range(0,len(edge)):
		for j in range(0,len(edge[i])):
			if(edge[i][j]>150):
				pointForm[0].append(i)
				pointForm[1].append(j)

	pointForm=np.transpose(pointForm)
	pointForm = np.array(pointForm)
	if(len(pointForm)!=0):
		center,rad=cv2.minEnclosingCircle(pointForm)
	else:
		center =(1,2)
		rad=60
	center = tuple(np.roll(center,1))
	#image Processing ends

	if(A[0]<=rad<=A[1]):
		return ('A',rad)
	elif(B[0]<=rad<=B[1]):
		return ('B',rad)
	elif(C[0]<=rad<=C[1]):
		return ('C',rad)
	else:
		return ('D',rad)

#Main Program Starts
ImagerDelay=0.1
mmm=0
camera = cv2.VideoCapture(0)
print("Sleeping now")
time.sleep(5)
dump = fruitSorter.flushInput()
while True:
	print("TOP")
	mmm=time.time()
	line_received = fruitSorter.readline().decode().strip()
	print("Line Waiting time is ",time.time()-mmm)
	#mmm=time.time()
	#print("Printing line now...")
	print(line_received)
	if('P' in line_received):
		time.sleep(ImagerDelay)#To wait for the fruit to come under the camera
		#print("Taking Image Started...")
		aaa = time.time()
		image = takeImage(camPort=0,ramp_frames=1,verbosity=1)
		print("Image taking time is", time.time()-aaa)
		#print("Processing Starts...")
		aaa=time.time()
		(grade, rad) = sizeProcessing(image)
		print("Processing time is ", time.time()-aaa)
		#aaa=time.time()
		fruitSorter.write(grade.encode())
		#print("Writing time is ",time.time()-aaa)
		if(grade=='A'):
			print("A Reported")
		elif(grade=='B'):
			print("B Reported")
		elif(grade=='C'):
			print("C Reported")
		elif(grade=='D'):
			print("D Reported")
		else:
			print("ERROR! Something went wrong.")
			print(rad, grade)
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
	print("Total time in loop is : ",time.time()-mmm)
