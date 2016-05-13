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

anaMethod = 1;

if strcmp(anaMethodList{anaMethod},'classifyEach')
    
    % top rate pictures will be assign good
    % last rate pictures will be assign bad
    % this parameters shold be modified as you like
    rate = 0.1;
    
    [sc,scr,fea2d,fea3d] = dataLoad(modelList);

    methodText = {
        'bayes classify',...
        'svm classify'};
    
    feaName = loadFeaName('/home/h005/Documents/vpDataSet/kxm/vpFea/kxm.2dfname');    
    %% 2D feature
    [fs2d,fname] = combine(fea2d,scr);
    
    
    
    
    feaName = loadFeaName('/home/h005/Documents/vpDataSet/kxm/vpFea/kxm.3dfname');
    %% 3D feature
    [fs3d,fname] = combine(fea3d,scr);
    
    
    % sc = scload(scorefile,sceneName);
    % scc score classify
	% scc = assScor

elseif strcmp(anaMethodList{anaMethod},'classifyCombine')
    
    % sc = scload(scorefile,sceneName);
    
    
    
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
