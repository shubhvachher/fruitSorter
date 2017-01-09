"""
Computer used as the brain to collect and process information based on color and weight of the Sweet Lime on the conveyer and send final command to arduino.

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
import matplotlib.pyplot as plt #Used only with high verbosity

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


def hueFinder(image, verbosity=0):
	"""Given an image of a fruit, it finds the center of the fruit and draws a radius from the center to approximate the hue."""
	image_bw = cv2.cvtColor(image.copy(), cv2.COLOR_BGR2GRAY)
	th1 = cv2.adaptiveThreshold(image_bw.copy(), 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY_INV, 11, 2)
	image_copy = image.copy()

	radMin = 999
	dpMin =0
	for dp in range(1,10,1):
		if(verbosity>1):
			image = image_copy.copy()
		circ = cv2.HoughCircles(image_bw.copy(), cv2.HOUGH_GRADIENT, dp, minDist = 400, minRadius=80)
		if(circ is not None):
			for c in circ:
				x,y,r =c[0].astype("int")
				if(radMin>r and r<200):
					radMin=r
					dpMin=dp
				if(verbosity>1):
					print(dp)
					cv2.circle(image,(x,y),r,(0,255,0),2)
					showImage(image,title=str(dp),waitTime=500)
		else:
			if(verbosity>1):
				print("Helllo",dp)
	if(verbosity>1):
		image = image_copy.copy()

	circ = cv2.HoughCircles(image_bw.copy(), cv2.HOUGH_GRADIENT, dpMin, minDist = 400, minRadius=80)

	if(circ is not None):
		imageHSV = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
		x,y,r = circ[0,0].astype("int")
		print(radMin)
		if(radMin>110):
			radMin=70
		hues = []
		values = []
		imageMasked = np.zeros(imageHSV.shape[:2])
		for i in range(0,imageHSV.shape[0]):
			for j in range(0,imageHSV.shape[1]):
				dx = i-y
				dy = j-x
				if (((dx**2)+(dy**2)) <= (radMin-10)**2) and imageHSV[i][j][0]<60 and imageHSV[i][j][0]>23:
					imageMasked[i][j]=imageHSV[i][j][0]
					#if(imageHSV[i][j][2]<200):
					hues.append(imageHSV[i][j][0])
					values.append(imageHSV[i][j][2])

		if(verbosity>0):
			# showImage(imageMasked, title="Masked Image", waitTime = 5000)
			plt.imshow(imageMasked)
			plt.colorbar()
			plt.show()

		return ("GREEN" if (0.26307*np.mean(values) + (-1.76579)*np.mean(hues))<(-0.00985) else "YELLOW", np.mean(hues), np.mean(values))

	else:
		cv2.destroyAllWindows()
		return ("UNKNOWN",-1,-1)

def colorWeightBasedGrading(threadPrev=None, filenn="TestradBasedGrading", imagerDelay=1.5,camera=False, weightGot=210, weightCutoff = 200):
	"""
	Catures and returns grade of image based on the fruits weight and color.

	Grades are defined as :
	Heavy Yellow fruit is grade 'A'
	Light Yellow fruit, Heavy Green fruit and Heavy Yellow fruit is B

	Heavy or Light is defined via weightCutoff variable
	"""
	time.sleep(imagerDelay)
	aaa = time.time()
	image = takeImage(ramp_frames=60, verbosity=0, camera = camera, filenn = filenn)
	#print("Image taking time is", time.time()-aaa)
	aaa = time.time()

	hueVal = hueFinder(image.copy(),verbosity=0)
	hue = hueVal[0]

	weightGot = "HEAVY" if weightGot>=weightCutoff else "LIGHT"


	if(hue!="UNKNOWN"):

		if(weightGot=="HEAVY" and hue=="YELLOW"):
			grade = 'A'
		elif(hue=="GREEN" or weightGot=="LIGHT"):
			grade = 'B'
		else:
			grade = 'C'

		prevName = "NONE"
		if(threadPrev):
			threadPrev.join() #Waits for previous thread to send its grade to the arduino so that the baskets are in sync.
			#prevName=threadPrev.getName()
			#print(prevName,"is done")

		fruitSorter.write(grade.encode())
		cv2.imwrite(hue+" "+weightGot+" "+grade+" _ "+filenn+".bmp", image)
		if(grade=='A'):
			# pass
			print("A Reported",filenn)
		elif(grade=='B'):
			# pass
			print("B Reported",filenn)
		else:
			print("ERROR! Something went wrong. C reported",filenn)
	else:
		if(threadPrev):
			threadPrev.join() #Waits for previous thread to send its grade to the arduino so that the baskets are in sync.
			#prevName=threadPrev.getName()
			#print(prevName,"is done")
		print("ERROR! hueFinder function returned UNKNOWN hue!",filenn)
		grade = 'C'
		print("Sending to UNKNOWN")
		fruitSorter.write(grade.encode())
		cv2.imwrite(hue+" "+weightGot+" C"+" _ "+filenn+".bmp", image)
	#if(threadPrev):
	#	print(prevName,"plus 1 finished in time", time.time()-aaa)
	#else:
	#	print("thread 1 finished in time ", time.time()-aaa)


if __name__ == '__main__':

	timingUtility=0

	threadPrev=None #Previous Thread
	threadNow=None #Thread to start now

	imagerDelay=1.5 #Used to fine tune the position of the fruit on the conveyer when image is taken.
	weightCutoff = 200 #Used to decide

	filenn="0" #Used to store the images taken in the same folder as where the code is run from

	camera = cv2.VideoCapture(1)
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

		if('Prox' in line_received):

			filenn = str(int(filenn)+1)
			print(filenn) #Prints name of file where image taken is being saved
			#print("Processing Starts...")
			threadNow = threading.Thread(target = colorWeightBasedGrading, args = (threadPrev,filenn,imagerDelay,camera))
			#print("starting Thread",threadNow.getName())
			threadNow.start()
			threadPrev = threadNow

		elif('Quant' in line_received):
			Quants = line_received.split(':')
			print("The Quantities of fruits sorted are : ")
			print("A : " + Quants[1])
			print("B : " + Quants[2])
			print()
			print("Unknown : " + Quants[3])
		else:
			#print("Unknown Line")
			pass
		#print("Total time in loop is : ",time.time()-timingUtility)
