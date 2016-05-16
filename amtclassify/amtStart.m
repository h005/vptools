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

plotMarker = {'o',...
    'd',...
    'x',...    
    '.',...
    '*',...
    's',...
    '+',...    
    '^',...
    'v',...
    '>',...
    '<',...
    'p',...
    'h',...
    'o',...
    '+',...
    '*',...
    '.',...
    'x',...
    's',...
    'd',...
    '^',...
    'v',...
    '>',...
    '<',...
    'p',...
    'h'};

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
    
    classifyEach(fs2d,feaName,rate,fname,methodText{method},'fea2D');
    
    feaName = loadFeaName('/home/h005/Documents/vpDataSet/kxm/vpFea/kxm.3dfname');
    %% 3D feature
    [fs3d,fname] = combine(fea3d,scr);
  
    classifyEach(fs3d,feaName,rate,fname,methodText{method},'fea3D');
    
    % sc = scload(scorefile,sceneName);
    % scc score classify
	% scc = assScor

elseif strcmp(anaMethodList{anaMethod},'classifyCombine')
    
    % top rate pictures will be assign good
    % last rate pictures will be assign bad
    % this parameters should bbe modified as needed
    rate = 0.05;
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
    %% features combine
    [groundTruth, preLabel, preScore] ... 
    = classifyCombine(fs2d,rate,fname,methodText{method});
    gt(1,:) = groundTruth;
    pl(1,:) = preLabel;
    csc(1,:) = preScore;
    ln{1} = '2D combine';
    [groundTruth, preLabel, preScore] ...
    = classifyCombine(fs3d,rate,fname,methodText{method});
    gt(2,:) = groundTruth;
    pl(2,:) = preLabel;
    csc(2,:) = preScore;
    ln{2} = '3D combine';
    [groundTruth, preLabel, preScore] ...
    = classifyCombine(fs,rate,fname,methodText{method});
    gt(3,:) = groundTruth;
    pl(3,:) = preLabel;
    csc(3,:) = preScore;
    ln{3} = '2D3D';
    %% plot classify error rate
    plotErrorRate(gt,pl,ln,[methodText{method} 'of different method on photos']);
    
    %% plot PR precision recall
    X = cell(size(gt,1),1);
    Y = cell(size(gt,1),1);
    for i=1:size(gt,1)
    [prec, tpr, fpr, thresh] = ...
        prec_rec(csc(i,:), gt(i,:), 'plotROC',0,'plotPR',0);
    X{i} = [0; tpr];
    Y{i} = [1; prec];
    end
    figure
    plot(X{1},Y{1},'Marker',plotMarker{1})
    hold on
    for i=2:size(gt,1)
        plot(X{i},Y{i},'Marker',plotMarker{i});
    end
    fN = {'2D combine','3D combine','2D3D combine'};
    legend(fN,'Location','best');
    xlabel('recall');
    ylabel('precision');
    title('Performance of combined features on the photos');
    hold off
    
    %% plot ROC
    X = cell(size(gt,1),1);
    Y = cell(size(gt,1),1);
    
    for i=1:size(gt,1)
        [tmpx,tmpy,tmpt,tmpauc] = ...
            perfcurve(gt(i,:),csc(i,:),1);
        X{i} = tmpx(1:10:end);
        Y{i} = tmpy(1:10:end);
    end
    
    figure
    plot(X{1},Y{1},'Marker',plotMarker{1});
    hold on
    for i=2:size(gt,1)
        plot(X{i},Y{i},'Marker',plotMarker{i});
    end
    legend(fN,'Location','best');
    xlabel('False positive rate');
    ylabel('True positive rate');
%     plotroc(gt,csc);
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
