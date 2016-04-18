%% this script was a start file
%% for Regress
clear
clc
addpath('../');
sceneName = 'kxm';
scorefile = ['/home/h005/Documents/vpDataSet/' sceneName '/score/' sceneName '.sc'];
fea2Dfile = ['/home/h005/Documents/vpDataSet/' sceneName '/vpFea/' sceneName '.2df'];
fea3Dfile = ['/home/h005/Documents/vpDataSet/' sceneName '/vpFea/' sceneName '.3df'];

anaMethodList = {
    'classify',...
    'regress',...
    'LDL'};

anaMethod = 2;

if strcmp(anaMethodListP{anaMethod},'classify')
    
    sc = scload(scorefile);
    % scc score classify
%     scc = assScor
    
    
elseif strcmp(anaMethodListP{anaMethod},'regress')
    
    sc = scload(scorefile);
    % scr score regress
    scr = assScore(sc,'ave');

    fea2d = scload(fea2Dfile);
    fea3d = scload(fea3Dfile);

    [fs,fname] = combine(fea2d,fea3d,scr);
    [fs2d,fname] = combine(fea2d,scr);
    [fs3d,fname] = combine(fea3d,scr);
    titleText = {
        'gaussian regress',...
        'svm regress', ...
        'ens regress'};
    % regress method
    Rmethod = 3;

    [score,predictScore] = amtRegress(fs,titleText{Rmethod});
    showInfo(titleText{Rmethod},score,predictScore,'2d+3d',2,3,1);
    showErrInfo(titleText{Rmethod},score,predictScore,'2d+3d',2,3,4);
    [score,predictScore] = amtRegress(fs2d,titleText{Rmethod});
    showInfo(titleText{Rmethod},score,predictScore,'2d',2,3,2);
    showErrInfo(titleText{Rmethod},score,predictScore,'2d+3d',2,3,5);
    [score,predictScore] = amtRegress(fs3d,titleText{Rmethod});
    showInfo(titleText{Rmethod},score,predictScore,'3d',2,3,3);
    showErrInfo(titleText{Rmethod},score,predictScore,'2d+3d',2,3,6);

elseif strcmp(anaMethodListP{anaMethod},'LDL')
    
end

