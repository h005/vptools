# this file was created to copy features file .2df .3df .fname
# from [model]/imgs/model/ to [model]/vpFea/ folder
import os
import shutil

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
    'BuckinghamPalace'
    }
    
suffix = {'.2df',
	'.2dfname',
	'.2dvnfname',
	'.3df',
	'.3dfname',
	'.fname'
	};    
    
for ele in modelList:
    for suf in suffix:
    	srcfile = '/home/h005/Documents/vpDataSet/'+ ele +'/vpFea/' + ele + suf;
	    dstdir = '/home/h005/Documents/vpDataSet/'+ ele +'/vpFea/';
	    shutil.copy(srcfile, dstdir)
#	srcfile = '/home/h005/Documents/vpDataSet/'+ ele +'/imgs/model/' + ele + '.3df';
#	shutil.copy(srcfile, dstdir)
#	srcfile = '/home/h005/Documents/vpDataSet/'+ ele +'/imgs/model/' + ele + '.fname';
#	shutil.copy(srcfile, dstdir)
# print dstdir

# shutil.copy(srcfile, dstdir)
