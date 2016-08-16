%% this script was a start file
%% for generalRegress
clear
close all
clc
addpath('../');

modelList = {
    'bigben',...
    'kxm',...
    'notredame',...
    'freeGodness',...
    'tajMahal',...
    'cctv3'...
    };

anaMethodList = {
    'generalClassifyEach',... % 1
    'generalClassifyCombine',... % 2
    'generalRegress',... % 3
    'generalRegressVirtual'... % 4
    'generalClassifyVirtual'... % 5
    'encodingClassifyCombine',... % 6
    'svm2kClassifyCombine',... % 7
    'LDL'}; % 8

anaMethod = 4;

if strcmp(anaMethodList{anaMethod},'generalClassifyEach')
%%    
    % top rate pictures will be assign as good
    % last rate pictures will be assign as bad
    % this parameters shold be modified as you like
    rate = 0.1;
    
    [sc,scr,fea2d,fea3d] = dataLoad(modelList);

    methodText = {
        'bayes classify',...
        'svm classify',...
        'ens classify'
        };
    method = 2;
    plotMethods = {'ROC','PR','ROC PR'};
    plotMethodsId = 1;   
    
    % 2D feature
    [fs2d,fname] = combine(fea2d,scr);
    
    % general classify method paramenters
    gcMethod = {anaMethodList{anaMethod},'2D',methodText{method}};
    
    [gt,pl,ps,ln,scl] = generalClassify(fs2d,rate,fname,gcMethod);
    titleLabel = ['2D feature ' plotMethods{plotMethodsId} ' curve of ' methodText{method}];
    classifyPlotHelper(gt,ps,scl,ln,plotMethods{plotMethodsId},titleLabel);

    % 3D feature
    [fs3d,fname] = combine(fea3d,scr);
    
    % general classify method parameters
    gcMethod = {anaMethodList{anaMethod},'3D',methodText{method}};
    
    [gt,pl,ps,ln,scl] = generalClassify(fs3d,rate,fname,gcMethod);
    titleLabel = ['3D feature ' plotMethods{plotMethodsId}  ' curve of ' methodText{method}];
    classifyPlotHelper(gt,ps,scl,ln,plotMethods{plotMethodsId},titleLabel);
elseif strcmp(anaMethodList{anaMethod},'generalClassifyVirtual')
%%
    % top rate pictures will be assign good
    % last rate pictures will be assign bad
    % this parameters should bbe modified as needed
    rate = 0.08;
    % load Data
    % sc = scload(scorefile,sceneName);
    [sc,scr,fea2d,fea3d] = dataLoad(modelList);
    [fs,fname] = combine(fea2d,fea3d,scr);  
    % set Method
    methodText = {
        'bayes classify',...
        'svm classify',...
        'ens classify'
        };
    method = 2;
    [mdl, scaler] = getClassifier(fs,rate,methodText{method});
    
%     virtualModel = {'teaHouse'};
    virtualModel = {'zb'};
    
    [vfea2d,vfea3d] = vdataLoad(virtualModel);
    
    [vf,vfname] = combine(vfea2d,vfea3d);
    
    vf = vf';
    
    testFea = datascaling(scaler,vf);
    
    ps = predict(mdl,testFea');
    
    
elseif strcmp(anaMethodList{anaMethod},'generalClassifyCombine')
%% calssiyfCombine
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
    % select for some features
    % details was showed in feaNameLoad.m
%     [visualFea, geometricFea,validVisIndex, validGeoIndex] = feaNameLoad();
%     fs2d = fs2d(:,[validVisIndex,size(fs2d,2)]);
%     fs3d = fs3d(:,[validGeoIndex,size(fs3d,2)]);
%     fs = fs(:,[validVisIndex,visualFea{end}.index(end)+validGeoIndex, size(fs,2)]);
    
    % set Method 
    methodText = {
        'bayes classify',...
        'svm classify',...
        'ens classify'
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
    gcMethod = {anaMethodList{anaMethod},'2D3D combine',methodText{method}};
    [gt3,pl3,ps3,ln3,scl3] = generalClassify(fs,rate,fname,gcMethod);
    
    gt = [gt1;gt2;gt3];
    ps = [ps1;ps2;ps3];
    ln = [ln1;ln2;ln3];
    pl = [pl1;pl2;pl3];
    
    scl = scl1;
    
    % plot classify error rate
    plotErrorRate(gt,pl,ln,[methodText{method} ' of different method on photos']);
    plotMethods = {'ROC','PR','ROC PR'};
    plotMethodsId = 1;
    titleLabel = ['combine features ' plotMethods{plotMethodsId} ' curve of ' methodText{method}];
    classifyPlotHelper(gt,ps,scl,ln,plotMethods{plotMethodsId},titleLabel);
elseif strcmp(anaMethodList{anaMethod},'encodingClassifyCombine')
%% encoding classify by combined features
    % top rate pictures will be assigned as good
    % last rate pictures will be assigned as bad
    % this paramenters should will be modified as needed
    rate = 0.8;
    % load Data
    % sc = scload(scorefile,sceneName);
    [sc,scr,fea2d,fea3d] = dataLoad(modelList);
    [fs,fname] = combine(fea);
    
    
elseif strcmp(anaMethodList{anaMethod},'generalRegress')
%% generalRegress
    % scr score generalRegress

    [sc,scr,fea2d,fea3d] = dataLoad(modelList);

    [fs,fname] = combine(fea2d,fea3d,scr);
    [fs2d,fname] = combine(fea2d,scr);
    [fs3d,fname] = combine(fea3d,scr);
    titleText = {
        'gaussian generalRegress',...
        'svm generalRegress', ...
        'ens generalRegress'};
    % generalRegress method
    Rmethod = 1;

%     failed with gmm the features was not a gauss distribution
%     idx = gmmClassify(fs(:,1:end-1),length(modelList));

    generalRegress(fs,fs2d,fs3d,titleText{Rmethod});
    % [score,predictScore] = amtRegress(fs,titleText{Rmethod});
    % showInfo(titleText{Rmethod},score,predictScore,'2d+3d',2,3,1);
    % showErrInfo(titleText{Rmethod},score,predictScore,'2d+3d',2,3,4);
    % [score,predictScore] = amtRegress(fs2d,titleText{Rmethod});
    % showInfo(titleText{Rmethod},score,predictScore,'2d',2,3,2);
    % showErrInfo(titleText{Rmethod},score,predictScore,'2d+3d',2,3,5);
    % [score,predictScore] = amtRegress(fs3d,titleText{Rmethod});
    % showInfo(titleText{Rmethod},score,predictScore,'3d',2,3,3);
    % showErrInfo(titleText{Rmethod},score,predictScore,'2d+3d',2,3,6);
    
elseif strcmp(anaMethodList{anaMethod},'LDL')

    
elseif strcmp(anaMethodList{anaMethod},'svm2kClassifyCombine')
%% svm2k Classify combine
    [gt,pl] = svm2kStart(modelList,rate);
    ln = {'svm2k'};
    plotErrorRate(gt,pl,ln,['svm2k of different method on photos']);
    
elseif strcmp(anaMethodList{anaMethod},'generalRegressVirtual')
%% virtual generalRegress
    [sc,scr,fea2d,fea3d] = dataLoad(modelList);

    [fs,fname] = combine(fea2d,fea3d,scr);
    
    titleText = {
        'gaussian regress',...
        'svm regress', ...
        'ens regress'};
    % generalRegress method
    Rmethod = 3;

%     failed with gmm the features was not a gauss distribution
%     idx = gmmClassify(fs(:,1:end-1),length(modelList));

%     generalRegress(fs,fs2d,fs3d,titleText{Rmethod});

%     Train without direction features
%     boundingBox 13:21, ballCoord 22:23, 2DTheta ,37:41
    directionIndex = [];
    allIndex = 1:size(fs,2);
    unDirIndex = setdiff(allIndex,directionIndex);
    fs = fs(:,unDirIndex);

    [mdl,scaler] = getRegresser(fs,titleText{Rmethod});
           
%     virtualModel = {'zb'};
    virtualModel = {'njuSample'};
    
    [vfea2d,vfea3d] = vdataLoad(virtualModel);
    
    [vf,vfname] = combine(vfea2d,vfea3d);
    
    allIndex = 1:size(vf,2);
    unDirIndex = setdiff(allIndex,directionIndex);
    vf = vf(:,unDirIndex);
    
    vf = vf';
    
    testFea = datascaling(scaler,vf);
    
%     [ps,score] = predict(mdl,testFea');
    ps = predict(mdl,testFea');
    
%     videoResult
    showColorMap;
end
