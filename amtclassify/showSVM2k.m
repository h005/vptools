%% show svm result
clear
close all
clc
addpath('../');

modelList = {'bigben','kxm','notredame','freeGodness','tajMahal'};

anaMethodList = {
    'generalClassifyEach',... % 1
    'generalClassifyCombine',... % 2
    'generalRegress',... % 3
    'generalRegressVirtual'... % 4
    'generalClassifyVirtual'... % 5
    'encodingClassifyCombine',... % 6
    'svm2kClassifyCombine',... % 7
    'LDL'}; % 8
    anaMethod = 2;
    rate = 0.05;
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
    'end classify'    
    };
    method = 2;
    
    % result preparing
    % gt  groundTruth
    % pl  preLabel
    % ln  plotroc legend name
    % general classify methods
    gcMethod = {anaMethodList{anaMethod},'2D combine',methodText{method}};
    [gt1,pl1,ps1,ln1,scl1] = generalClassify(fs2d,rate,fname,gcMethod);
    gcMethod = {anaMethodList{anaMethod},'3D combine',methodText{method}};
    [gt2,pl2,ps2,ln2,scl2] = generalClassify(fs3d,rate,fname,gcMethod);
%     gcMethod = {anaMethodList{anaMethod},'2D3D combine',methodText{method}};
%     [gt3,pl3,ps3,ln3,scl3] = generalClassify(fs,rate,fname,gcMethod);
    [gt3,pl3] = svm2kStart(modelList,rate);
    ln = {'2D combine','3D combine','svm2k'};

    gt = [gt1;gt2;gt3];
    pl = [pl1;pl2;pl3];
    
    scl = scl1;
    
    plotErrorRate(gt,pl,ln,[methodText{method} ' of different method on photos']);
    