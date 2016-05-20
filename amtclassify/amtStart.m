%% this script was a start file
%% for Regress
clear
close all
clc
addpath('../');

modelList = {
    'bigben',...
    'kxm',...
    'notredame',...
    'freeGodness',...
    'tajMahal'
};

anaMethodList = {
    'classifyEach',...
    'classifyCombine',...
    'regress',...
    'regressVirtual'...
    'classifyVirtual'...
    'LDL'};

anaMethod = 2;

if strcmp(anaMethodList{anaMethod},'classifyEach')
%%    
    % top rate pictures will be assign good
    % last rate pictures will be assign bad
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
    
    % general classify method
    gcMethod = {anaMethodList{anaMethod},'2D',methodText{method}};
    
    [gt,pl,ps,ln,scl] = generalClassify(fs2d,rate,fname,gcMethod);
    
    titleLabel = ['2D feature ' plotMethods{plotMethodsId} ' curve of ' methodText{method}];
    classifyPlotHelper(gt,ps,scl,ln,plotMethods{plotMethodsId},titleLabel);

    % 3D feature
    [fs3d,fname] = combine(fea3d,scr);
    
    % general classify method
    gcMethod = {anaMethodList{anaMethod},'3D',methodText{method}};
    
    [gt,pl,ps,ln,scl] = generalClassify(fs3d,rate,fname,gcMethod);
    titleLabel = ['3D feature ' plotMethods{plotMethodsId}  ' curve of ' methodText{method}];
    classifyPlotHelper(gt,ps,scl,ln,plotMethods{plotMethodsId},titleLabel);
elseif strcmp(anaMethodList{anaMethod},'classifyVirtual')
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
    
    virtualModel = {'teaHouse'};
    
    [vfea2d,vfea3d] = vdataLoad(virtualModel);
    
    [vf,vfname] = combine(vfea2d,vfea3d);
    
    vf = vf';
    
    testFea = datascaling(scaler,vf);
    
    ps = predict(mdl,testFea');
    
    
elseif strcmp(anaMethodList{anaMethod},'classifyCombine')
%%
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
elseif strcmp(anaMethodList{anaMethod},'regress')

    % scr score regress

    [sc,scr,fea2d,fea3d] = dataLoad(modelList);

    [fs,fname] = combine(fea2d,fea3d,scr);
    [fs2d,fname] = combine(fea2d,scr);
    [fs3d,fname] = combine(fea3d,scr);
    titleText = {
        'gaussian regress',...
        'svm regress', ...
        'ens regress'};
    % regress method
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

elseif strcmp(anaMethodList{anaMethod},'regressVirtual')
    
    [sc,scr,fea2d,fea3d] = dataLoad(modelList);

    [fs,fname] = combine(fea2d,fea3d,scr);
    
    titleText = {
        'gaussian regress',...
        'svm regress', ...
        'ens regress'};
    % regress method
    Rmethod = 1;

%     failed with gmm the features was not a gauss distribution
%     idx = gmmClassify(fs(:,1:end-1),length(modelList));

%     generalRegress(fs,fs2d,fs3d,titleText{Rmethod});
    
    [mdl,scaler] = getRegresser(fs,titleText{Rmethod});
           
    virtualModel = {'teaHouse'};
    
    [vfea2d,vfea3d] = vdataLoad(virtualModel);
    
    [vf,vfname] = combine(vfea2d,vfea3d);
    
    vf = vf';
    
    testFea = datascaling(scaler,vf);
    
    ps = predict(mdl,testFea');
    
end
