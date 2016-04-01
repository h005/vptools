# this file was created to combine .fea .2df .3df file
# input : file1
#		  file2
# output: fileOut
# output the features with the same file name

import io

file1 = '/home/h005/Documents/vpDataSet/notredame/vpFea/notredamemodel.fea'
file2 = '/home/h005/Documents/vpDataSet/notredame/vpFea/notredameScore.txt'

fileout = '/home/h005/Documents/vpDataSet/notredame/vpFea/notredame.feas'

feaDict = {}

fea2f = open(file1,'r')
feaSc = open(file2,'r')
fout = open(fileout,'w')

fname = fea2f.readline()

while fname:

	tmpfea = fea2f.readline()
	tmpfea = tmpfea.strip()
	
	fname = fname.strip()
	fname = fname.split('/')[-1]
	fname = fname.split('.')[0]

	feaDict[fname] = tmpfea

	# print tmpfea

	fname = fea2f.readline()

line = feaSc.readline()

while line:
	line = line.strip()
	lines = line.split(' ',1)
	fname = lines[0].split('/')[1]
	fname = fname.split('.')[0]

	if feaDict.has_key(fname):
		# fout.write("%s.jpg\n" % (fname))
		fout.write("%s " % (feaDict[fname]))
		fout.write("%s\n" % lines[-1])

	line = feaSc.readline()

print 'done'

fout.close()
fea2f.close()
feaSc.close()