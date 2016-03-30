# this file was created to seelct matrixs for given filename
# input : raw matrix file
#		  selected matrixs file// contains filename
# output : selectedMatrix file
import io

matrixfile = open('notredame.matrix','r')
# scorefile = open('notredameScore.txt')
selectfile = open('201601061046KmedoidsPAM-mvMatrix_26_selecedFS_seleced.matrixs')
extractfile = open('notredameSelected.matrix','w')

# this is a dict
mvp = {}

# read in matrixfile
fname = matrixfile.readline()
while fname :
	# print eachline
	paralist = []
	for index in range(0,8):
		para = matrixfile.readline()
		para = para.strip()
		paralist.append(para)

	fname = fname.strip()
	fname = fname.split('/')[1]
	fname = fname.split('.')[0]
	mvp[fname] = paralist
	fname = matrixfile.readline()

# print info for test
# for key in mvp:
# 	print key
# 	for ele in mvp[key]:
# 		print ele

# read in select file
# and print result
fname = selectfile.readline()
while fname:
	fname = fname.strip()
	# print fname
	fname = fname.split('/')[1]
	fname = fname.split('.')[0]
	extractfile.write("%s.jpg\n" % (fname))
	for para in mvp[fname]:
		extractfile.write("%s\n" % (para))
	fname = selectfile.readline()

matrixfile.close()
selectfile.close()
extractfile.close()
