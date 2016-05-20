%% this script was created to plot classify error bar
% just for combine classify
clear
close all
clc

addpath('../');

modelList = {
    'bigben',...
    'kxm',...
    'notredame'...
    'freeGodness'...
    'tajMahal'
};

% top rate pictures will be assign good
% last rate pictures will be assign bad
% this parameters should bbe modified as needed
rate = 0.08;
% load Data
% sc = scload(scorefile,sceneName);
[sc,scr,fea2d,fea3d] = dataLoad(modelList);
[fs,fname] = combine(fea2d,fea3d,scr);
[fs2d,fname] = combine(fea2d,scr);
[fs3d,fname] = combine(fea3d,scr);
% set Method
methodText = {
    'bayes classify',...
    'svm classify',...
    'ens classify'
    };
method = 2;

for i=1:numel(methodText)
    
    % result preparing
    % gt  groundTruth
    % pl  preLabel
    % ln  plotroc legend name
    % general classify methods
    gcMethod = {'classifyCombine','2D combine',methodText{method}};
    [gt1,pl1,ps1,ln1,scl1] = generalClassify(fs2d,rate,fname,gcMethod);
    gcMethod = {'classifyCombine','3D combine',methodText{method}};
    [gt2,pl2,ps2,ln2,scl2] = generalClassify(fs3d,rate,fname,gcMethod);
    gcMethod = {'classifyCombine','2D3D combine',methodText{method}};
    [gt3,pl3,ps3,ln3,scl3] = generalClassify(fs,rate,fname,gcMethod);

    gt{i} = [gt1;gt2;gt3];
%     ps = [ps1;ps2;ps3];
%     ln{i} = [ln1;ln2;ln3];
    pl{i} = [pl1;pl2;pl3];
%     scl = scl1;

    % plot classify error rate    
%     plotMethods = {'ROC','PR','ROC PR'};
%     plotMethodsId = 1;
%     titleLabel = ['combine features ' plotMethods{plotMethodsId} ' curve of ' methodText{method}];
%     classifyPlotHelper(gt,ps,scl,ln,plotMethods{plotMethodsId},titleLabel);

end
methodN = {'bayes','svm','ens'};
plotErrorRateGroup(gt,pl,methodN,'classification performance of different methods on photos');

