import io
import shutil

negFile = 'negImages.txt'
posFile = 'posImages.txt'
dir = '../'

# test for copy file
# shutil.copy(negFile,dir)


f = open(negFile)
line = f.readline()
while line:
	# cctv3/00000035.jpg 2.95
	line = line.strip()
	# cctv3/00000035.jpg
	fileName0 = line.split(' ')[0]
	# cctv3/imgs/00000035.jpg
	fileName = fileName0.replace('/','/imgs/')
	# cctv3_00000035.jpg
	fileName1 = fileName0.replace('/','_')
	# copy this file to ../negImg/
	print 'copy ' + dir + fileName + ' To ' + dir + 'negImg/' + fileName1
	shutil.copy(dir + fileName,dir + 'negImg/' + fileName1)
	line = f.readline()

f.close()

f = open(posFile)
line = f.readline()
while line:
	# cctv3/00000035.jpg 2.95
	line = line.strip()
	# cctv3/00000035.jpg
	fileName0 = line.split(' ')[0]
	# cctv3/imgs/00000035.jpg
	fileName = fileName0.replace('/','/imgs/')
	# cctv3_00000035.jpg
	fileName1 = fileName0.replace('/','_')
	# copy this file to ../negImg/
	print 'copy ' + dir + fileName + ' To ' + dir + 'posImg/'
	shutil.copy(dir + fileName,dir + 'posImg/' + fileName1)
	line = f.readline()

f.close()