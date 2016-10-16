folder notredame contains data
you should put notredame folder in  /home/h005/Documents/vpDataSet/

cnnText.m was a file test for cnn regress
dataScaler.m was a scale file generates an object
datascling.m scales data
ensRegress.m ensemble regress
feaAnalysis.m use different method to analysis fea and score
feaCombine.py combine features from different file
feaDistrubution.m plot the histogram figure for each feature and score
feaRegress.m call feaAnalysis.m make a regress
feaScoreCombine.py combine features and score from different file
getPart.m divide data in to servel parts
gprRegress.m gaussian process regress
select.py given a file only contains filename, select mvp matrix
showInfo.m subplot figures for given method
svmRegress.m svm regress
svmTest.m test for svm regress

clearFeatures.py 清除掉已存在的特征文件，然后重新计算
清除后缀文件名在文件中的suffix里面修改
modelList中包含着要清除的模型列表

Usage:
python clearFeatures.py all
python clearFeatures.py model
example:
python clearFeatures.py kxm
python clearFeatures.py all

featureDistribution.py 将vpDataSet/[model]/vpFea/ 文件夹下的特征文件复制到
vpDataSet/tools/vpData/[model]/vpFea/ 文件夹下
修改文件中的modelList来选择要处理的模型
修改文件中的suffix来选择要处理的文件

Usage：
python featureDistribution.py

feaCombining.py 该文件主要用来拼接已经计算出来的特征文件（2df和vnf，以及2dfname生成2dvnfname）
修改modelList来选择要处理的模型

Usage：
python feaCombining.py


vpData/ folder contains our train and test data
    [model]/
        score/
            *.csv
            *.sc
        vpFea/
            [model].2df
            [model].3df
            [model].dpf
            [model].fname
