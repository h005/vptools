%{
%% this file was created for svm Regression
datafile = '/home/h005/Documents/vpDataSet/notredame/vpFea/notredame.fs';
data = load(datafile);

trainData = data(:,1:end-2);
trainData = trainData';
% 数据归一化
trainData = mapminmax(trainData);

score = data(:,end-1:end);
score(find(score(:,2)==0),2) = 1;
score = score(:,1) ./ score(:,2);
% score = score(:,2);
score = score';

% ccn 中的数据输入训练集 numfea * numcases
% score 1 * numcases
% nntool
%}
function mdl = svmRegress(trainFea,trainScore)
trainFea = trainFea';
trainScore = trainScore';
mdl = fitrsvm(trainFea,trainScore,'Standardize',true,'KernelFunction','rbf');
mdl = compact(mdl);