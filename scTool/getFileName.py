import os
import sys
if len(sys.argv)!=2:
	print 'Usage: python getFileName model > model.survey'
else:
	# model = 'freeGodness'
	model = sys.argv[1]
	folder = '/home/h005/Documents/vpDataSet/' + model + '/cluster'

	listDir = os.walk(folder)

	for root, dirs, files in listDir:
		for f in files:
			print model + '/' + f
