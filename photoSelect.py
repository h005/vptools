# -*- coding: utf-8 -*-
# @Author: h005
# @Date:   2017-08-07 09:12:12
# @Last Modified by:   h005
# @Last Modified time: 2017-08-07 09:37:07

import os
import shutil

def loadInImgList(photoListFile):
	photoList = []
	groundTruth = []
	preLabel = []
	photoFile = open(photoListFile,'r')
	line = photoFile.readline()
	while line:
		line = line.strip()
		tmpLine = line.split('\t')
		photoList.append(tmpLine[0])
		groundTruth.append(tmpLine[1])
		preLabel.append(tmpLine[2])
		line = photoFile.readline()
		line = line.strip()

	photoFile.close()
	return photoList, groundTruth, preLabel

photoListFile = '/home/h005/Documents/vpDataSet/photolist.txt'

photoList, groundTruth, preLabel = loadInImgList(photoListFile)

postiveFolder = '/home/h005/Documents/vpDataSet/samplePhotos/goodViewpoints/'
negativeFolder = '/home/h005/Documents/vpDataSet/samplePhotos/badViewpoints/'
basePath = '/home/h005/Documents/vpDataSet/'

count = 0
length = len(photoList)
while count < length:

	modelName = photoList[count].split('/')[0]
	imgName = photoList[count].split('/')[1]

	imageFile = basePath + modelName + '/imgs/' + imgName

	# move the image
	if groundTruth[count] == '1' and preLabel[count] == '1':
		dstFile = postiveFolder + modelName + '_' + imgName
		shutil.copy(imageFile,dstFile)

	if groundTruth[count] == '-1' and preLabel[count] == '-1':
		dstFile = negativeFolder + modelName + '_' + imgName
		shutil.copy(imageFile,dstFile)
	
	# print photoList[count], groundTruth[count], preLabel[count]

	count = count + 1

print 'copy done'