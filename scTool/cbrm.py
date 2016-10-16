import os

dir = '/home/h005/Documents/vpDataSet/BuckinghamPalace/register2/visualize/'
dstDir = '/home/h005/Documents/vpDataSet/BuckinghamPalace/imgs/'

for file in os.listdir(dir):
	if os.path.isfile(os.path.join(dir,file)) == True:
		newname = '2' + file
		os.rename(os.path.join(dir,file),os.path.join(dstDir,newname))
