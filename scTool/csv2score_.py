import csv
import sys
import glob
import os.path
'''
convert csv files 2 score file
dir para and outputFile para is needed
and outputFile will output in dir folder

usage python csv2score.py dir outputFile
example:
python csv2score.py /home/h005/Documents/vpDataSet/kxm/score kxm.sc

kxm.sc file will appear in folder /home/h005/Documents/vpDataSet/kxm/score

'''

if len(sys.argv)!=3:
	print 'Usage: python csv2score.py dir outputFile';
	print 'example: python csv2score.py /home/h005/Documents/vpDataSet/model/score model.sc'
else:
	dir = os.path.abspath(sys.argv[1])
	outputFile = sys.argv[2]

	filename = []
	for eachfn in glob.glob(dir+'/*.csv'):
		filename.append(os.path.basename(eachfn))
	# filename = ["HITResultsFor30U1YOGZGAXT1OPPPO07O4ZSOLKSDO.csv",
	# "HITResultsFor341YLJU21I0H40ODNNMCOJ21IWSI2C.csv",
	# "HITResultsFor39XCQ6V3KY5TADCZ35FLPNF8TFO566.csv",
	# "HITResultsFor3AFT28WXLF3VB7DIALK9VW54J1OOIO.csv",
	# "HITResultsFor3DIIW4IV8PWR7E30R150HYZZ2AO4IU.csv",
	# "HITResultsFor3H781YYV6TJZ8UG4AJGH4RDZQGZETS.csv",
	# "HITResultsFor3IZPORCT1FAYCPUEWVJSPF9UUBTHRX.csv",
	# "HITResultsFor3J9L0X0VDFNA5FTHXD56ZXJN3D0W9P.csv",
	# "HITResultsFor3KWGG5KP6J3GY1665V9ASPI4BWQCMW.csv",
	# "HITResultsFor3MJ28H2Y1E9JZJI3311F6N1ZEFIO5E.csv",
	# "HITResultsFor3UZUVSO3P7WVVZQK1MF5IDI7W83EMR.csv",
	# "HITResultsFor3VEI3XUCZRYQP6S2F8RXYOBLG23PRA.csv",
	# "HITResultsFor3VGZ74AYTGHG6RAKUSBFFKY7FADGCR.csv"];

	imgsc = {};

	for fname in filename:
		# print dir + "/" + fname
		csvfile = file(dir + "/" + fname)

		# get how many answers, ie how many pictures
		piclist = [];
		reader = csv.reader(csvfile)

		for line in reader:
			for ele in line:
				if (ele.find('Answer') != -1):
					piclist.append(ele)
			break

		csvfile.close();

		#for ele in piclist:
		#	print ele

		csvfile = file(dir + "/" + fname)

		reader = csv.DictReader(csvfile)

		for ele in reader:

			for ind in piclist:
				# print ele[ind]
				tmpstr = ele[ind]
				# print tmpstr
				tmpstr = tmpstr.replace('_','/')
				# print tmpstr
				tmpstrlist = tmpstr.split('[')
				sc = tmpstrlist[0]
				fn = tmpstrlist[1].split(']')[0]
				fn = fn.split('*')[0];
				if imgsc.has_key(fn):
					imgsc[fn].append(int(sc))
				else:
					imgsc[fn] = [int(sc)]

		csvfile.close()

	output = open(dir + "/" + outputFile,'w')

	for ele in imgsc:
		output.write(ele + "\n")
		for el in imgsc[ele]:
			output.write(str(el) + " ");
		output.write("\n");
		# print ele, imgsc[ele]

	output.close()


	print len(imgsc)
