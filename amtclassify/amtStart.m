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
    'classify',...
    'regress',...
    'LDL'};

anaMethod = 2;

if strcmp(anaMethodList{anaMethod},'classify')

    sc = scload(scorefile,sceneName);
    % scc score classify
%     scc = assScor


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
