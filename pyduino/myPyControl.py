import serial
import time
import cv2
import numpy as np
import matplotlib.pyplot as plt

#Time between fruit position detection and image taking in seconds
ImagerDelay = 1
#Threshold Values. Highly Image dependant.
thresh1=100
thresh2=200
#Grading Parameters in millimeters
A = [50,59.5]
B = [60,62]
C = [62.5,64.5]
D = [65,75]

#Converting pixels to millimeters. pixels = milli*convFactor
convFactor = 2

A = A*convFactor
B = B*convFactor
C = C*convFactor
D = D*convFactor

ardDir = input("Enter the directory of your board : ")
bRate = input("Enter the baud rate for serial comm. : ")

fruitSorter = serial.Serial(port=ardDir, baudrate=bRate, timeout=5)
time.sleep(5);
while True:
	#print("Waiting for line...")
	line_received = fruitSorter.readline().decode().strip()
	#print(line_received)
	if('P' in line_received):
		time.sleep(ImagerDelay)
		# Camera 1 is the external webcam
		camera_port = 0
		#Number of frames to throw away while the camera adjusts to light levels
		ramp_frames = 30
		camera = cv2.VideoCapture(camera_port)
		for i in range(ramp_frames):
			temp = camera.read()
		print("Taking image...")
		retval, image = camera.read()
		del(camera)

		#image Processing starts
		image_bw = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
		img = cv2.Canny(image_bw,threshold1=thresh1,threshold2=thresh2)
		pointForm=[[],[]]
		for i in range(0,len(img)):
		    for j in range(0,len(img[i])):
		        if(img[i][j]>150):
		            pointForm[0].append(i)
		            pointForm[1].append(j)

		pointForm=np.transpose(pointForm)
		pointForm = np.array(pointForm)
		center,rad=cv2.minEnclosingCircle(pointForm)
		center = tuple(np.roll(center,1))
		#image Processing ends

		if(A[0]<=rad<=A[1]):
			fruitSorter.write('A'.encode())
			print("A Reported")
		elif(B[0]<=rad<=B[1]):
			fruitSorter.write('B'.encode())
			print("B Reported")
		elif(C[0]<=rad<=C[1]):
			fruitSorter.write('C'.encode())
			print("C Reported")
		elif(D[0]<=rad<=D[1]):
			fruitSorter.write('D'.encode())
			print("D Reported")
		else:
			fruitSorter.write('E'.encode())
			print("E Reported")
	elif('Quant' in line_received):
		Quants = line_received.split(':')
		print("The Quantities of fruits sorted are : ")
		print("A : " + Quants[1])
		print("B : " + Quants[2])
		print("C : " + Quants[3])
		print("D : " + Quants[4])
		print("Unknown : " + Quants[5])
	else:
		#print("Unknown Line")
		pass
