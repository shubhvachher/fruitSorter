import time
import cv2
import numpy as np
import os
import matplotlib.pyplot as plt #Used only with high verbosity


all = os.listdir()
all = [f for f in all if f[-1]=='p']
all.sort()

def showImage(image, title="Test", waitTime=1000):
	cv2.imshow(title,image)
	cv2.waitKey(waitTime)
	cv2.destroyWindow(title)

def hueFinder(image, verbosity=0):
	"""Given an image of a fruit, it finds the center of the fruit and draws a radius from the center to approximate the hue."""
	if(type(image)==str):
		image = cv2.imread(image)
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

		return ("GREEN" if (0.20272*np.mean(values) + (-1.40552)*np.mean(hues))<(-0.02484) else "YELLOW", np.mean(hues), np.mean(values))

	else:
		cv2.destroyAllWindows()
		return -1

if __name__=='__main__':
	allHue=[]
	allTimes=[]
	x_train = []
	y_train = []
	for f in all:
		aaa = time.time()
		hueVal = hueFinder(cv2.imread(f),0)
		allTimes.append(time.time()-aaa)
		allHue.append((hueVal[0], hueVal[1:], f))
		x_train.append(list(hueVal[1:]))
		y_train.append(0 if f[0] in ['E','F','G','H'] else 1)
		print(f)
	print(allTimes)
	print("\n".join(str(allHue).split('.bmp')))

	print(x_train , y_train)

	from sklearn import linear_model
	import pickle
	with open("logRegModel", 'rb') as fr:
		linear = pickle.load(fr)

	print(linear.predict(x_train))

	print(linear.score(x_train, y_train), " accuracy")
