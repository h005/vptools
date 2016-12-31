# this file was created for formatting the ply file in hellogl2
# because of our ply file processing program can only deal with just that one format
# input ply file was exported from MeshLab and with color, normal, and NO binary encoding
import os
import sys
# import shutil

# the ply file needed to be processed was in
# '/home/h005/Documents/vpDataSet/[model]/register/ptCluster.ply'

path = '/home/h005/Documents/vpDataSet/'

if len(sys.argv) > 2:
	print 'para error'


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
    'house8',
    'njuSample',
    'pavilion9',
    'villa7s'
    }

suf = '/register/ptCluster.ply'
dest = '/register/ptClusterFormat.ply'

if sys.argv[1] == 'all':
	for model in modelList:
		fileName = path + model + suf;
		if os.path.exists(fileName):
			destFile = path + model + dest
			# file of point cloud
			fpt = open(fileName,'r')
			# file of point cloud format
			fptf = open(destFile,'w')
			fline = fpt.readline()
			fline = fline.strip()
			line = 1
			reserve = [1,2,4,5,6,7,8,9,10,11,12,13,17];
			while fline:
				if line in reserve:
					fptf.write('%s\n' % (fline));
				line = line + 1
				fline = fpt.readline()
				fline = fline.strip()
				if line == 18:
					break
			while fline:
				myline = fline.rsplit(' ',1)
				print myline[0]
				fptf.write('%s\n' % (myline[0]))
				fline = fpt.readline()
				fline = fline.strip()
			print fileName + 'format done'
			fpt.close();
			fptf.close();
		else:
			print fileName + 'does not exists'

elif sys.argv[1] in modelList:
	model = sys.argv[1];
	fileName = path + model + suf;
	if os.path.exists(fileName):
		destFile = path + model + dest
		# file of point cloud
		fpt = open(fileName,'r')
		# file of point cloud format
		fptf = open(destFile,'w')
		fline = fpt.readline()
		fline = fline.strip()
		line = 1
		reserve = [1,2,4,5,6,7,8,9,10,11,12,13,17];
		while fline:
			if line in reserve:
				fptf.write('%s\n' % (fline));
			line = line + 1
			fline = fpt.readline()
			fline = fline.strip()
			if line == 18:
				break
		while fline:
			myline = fline.rsplit(' ',1)
			# print myline[0]
			fptf.write('%s\n' % (myline[0]))
			fline = fpt.readline()
			fline = fline.strip()
		print fileName + 'format done'
		fpt.close();
		fptf.close();
	else:
		print fileName + 'does not exists'
