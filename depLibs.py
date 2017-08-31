# -*- coding: utf-8 -*-
# @Author: h005
# @Date:   2017-08-21 14:30:32
# @Last Modified by:   h005
# @Last Modified time: 2017-08-21 14:56:01

# this file was created to select the depedent libraries.
# users should use ldd [program] > libs.txt to find the dependency libraries.
# than this script is used to cp the libs in the libs.txt to the selected folder

import os
import shutil

def loadInLibsList(libsFilePath,dstPath):
	# photoList = []
	# groundTruth = []
	# preLabel = []
	libsFile = open(libsFilePath,'r')
	line = libsFile.readline()
	while line:
		line = line.strip()
		libPath = line.split('=>')
		if len(libPath) > 1:
			# print libPath[1]
			libPath = libPath[1].split('(')
			libPath = libPath[0].strip()
			dstFile = libPath.rsplit('/',1)
			# print dstFile
			if len(dstFile) > 1:
				dstFile = dstFile[1].strip()
				# print dstPath + dstFile
				shutil.copy(libPath,dstPath + dstFile)
			else:
				print '............... ' + line
		else:
			print '............... ' + line
		# print line
		line = libsFile.readline()

		# tmpLine = line.split('\t')
		# photoList.append(tmpLine[0])
		# groundTruth.append(tmpLine[1])
		# preLabel.append(tmpLine[2])
		# line = photoFile.readline()
		# line = line.strip()

	libsFile.close()


dstPath = '/home/h005/Documents/QtProject/build-3DfeatureCheck-Desktop_Qt_5_8_0_GCC_64bit-Debug/libs/'
libsFilePath = '/home/h005/Documents/QtProject/build-3DfeatureCheck-Desktop_Qt_5_8_0_GCC_64bit-Debug/libs/libs.txt'
loadInLibsList(libsFilePath,dstPath)

print 'done'