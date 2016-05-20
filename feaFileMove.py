# this file was created to copy features file .2df .3df .fname
# from [model]/imgs/model/ to [model]/vpFea/ folder
import os
import shutil

modelList = ['bigben',
    'kxm',
    'notredame',
    'freeGodness',
    'tajMahal',
    'teaHouse']
for ele in modelList:
	srcfile = '/home/h005/Documents/vpDataSet/'+ ele +'/imgs/model/' + ele + '.2df';
	dstdir = '/home/h005/Documents/vpDataSet/'+ ele +'/vpFea/';
	shutil.copy(srcfile, dstdir)
	srcfile = '/home/h005/Documents/vpDataSet/'+ ele +'/imgs/model/' + ele + '.3df';
	shutil.copy(srcfile, dstdir)
	srcfile = '/home/h005/Documents/vpDataSet/'+ ele +'/imgs/model/' + ele + '.fname';
	shutil.copy(srcfile, dstdir)
# print dstdir

# shutil.copy(srcfile, dstdir)
