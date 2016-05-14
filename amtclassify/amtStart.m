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
    
    method = 2;
    
    feaName = loadFeaName('/home/h005/Documents/vpDataSet/kxm/vpFea/kxm.2dfname');    
    %% 2D feature
    [fs2d,fname] = combine(fea2d,scr);
    
    figure(2)
    classifyEach(fs2d,feaName,rate,fname,methodText{method});
    figure(2);
    title(['fea2d ROC ' methodText{method}]);
    
    feaName = loadFeaName('/home/h005/Documents/vpDataSet/kxm/vpFea/kxm.3dfname');
    %% 3D feature
    [fs3d,fname] = combine(fea3d,scr);
   
    figure(3)
    classifyEach(fs3d,feaName,rate,fname,methodText{method});
    figure(3)
    title(['fea3d ROC ' methodText{method}]);
    
    % sc = scload(scorefile,sceneName);
    % scc score classify
	% scc = assScor

elseif strcmp(anaMethodList{anaMethod},'classifyCombine')
    
    % top rate pictures will be assign good
    % last rate pictures will be assign bad
    % this parameters should bbe modified as needed
    rate = 0.2;
    %% load Data
    % sc = scload(scorefile,sceneName);
    [sc,scr,fea2d,fea3d] = dataLoad(modelList);
    [fs,fname] = combine(fea2d,fea3d,scr);
    [fs2d,fname] = combine(fea2d,scr);
    [fs3d,fname] = combine(fea3d,scr);
    %% set Method 
    methodText = {
        'bayes classify',...
        'svm classify',...
        'ens classify'
        };
    method = 1;
    %% result preparing
    % gt  groundTruth
    % pl  preLabel
    % ln  plotroc legend name
    %% 2D features combine
    [groundTruth, preLabel] ... 
    = classifyCombine(fs2d,rate,fname,methodText{method});
    gt(1,:) = groundTruth;
    pl(1,:) = preLabel;
    ln{1} = '2D combine';
    [groundTruth, preLabel] ...
    = classifyCombine(fs3d,rate,fname,methodText{method});
    gt(2,:) = groundTruth;
    pl(2,:) = preLabel;
    ln{2} = '3D combine';
    [groundTruth, preLabel] ...
    = classifyCombine(fs,rate,fname,methodText{method});
    gt(3,:) = groundTruth;
    pl(3,:) = preLabel;
    ln{3} = '2D_3D';
    
    plotroc(gt,pl);
    title(['fea combine ROC ',methodText{method}]);
    
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
