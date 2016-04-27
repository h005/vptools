import cv2
import numpy as np
import sys
import os.path
import io

# scale image smaller than WIDTH * HEIGHT

if len(sys.argv)!=3:
    print "Usage: pyton imgScale.py imgFolder filename.list"
else:
    dir = os.path.abspath(sys.argv[1])
    fn = sys.argv[2]
    if os.path.exists(dir + '/scImg')<>True:
        os.mkdir(dir + '/' + 'scImg')
WIDTH = 800
HEIGHT  = 800

fileName = open(fn,'r')
fname = fileName.readline()
fileList = []
while fname:
    fname = fname.strip()
    tmp = os.path.basename(fname)
    fileList.append(tmp)
    fname = fileName.readline()
fileName.close()

# print len(fileList)

for fn in fileList:
    img = cv2.imread(dir + "/" +fn)
    print fn
    rows,cols,channels = img.shape
    if rows < HEIGHT and cols < HEIGHT :
        cv2.imwrite(dir + '/scImg/' + fn, img)
    else :
    # print str(rows) + " " + str(cols)
        rate = 0.0
        if HEIGHT * cols > WIDTH * rows:
            rate = float(WIDTH)/float(cols)
        else:
            rate = float(HEIGHT)/float(rows)
        size = [rows * rate, cols * rate]
        img = cv2.resize(img,(int(cols * rate),int(rows * rate)))
        cv2.imwrite(dir + '/scImg/' + fn,img)
