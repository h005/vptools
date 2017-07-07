# -*- coding: utf-8 -*-
# @Author: h005
# @Date:   2017-07-02 11:08:32
# @Last Modified by:   h005
# @Last Modified time: 2017-07-07 10:18:39

# this file was created to combine features, such as .2df, .3df, .vnf .dpf
# and this file will cope all the models in model list.
# combine the feature file base on the .2df and the .2dfname file
# output the features with the same file name

import io
import types

# this function was created to load the num of the features
def loadFeaNum(feaFile):

	numFea = 0
	vnfHandle = open(feaFile,'r')

	fname = vnfHandle.readline()
	fea = vnfHandle.readline()
	fea = fea.strip()
	fea = fea.split(' ')
	numFea = len(fea)

	vnfHandle.close()
	return numFea

def getFeaFile(model,suffix):
	basePath = '/home/h005/Documents/vpDataSet/tools/vpData/'
	filePath = basePath + model + '/vpFea/' + model + suffix
	return filePath

def loadBaseFea(feaFile, feaFnameFile):
	fea = {}
	feaNameList = []
	# this was used to keep the order with the .2df
	feaFileList = []
	feaReader = open(feaFile,'r')
	feaFnameReader = open(feaFnameFile,'r')

	fname = feaReader.readline()
	while fname:
		fname = fname.strip()
		# print fname
		# print '.......replace.....'
		fname = fname.replace('hejw005','h005')
		# print fname
		feaFileList.append(fname)
		tmpFea = feaReader.readline()
		tmpFea = tmpFea.strip()
		fea[fname] = tmpFea
		fname = feaReader.readline()

	feaName = feaFnameReader.readline()
	while feaName:
		feaName = feaName.strip()
		# feaNameList = [feaNameList,feaName]
		feaNameList.append(feaName)
		feaName = feaFnameReader.readline()

	feaReader.close()
	feaFnameReader.close()
	return fea,feaNameList,feaFileList

def appendFea(feaDict, feaFile):
	feaReader = open(feaFile,'r')
	fname = feaReader.readline()
	while fname:
		fname = fname.strip()
		# print fname
		# print '.......replace.....'
		fname.replace('hejw005','h005')
		# print fname
		tmpFea = feaReader.readline()
		tmpFea = tmpFea.strip()
		# print fname
		feaDict[fname] = feaDict[fname] + ' ' + tmpFea
		fname = feaReader.readline()
	feaReader.close()
	return feaDict

def outputFeatures(feaDict, feaNameList, feaFileList, outputFeaFile, outputFeaFnameFile):

	feaOut = open(outputFeaFile, 'w')
	feaFnameOut = open(outputFeaFnameFile, 'w')

	# keys = feaDict.keys()
	# keys.sort()
	for ele in feaFileList:
		feaOut.write(ele + '\n')
		feaOut.write(feaDict[ele] + '\n')

	for ele in feaNameList:
		feaFnameOut.write(ele + '\n')

	feaOut.close()
	feaFnameOut.close()



feaMap = {'.vnf':'vanish Line',
		  '.lsd':'LineSegment',
		  '.gist32':'gist'}

baseFeafile = '.2df'
baseFeaName = '.2dfname'
outputFile = '.2dvnf'
outputFileName = '.2dvnfname'

modelList = [
	'bigben',
    'kxm',
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
    'njuActivity',
    'njuActivity2'
    # 'house8',
    # 'pavilion9',
    # 'villa7s',
    # 'model5'
    ]

modelList = ['cctv3','kxm']

bsaePath = '/home/h005/Documents/vpDataSet/tools/vpData/'

# fill in the feaNum
feaNum = {}
for ele in feaMap:
	feaFile = getFeaFile(modelList[1],ele)
	feaNum[ele] = loadFeaNum(feaFile)
	# print ele + ' ' + str(feaNum[ele])


# contacting the fea files
for model in modelList:
	# load in the base feature file as well as the base feature name file
	baseFeaFile = getFeaFile(model, baseFeafile)
	baseFeaFnameFile = getFeaFile(model, baseFeaName)
	feaDict, feaNameList, feaFileList = loadBaseFea(baseFeaFile, baseFeaFnameFile)
	for suffix in feaMap:
		feaFile = getFeaFile(model,suffix)
		print feaFile
		feaDict = appendFea(feaDict, feaFile)
		count = 0
		while count < feaNum[suffix]:
			feaNameList.append(feaMap[suffix])
			count = count + 1

	# output the features
	outputFeaFile = getFeaFile(model, outputFile)
	outputFeaFnameFile = getFeaFile(model, outputFileName)
	outputFeatures(feaDict, feaNameList, feaFileList, outputFeaFile, outputFeaFnameFile)
	print model


