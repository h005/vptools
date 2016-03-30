%% svmTest
clear;
clc;
% svmRegress;
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
trainData = trainData';
score = score';
mdl = fitrsvm(trainData,score,'Standardize',true,'KernelFunction','rbf');
% mdl = fitrsvm(trainData,score);
% L = kfoldLoss(mdl);
% compactMdl = compact(mdl);
scorefit = predict(mdl,trainData);
% scorefit
%% plot
len = size(score,1);
xaxis = 1:len;
figure
plot(xaxis,score,'r')
hold on
plot(xaxis,scorefit,'g')
title('svm')
