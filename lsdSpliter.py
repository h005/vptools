# -*- coding: utf-8 -*-
# @Author: h005
# @Date:   2017-08-04 14:56:04
# @Last Modified by:   h005
# @Last Modified time: 2017-08-29 09:04:16

# this file was created to split the lsd feature
# the lsd feature contains the histogram angles with x axis as well as the diagonal axis

import io

def convert(originalFile, file1, file2, lsplitNum, rsplitNum):

	lsdHandle = open(originalFile,'r')
	lsd1Handle = open(file1,'w')
	lsd2Handle = open(file2,'w')
	fname = lsdHandle.readline()
	while fname:
		fname = fname.strip()
		fname = fname.replace('hejw005','h005')
		tmpFea = lsdHandle.readline()
		tmpFea = tmpFea.strip()

		ele = tmpFea.split(' ',lsplitNum)[-1]
		ele = ele.strip()
		# print ele
		lsd2Handle.write(fname + '\n')
		lsd2Handle.write(ele + '\n')
		ele = tmpFea.rsplit(' ',rsplitNum)[0]
		ele = ele.strip()
		# print ele
		lsd1Handle.write(fname + '\n')
		lsd1Handle.write(ele + '\n')
		fname = lsdHandle.readline()

	lsdHandle.close()
	lsd1Handle.close()
	lsd2Handle.close()


modelList = [
	'kxm',
	'bigben',
    'notredame',
    'freeGodness',
    'tajMahal',
    'cctv3',
    'BrandenburgGate',
    'BritishMuseum',
    'potalaPalace',
    'capitol',
    'Sacre',
    'TengwangPavilion',
    'mont',
    'HelsinkiCathedral',
    'BuckinghamPalace',
    'castle',
    'njuSample',
    'njuSample2',
    'njuSample3',
    'njuSample5',
    'njuActivity',
    'njuActivity2'
    # 'house8',
    # 'pavilion9',
    # 'villa7s',
    # 'model5'
    ]

# modelList = ['njuSample10','njuSample12','njuSample23']
modelList = ['njuSample9']

basePath = '/home/h005/Documents/vpDataSet/tools/vpData/'

spSuffix1 = '.lsd_x'
spSuffix2 = '.lsd_diagonal'

lsplitNum = 14
rsplitNum = 20

for model in modelList:
	originalFile = basePath + model + '/vpFea/' + model + '.lsd'
	spFile1 = basePath + model + '/vpFea/' + model + spSuffix1
	spFile2 = basePath + model + '/vpFea/' + model + spSuffix2
	convert(originalFile, spFile1, spFile2, lsplitNum, rsplitNum)
	print model + ' done' 
	# break