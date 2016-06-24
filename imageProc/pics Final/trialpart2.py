image = image2.copy()
ans1=ans.copy()
ans1 = cv2.convertScaleAbs(ans1)
a,cnts,b=cv2.findContours(ans1,cv2.RETR_LIST,cv2.CHAIN_APPROX_SIMPLE)
max_area=0
for c in cnts:
    area=cv2.contourArea(c)
    if area>max_area:
        max_area=area
        best_cnt=c

M=cv2.moments(best_cnt)
a1=cv2.contourArea(best_cnt)
image2=image.copy()
cv2.drawContours(image2,[best_cnt],-1,(0,255,0),2)
plt.imshow(image2)
plt.show()
r1=(a1/3.14159)**0.5


closing = cv2.morphologyEx(ans.copy(), cv2.MORPH_CLOSE, np.ones((3,3),np.uint8))
closing = cv2.convertScaleAbs(closing)
a,cnts,b=cv2.findContours(closing.copy(),cv2.RETR_LIST,cv2.CHAIN_APPROX_SIMPLE)
max_area=0
for c in cnts:
    area=cv2.contourArea(c)
    if area>max_area:
        max_area=area
        best_cnt=c

M=cv2.moments(best_cnt)
a2=cv2.contourArea(best_cnt)
image2=image.copy()
cv2.drawContours(image2,[best_cnt],-1,(0,255,0),2)
plt.imshow(image2)
plt.show()
r2=(a2/3.14159)**0.5
