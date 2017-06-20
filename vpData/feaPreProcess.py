# this script was created to preprocess 2D features, and backup the current features.
# we only process the .2dvnf and the .2dvnfname files
# and back them as the .2dvnf_back and .2dvcfname_back

# Usage:
# python feaPreProcess.py

import sys
import os
import shutil

def backUp(modelList,suffix,path):
	for model in modelList:
		# backup
		for suf in suffix:
			srcPath = path + model + suffix
			dstPath = path + model + suffix + '_back'
			# shutil.copy(srcPath,dstPath)

# users can use this function to recover the .2dvnf file
def recovery(modelList,suffix,path):
	for model in modelList:
		# backup
		for suf in suffix:
			srcPath = path + model + suffix
			dstPath = path + model + suffix + '_back'
			# shutil.copy(dstPath,srcPath)


def modify(modelList):
	# this index was counted from 1.
	noColorIndex = [4, # rule of Thirds
    5,6,7,8,9,10,11,12,13,14, # hogHist
    15,16,17,18, # 2DTheta
    # 19,20, # EntropyVariance
    37,38,39, # vanish line feature
    40] # score

	for model in modelList:
		feafile = path + model + '.2dvnf_back'
		feafilieOut = path + model + '.2dvnf'
		fea = open(feafile,'r')
		feaout = open(feafilieOut,'w')

		line = "not null"
		while line:
			line = fea.readline()
			line = line.strip()
			feaout.write(line + "\n")
			line = fea.readline()
			line = line.strip()
			feaVec = line.split(' ')
			modifiedFea = ""
			for index in noColorIndex:
				modifiedFea = modifiedFea + ' ' + feaVec[index - 1]
			modifiedFea = modifiedFea.strip()
			feaout.write(modifiedFea + "\n")

		fea.close()
		feaout.close()

		feafile = path + model + '.2dvnfname_back'
		feafilieOut = path + model + '.2dvnfname'
		feaName = open(feafile,'r')
		feaout = open(feafilieOut,'w')
		
		line = "not null"
		index = 1
		while line:
			line = feaName.readline()
			line = line.strip()
			if index in noColorIndex:
				fea.write(line + "\n")


		feaName.close()
		feaout.close()



def main():

	modelList = {
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
	    # 'house8',
	    'njuSample',
	    # 'pavilion9',
	    # 'villa7s',
	    'njuActivity'
	    }

	path = './'

	suffix = {
		'.2dvnf',
		'.2dvnfname'
	}

	backUp(modelList,suffix,path)
	modify(modelList)

if __name__ == '__main__':
	main()
