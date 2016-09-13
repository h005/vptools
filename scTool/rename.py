import sys
import os.path
import io
import os

# rename images, add model name as prefix

if len(sys.argv)!=3:
	print "Usage: python rename.py imgFolder prefixName"
	print "eg. python rename.py /home/h005/Documents/vpDataSet/potalaPalace/imgs/scImg/ potalaPalace"
else:
	dir = os.path.abspath(sys.argv[1])
	prefix = sys.argv[2]

	# print dir
	# visit all files in the folder

	list_dir = os.walk(dir)
	for root, dirs, files  in list_dir:
		for f in files:
			f1,f2 = os.path.splitext(f)
			if f2 == '.jpg':
				os.rename(dir + '/' + f, dir + '/' + prefix + '_' + f)
				print 'rename file ' + f + ' as ' + prefix + '_' + f 

