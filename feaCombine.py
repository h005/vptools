# this file was created to combine .fea .2df .3df file
# input : file1
#		  file2
# output: fileOut
# output the features with the same file name

import io

file1 = '/home/h005/Documents/vpDataSet/notredame/vpFea/notredamemodel.2df'
file2 = '/home/h005/Documents/vpDataSet/notredame/vpFea/notredamemodel.3df'

fileout = '/home/h005/Documents/vpDataSet/notredame/vpFea/notredamemodel.fea'

feaDict = {}

fea2f = open(file1,'r')
fea3f = open(file2,'r')
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

fname = fea3f.readline()

while fname:

	tmpfea = fea3f.readline()
	tmpfea = tmpfea.strip()

	fname = fname.strip()
	fname = fname.split('/')[-1]
	fname = fname.split('.')[0]

	# print feaDict[fname]
	# print tmpfea
	# print feaDict[fname][-1].encode("hex")

	fout.write("%s.jpg\n" % (fname))
	fout.write("%s " % (feaDict[fname]))
	fout.write("%s\n" % tmpfea)

	fname = fea3f.readline()

fout.close()
fea2f.close()
fea3f.close()