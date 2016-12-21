import cv2
def takeNSave(camPort = 1, ramp_frames = 30, verbosity = 0, filename="test"):
	"""Takes an image from camPort and saves on to HDD """
	filename = filename.split('.')[0]
	filename=filename+".bmp"
	camera = cv2.VideoCapture(camPort)
	for i in range(ramp_frames):
		temp = camera.read()
	if verbosity>0:
		print("Taking image now.")
	retval, image = camera.read()
	del(camera)
	cv2.imshow("image",image)
	cv2.waitKey(30)
	choice = input("Do you want to save the image : ")
	cv2.destroyAllWindows()
	if(choice=='y'):
		cv2.imwrite(filename,image)
		
	choice = input("Replace image : ")
	if(choice=='y'):
		print(filename.split('.')[0])
		takeNSave(camPort,ramp_frames,verbosity,filename)
	if('y' not in choice):
		choice2 = input("Take another image : ")
		if(choice2=='y'):
			filename = input("Enter filename : ")
			takeNSave(camPort,ramp_frames,verbosity,filename)
