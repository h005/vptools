# this file was created for moving features computed from model folder
# to tools/vpFea folder
# python featureDistribution.py all
# python featureDistribution.py model
import os
import sys
import shutil

sourcePath = '/home/h005/Documents/vpDataSet/'
destPath = '/home/h005/Documents/vpDataSet/tools/vpData/'

if len(sys.argv) > 2:
	print 'para error'
	

modelList = {
    'bigben',
    'kxm',
    'notredame',
    'freeGodness',
    'tajMahal',
    'cctv3'
    }

suffix = {'.2df',
	'.2dfname',
	'.3df',
	'.3dfname',
	'.fname'
	};

if sys.argv[1] == 'all':
	for model in modelList:
		# delete features already computed
		for suf in suffix:
			fileName = sourcePath + model + '/vpFea/' + model + suf
			destName = destPath + model + '/vpFea/' + model + suf
			shutil.copy(fileName,destName)
			print fileName
			print destName
			print 'done'
			# if os.path.exists(fileName):
				# print fileName
elif sys.argv[1] in modelList:
	model = sys.argv[1];
	# delete features already computed
	for suf in suffix:
		fileName = sourcePath + model + '/vpFea/' + model + suf
		destName = destPath + model + '/vpFea/' + model + suf
		# if os.path.exists(fileName):
			# print fileName + ' deleted'
		shutil.copy(fileName, destName)
		print fileName
		print destName
		print 'done'
