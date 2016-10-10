生成amt survery时，先在模型imgs下面的mask文件夹下进行筛选
之后 ls > ../filelist.txt

然后运行tools文件夹下的select.py脚本
    在这个脚本里面修改模型参数即可
    会将新的matrix文件输出到imgs/model文件夹下

然后使用matlab进行聚类，进行进一步的筛选
修改imgCluster下面的mvDist.m文件中的modelName
得到聚类结果

cbrm.py 处理模型太大，分为几个部分来恢复的情况
    # 这个鸟模型太大，分为两个部分来恢复，现在要将这两部分图片合并
    # cbrn.py 脚本将reigster2里的图片批量重命名并放在imgs/文件夹下
    # // combineRename
    # 文件名前加一个前导2

getFileName.py 这个脚本用来处理使用matlab聚类之后的结果，提取聚类之后cluster文件夹下的所有图像文件
    这个脚本生成的文件会作为AMT-survey的输入，生成用户调查
    Usage：
    python getFileName.py model > model.survey

csv2score.py 这个脚本用来处理从AMT扒下来，做完调查的数据，并且转化为matlab可以使用的文件格式
csv2Score_.py 这个脚本和scv2score.py的作用一样，只是后来发布的数据和第一批发布的数据格式不一样（之前发布的为[model]/[image].jpg，而后来发布的是[model]_[image].jpg格式 需要增加一步将'_'替换成'/',和maltab处理的数据格式统一起来）

convert csv files 2 score file
dir para and outputFile para is needed
and outputFile will output in dir folder

Usage： python csv2score.py dir outputFile
example:
python csv2score.py /home/h005/Documents/vpDataSet/kxm/score kxm.sc
kxm.sc file will appear in folder /home/h005/Documents/vpDataSet/kxm/score

paraTest.py 仅仅是一个关于python输入参数的测试文件

rename.py 用来将某个目录下的所有jpg文件前加前缀
"Usage: python rename.py imgFolder prefixName"
print "eg. python rename.py /home/h005/Documents/vpDataSet/potalaPalace/imgs/scImg/ potalaPalace"


imgScale.py 将输入的图像等比例缩放到某个尺寸范围以内
"Usage: pyton imgScale.py imgFolder filename.list"
例子：python imgScale.py ~/Documents/vpDataSet/notredame/imgs/ ~/Documents/vpDataSet/tools/scTool/survey/notredame/notredame.survey
输入的是要处理的图像文件夹，以及要处理的图像文件名列表
在路径下的会创建scImg文件夹，然后将scale之后的图像文件保存到这个文件夹下

qiniuUpload.py 用来将scale之后的图像上传到七牛上去
    需要在模型的img/scImg/下先生成一个fileList.txt, fileList.txt中包含图像的文件名，但不需要包含自身
    可以在/scImg/目录下运行
    ls > ../fileList.txt
    mv ../fileList.txt ./

修改qiniuUpload.py文件中的 model 为要处理的 model 即可


survey文件夹下存放着不同模型在AMT上面的调查数据
  该文件夹下有模型文件夹
    模型文件夹下面存放着用于生成AMT上面调查的数据
    模型文件夹先面还有survey文件，里面包含要使用的文件名列表

生成AMT的调查：
  输入survey文件（需要将刚才生成的survey文件放在survey文件夹下的具体的某个模型的文件夹下）

  注意，在生成调用gen_survey.py之前要先想model.survey文件中的 / 改为 _
  例如 BrandenburgGate/00000363.jpg to BrandenburgGate_00000363.jpg


  进入到survey文件夹下的模型文件夹
  例如 survey/notredame/
  然后调用
  python ../../../amtsurvey/gen_survey.py --prefix=notredame_ < notredame.survey
  选择生成一个调查，提交到沙盒并测试，注意最后的参数不用加后缀名
  python ../../../amtsurvey/post_utility.py --single=notredame_0-29
  提交完毕后，注意返回信息的最后几行, 复制加粗部分的网址即可在沙盒中查看
  python ../../../amtsurvey/post_utility.py --dir=. --production
