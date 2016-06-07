"""
Computer Control of Online Fruit Sorting System
===============================================
Controller that acts to take inputs from various devices through an arduino. Act on the inputs in the form of image taking.
Processes the image taken and grades the fruit in the image based on set criteria.
Results are sent back to the Arduino board for handling of the sorting table positions.

See https://github.com/shubhvachher/fruitSorter for the project.
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
def takeImage(camPort = 1, ramp_frames = 30, verbosity = 0):
	"""Returns an image taken from the camera at camPort"""
	camera = cv2.VideoCapture(camPort)
	for i in range(ramp_frames):
		temp = camera.read()
	if verbosity>0:
		print("Taking image now.")
	retval, image = camera.read()
	del(camera)
	return image

def sizeProcessing(image, A=[50, 59.5], B=[60, 62], C=[62.5, 64.5], D=[65, 75], convFactor=2, thresh1=10, thresh2=245):
	"""
	Returns grade of image based on its size(diameter) as well as fruit radius.

	Grade sizes are entered in A,B,C,D in list form.
	convFactor is the factor the list's numbers are multiplied with to convert their dimensions to pixels.
	"""
	A = A*convFactor
	B = B*convFactor
	C = C*convFactor
	D = D*convFactor

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
	center,rad=cv2.minEnclosingCircle(pointForm)
	center = tuple(np.roll(center,1))
	#image Processing ends

	if(A[0]<=rad<=A[1]):
		return ('A',rad)
	elif(B[0]<=rad<=B[1]):
		return ('B',rad)
	elif(C[0]<=rad<=C[1]):
		return ('C',rad)
	elif(D[0]<=rad<=D[1]):
		return ('D',rad)
	else:
		return ('E',rad)

#Main Program Starts
ImagerDelay=1

while True:
	line_received = fruitSorter.readline().decode().strip()
	if('P' in line_received):
		time.sleep(ImagerDelay)#To wait for the fruit to come under the camera
		print("Taking Image Started...")
		image = takeImage(camPort=0,ramp_frames=10,verbosity=1)
		print("Processing Starts...")
		(grade, rad) = sizeProcessing(image)
		fruitSorter.write(grade.encode())
		if(grade=='A'):
			print("A Reported")
		elif(grade=='B'):
			print("B Reported")
		elif(grade=='C'):
			print("C Reported")
		elif(grade=='D'):
			print("D Reported")
		elif(grade=='E'):
			print("E Reported")
		else:
			print("ERROR! Something went wrong.")
	elif('Quant' in line_received):
		Quants = line_received.split(':')
		print("The Quantities of fruits sorted are : ")
		print("A : " + Quants[1])
		print("B : " + Quants[2])
		print("C : " + Quants[3])
		print("D : " + Quants[4])
		print()
		print("Unknown : " + Quants[5])
	else:
		#print("Unknown Line")
		pass
