# this file was created to combine features, such as .2df, .3df, .vnf .dpf
# and this file will cope all the models in model list.
# input : file1
#		  file2
# output: fileOut
# output the features with the same file name

# this file was created to combine the features of vanish line and the gist features.

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




# modelList = {'bigben','kxm','notredame','freeGodness','tajMahal','cctv3'};
# modelList = {'villa7s'}
# modelList = {'BrandenburgGate','BritishMuseum','potalaPalace','capitol','Sacre','TengwangPavilion','mont','HelsinkiCathedral','BuckinghamPalace'}
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
    'njuSample2',
    # 'pavilion9',
    # 'villa7s',
    'njuActivity',
    'njuActivity2',
    # 'model5'
    }

# modelList = {'castle'};
# modelList = {'njuSample2'}
# modelList = {'njuActivity2'}

# read in the number of the vanish line features
# print type(modelList)
ele = 'kxm'
vnfFile = '/home/h005/Documents/vpDataSet/tools/vpData/' + ele + '/vpFea/' + ele + '.vnf'
gistFile = '/home/h005/Documents/vpDataSet/tools/vpData/' + ele + '/vpFea/' + ele + '.gist'
numVnfFea = loadFeaNum(vnfFile)
numGistFea = loadFeaNum(gistFile)

for ele in modelList:
	originPath1 = '/home/h005/Documents/vpDataSet/tools/vpData/' + ele + '/vpFea/' + ele + '.2df'
	originPath2 = '/home/h005/Documents/vpDataSet/tools/vpData/' + ele + '/vpFea/' + ele + '.vnf'
	originPath3 = '/home/h005/Documents/vpDataSet/tools/vpData/' + ele + '/vpFea/' + ele + '.gist'

	destPath = '/home/h005/Documents/vpDataSet/tools/vpData/' + ele + '/vpFea/' + ele + '.2dvnf'
	fnameSourcePath = '/home/h005/Documents/vpDataSet/tools/vpData/' + ele + '/vpFea/' + ele + '.2dfname'
	fnameDestPath = '/home/h005/Documents/vpDataSet/tools/vpData/' + ele + '/vpFea/' + ele + '.2dvnfname'

	feaDict = {};
	fea1 = open(originPath1,'r')
	fea2 = open(originPath2,'r')
	fea3 = open(originPath3,'r')
	fout = open(destPath,'w')

	fnameReader = open(fnameSourcePath,'r')
	fnameWriter = open(fnameDestPath,'w')

	fname = fea1.readline()

	# build up the dict
	while fname:
		tmpfea = fea1.readline()
		tmpfea = tmpfea.strip()

		fname = fname.strip()

		feaDict[fname] = tmpfea

		fname = fea1.readline()

	# read in the vanish feature into the dict
	fname = fea2.readline()
	while fname:
		tmpfea = fea2.readline()
		tmpfea = tmpfea.strip()

		fname = fname.strip()

		feaDict[fname] = feaDict[fname] + " " + tmpfea

		fname = fea2.readline()

	# output the dict as well as the gist feature
	fname = fea3.readline()
	while fname:
		tmpfea = fea3.readline()
		tmpfea = tmpfea.strip()

		fname = fname.strip()

		fout.write("%s\n" % (fname))
		fout.write("%s " % (feaDict[fname]))
		fout.write("%s\n" % tmpfea)

		fname = fea3.readline()


	feaName = fnameReader.readline()

	while feaName:
		feaName = feaName.strip()
		fnameWriter.write('%s\n' % (feaName))
		feaName = fnameReader.readline()

	

	counter = 0
	while counter < numVnfFea:
		fnameWriter.write('vanish Line\n')
		counter = counter + 1

	counter = 0
	while counter < numGistFea:
		fnameWriter.write('gist\n')
		counter = counter + 1


	print ele

	fea1.close()
	fea2.close()
	fea3.close()
	fout.close()
	fnameReader.close()
	fnameWriter.close()
