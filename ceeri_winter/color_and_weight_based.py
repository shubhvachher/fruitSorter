"""
Computer used as a brain to collect and process information based on color and weight of the Sweet Lime on the conveyer and send final command to arduino.

The weight is recorded by the arduino, sent across to the computer via serial.
When a weight reading comes in, the computer takes a picture via the USB camera and finds the hue of the Sweet Lime in the image.
Now that the computer has both the hue as well as the weight of the fruit, it sends the signal to the arduino to actuate the proper basket's solinoid according to predefined rules.

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

def colorWeightBasedGrading(threadPrev=None, filenn="TestradBasedGrading", imagerDelay=1.5,camera=False, A=[50, 62.5], B=[62.5, 68.5], C=[68.5, 75], convFactor=2.34):
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
			print(filenn) #Prints name of file where image taken is being saved
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
