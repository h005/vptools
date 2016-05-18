%% this script was a start file
%% for Regress
clear
clc
addpath('../');

modelList = {
    'bigben',...
    'kxm',...
    'notredame'...
    'freeGodness'...
    'tajMahal'
};

anaMethodList = {
    'classifyEach',...
    'classifyCombine',...
    'regress',...
    'LDL'};

anaMethod = 2;
%%
if strcmp(anaMethodList{anaMethod},'classifyEach')
    
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
    plotMethods = {'ROC','PR','ROC PR'};

    method = 2;
    % 2D feature
    [fs2d,fname] = combine(fea2d,scr);
    
    % general classify method
    gcMethod = {anaMethodList{anaMethod},'2D',methodText{method}};
    
    [gt,ps,ln,scl] = generalClassify(fs2d,rate,fname,gcMethod);
    
    plotMethodsId = 1;
    
    classifyPlotHelper(gt,ps,scl,ln,plotMethods{plotMethodsId});

    % 3D feature
    [fs3d,fname] = combine(fea3d,scr);
    
    % general classify method
    gcMethod = {anaMethodList{anaMethod},'3D',methodText{method}};
    
    [gt,ps,ln] = generalClassify(fs3d,rate,fname,gcMethod);
    
    classifyPlotHelper(gt,ps,scl,ln,plotMethods{3});

elseif strcmp(anaMethodList{anaMethod},'classifyCombine')
%%
    % top rate pictures will be assign good
    % last rate pictures will be assign bad
    % this parameters should bbe modified as needed
    rate = 0.1;
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
    [gt3,pl3,ps3,ln3,scl3] = generalClassify(fs3d,rate,fname,gcMethod);
    
    gt = [gt1;gt2;gt3];
    ps = [ps1;ps2;ps3];
    ln = [ln1;ln2;ln3];
    pl = [pl1;pl2;pl3];
    
    scl = scl1;
    
    % plot classify error rate
    plotErrorRate(gt,pl,ln,[methodText{method} 'of different method on photos']);
    plotMethods = {'ROC','PR','ROC PR'};
    classifyPlotHelper(gt,ps,scl,ln,plotMethods{3});
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

elseif strcmp(anaMethodListP{anaMethod},'LDL')

end
