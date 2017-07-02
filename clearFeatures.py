# this script was created to clear featurs file to recompute them
# delete .mm file and feature-Related file in the folder of 
# /home/h005/Documents/vpDataSet/[model]/vpFea/
# Usage:
# python clearFeatures.py all
# python clearFeatures.py model
import sys
import os

model = '';

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


path = '/home/h005/Documents/vpDataSet/'

# in general cases, it is unnecessary to clear .vnf file
suffix = {
	'.2df',
	'.2dfname',
	'.2dvnf'
	'.2dvnfname',
	'.2dvnf_back',
	'.2dvnfname_back',
	'.3df',
	'.3dfname',
	'.fname'
	# '.vnf'
	}

if len(sys.argv)  > 2:
	print 'para error'

if sys.argv[1] == 'all':
	for model in modelList:
		# delete features already computed
		for suf in suffix:
			fileName = path + model + '/vpFea/' + model + suf
			if os.path.exists(fileName):
				os.remove(fileName)			
				print fileName + ' deleted'
		# delete .mm file for record
		fileName = path + model + '/model/' + model + '.mm'
		if os.path.exists(fileName):
			os.remove(fileName);
			print fileName + ' deleted'
elif sys.argv[1] in modelList:
	model = sys.argv[1];
	# delete features already computed
	for suf in suffix:
		fileName = path + model + '/vpFea/' + model + suf
		if os.path.exists(fileName):
			os.remove(fileName)
			print fileName + ' deleted'
	fileName = path + model + '/model/' + model + '.mm'
	if os.path.exists(fileName):
		os.remove(fileName);
		print fileName + ' deleted'
