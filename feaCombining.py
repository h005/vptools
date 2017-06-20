# this file was created to combine features, such as .2df, .3df, .vnf .dpf
# and this file will cope all the models in model list.
# input : file1
#		  file2
# output: fileOut
# output the features with the same file name

import io

# modelList = {'bigben','kxm','notredame','freeGodness','tajMahal','cctv3'};
# modelList = {'villa7s'}
# modelList = {'BrandenburgGate','BritishMuseum','potalaPalace','capitol','Sacre','TengwangPavilion','mont','HelsinkiCathedral','BuckinghamPalace'}
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
    # 'njuSample',
    # 'pavilion9',
    # 'villa7s',
    'njuActivity'
    }

# modelList = {'castle'};
modelList = {'njuSample'}
# modelList = {'njuActivity'}

for ele in modelList:
	originPath1 = '/home/h005/Documents/vpDataSet/tools/vpData/' + ele + '/vpFea/' + ele + '.2df';
	originPath2 = '/home/h005/Documents/vpDataSet/tools/vpData/' + ele + '/vpFea/' + ele + '.vnf';
	destPath = '/home/h005/Documents/vpDataSet/tools/vpData/' + ele + '/vpFea/' + ele + '.2dvnf';
	fnameSourcePath = '/home/h005/Documents/vpDataSet/tools/vpData/' + ele + '/vpFea/' + ele + '.2dfname'
	fnameDestPath = '/home/h005/Documents/vpDataSet/tools/vpData/' + ele + '/vpFea/' + ele + '.2dvnfname'

	feaDict = {};
	fea1 = open(originPath1,'r');
	fea2 = open(originPath2,'r');
	fout = open(destPath,'w');

	feaReader = open(fnameSourcePath,'r')
	feaWriter = open(fnameDestPath,'w')

	fname = fea1.readline()

	while fname:
		tmpfea = fea1.readline();
		tmpfea = tmpfea.strip();

		fname = fname.strip();

		feaDict[fname] = tmpfea;

		fname = fea1.readline();

	fname = fea2.readline();

	while fname:
		tmpfea = fea2.readline();
		tmpfea = tmpfea.strip();

		fname = fname.strip();

		fout.write("%s\n" % (fname))
		fout.write("%s " % (feaDict[fname]));
		fout.write("%s\n" % tmpfea);

		fname = fea2.readline()

	feaName = feaReader.readline();

	while feaName:
		feaName = feaName.strip()
		feaWriter.write('%s\n' % (feaName))
		feaName = feaReader.readline()

	feaWriter.write('vanish Line\n');
	feaWriter.write('vanish Line\n');
	feaWriter.write('vanish Line\n');


	print ele

	fea1.close();
	fea2.close();
	fout.close();
	feaReader.close();
	feaWriter.close();
