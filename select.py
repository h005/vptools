# this file was created to seelct matrixs for given filename
# input : raw matrix file
#		  selected matrixs file// only contains filename
#	   or score file // only contains filename score1 and score2
# output : selectedMatrix file
import io

# matrixfilePath = '/home/h005/Documents/flickr/flickr_downloader2/notredameOriginal.matrix';
# scorefilePath = '/home/h005/Documents/flickr/flickr_downloader2/notredameScore.txt';
# extractfilePath = '/home/h005/Documents/flickr/flickr_downloader2/notredameSelected.matrix';

model = 'cctv3'

matrixfilePath = '/home/h005/Documents/vpDataSet/' + model +'/imgs/model/'+ model +'.matrix'
scorefilePath = '/home/h005/Documents/vpDataSet/'+ model +'/imgs/model/filelist.txt'
extractfilePath = '/home/h005/Documents/vpDataSet/'+ model +'/imgs/model/selectedMatrix.matrix'

matrixfile = open(matrixfilePath,'r')
selectfile = open(scorefilePath)
# selectfile = open('201601061046KmedoidsPAM-mvMatrix_26_selecedFS_seleced.matrixs')
extractfile = open(extractfilePath,'w')

# method is scoreFile or matrixsFile
method = 'socreFile';

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
	spString = fname.split('/')
	# print spString
	if len(spString) <= 1 :
		fname = spString[0];
	else :
		fname = spString[1];
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
	spString = fname.split('/');
	if len(spString) <= 1 :
		fname = spString[0]
	else :
		fname = spString[1]
	fname = fname.split('.')[0]
	extractfile.write("%s.jpg\n" % (fname))
	for para in mvp[fname]:
		extractfile.write("%s\n" % (para))
	fname = selectfile.readline()

matrixfile.close()
selectfile.close()
extractfile.close()
