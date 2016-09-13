# this file was created for uploading qiniu
from qiniu import Auth
from qiniu import put_file, etag, urlsafe_base64_encode
import qiniu.config

access_key = 'SNGdXwQN-In0uJ5q0X8B39cQzkTM-I6uw5fXB71c'
secret_key = 'mad0PMzGwH9QgoiNQrbSgmMTz4yVwi8SvrcY-pm7'

# 
q = Auth(access_key, secret_key)

# 
bucket_name = 'vpdataset'

model = 'potalaPalace'

dir = '/home/h005/Documents/vpDataSet/' + model + '/imgs/scImg/'

fileList = dir + 'fileList.txt'

file = open(fileList,'r')

fname = file.readline()

while fname:
	fname = fname.strip()
	key = fname
	token = q.upload_token(bucket_name,key,3600)
	localfile = dir + key
	ret, info = put_file(token, key, localfile)
	print(info)
	assert ret['key'] == key
	assert ret['hash'] == etag(localfile)
	fname = file.readline()

file.close()