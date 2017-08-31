# -*- coding: utf-8 -*-
# @Author: h005
# @Date:   2017-08-23 16:44:50
# @Last Modified by:   h005
# @Last Modified time: 2017-08-23 16:48:16

import cv2

img = cv2.imread('/home/h005/Documents/vpDataSet/bigben/imgs/img0006.jpg')
cv2.namedWindow("Image")  
cv2.imshow("Image",img)
cv2.waitKey(0)