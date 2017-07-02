# -*- coding: utf-8 -*-
# @Author: h005
# @Date:   2017-06-27 10:23:21
# @Last Modified by:   h005
# @Last Modified time: 2017-06-27 10:59:48

# this file was created to purify the .matrix file,
# the cctv3.matrix file contains multi camera's parameters for one image.
# specifically, unique the model-view and projection for each image.

import io

modelList = {'cctv3'}

matrixDir = '/home/h005/Documents/vpDataSet/'

for ele in modelList:
	matrixFile = matrixDir + ele + '/model/' + ele + '.matrix'
	matrixFileOutPut = matrixDir + ele + '/model/' + ele + '.matrix_'

	fileIn = open(matrixFile,'r')
	fileOut = open(matrixFileOutPut,'w')

	fileNames = []
	line = fileIn.readline()

	while line:
		line = line.strip()
		if line not in fileNames and line != '':
			fileNames.append(line)
			fileOut.write(line + '\n')
			count = 0
			while count < 8:
				line = fileIn.readline()
				line = line.strip()
				fileOut.write(line + '\n')
				count = count + 1
		else:
			count = 0
			while count < 8:
				line = fileIn.readline()
				count = count + 1
		line = fileIn.readline()

	fileIn.close()
	fileOut.close()
	print ele + ' done'
	print fileNames

