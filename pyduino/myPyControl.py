import serial
import time
import cv2
import numpy as np
import matplotlib.pyplot as plt

#Time between fruit position detection and image taking
ImagerDelay = 1
#Threshold Values. Highly Image dependant.
thresh1=100
thresh2=200
#Grading Parameters
A = [100,119]
B = [120,124]
C = [125,129]
D = [130,150]

ardDir = input("Enter the directory of your board : ")

fruitSorter = serial.Serial(port=ardDir, baudrate=9600, timeout=5)

while True:
	print("Waiting for line")
	line_received = fruitSorter.readline().decode().strip()
	print(line_received)
	if('P' in line_received):
		time.sleep(seconds=ImagerDelay)
		# Camera 1 is the external webcam
		camera_port = 1
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
			fruitSorter.write("A")
		elif(B[0]<=rad<=B[1]):
			fruitSorter.write("B")
		elif(C[0]<=rad<=C[1]):
			fruitSorter.write("C")
		elif(D[0]<=rad<=D[1]):
			fruitSorter.write("D")
		else:
			fruitSorter.write("E")
	elif('Quant' in line_received):
		Quants = line_received.split(':')
		print("The Quantities of fruits sorted are : ")
		print("A : " + Quants[1])
		print("B : " + Quants[2])
		print("C : " + Quants[3])
		print("D : " + Quants[4])
		print("Unknown : " + Quants[5])
	else:
		print("Unknown Line")
