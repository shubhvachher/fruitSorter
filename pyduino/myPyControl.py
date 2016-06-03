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
A = [100,120]
B = [120,125]
C = [125,130]
D = [130,150]

fruitSorter = serial.Serial(port='/dev/ttyAC*', baudrate=9600, timeout=5)

while True:
	line_received = fruitSorter.readline().decode().strip()
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
