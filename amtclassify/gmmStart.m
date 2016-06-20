%% this file was created for gmm start
clear
close all
clc
addpath('../');

modelList = {'bigben', 'kxm', 'notredame', 'freeGodness', 'tajMahal', 'cctv'};

anaMethodList = {
    'generalClassifyCombineErrorRateBar',...
    'generalRegressVirtual',...
    'generalClassifyVirtual'
};

anaMethod = 1;

% created to plot error rate bar
if strcmp(anaMethodList{anaMethod},'generalClassifyCombineErrorRateBar')
    rate = 0.1; % num of top rate assigned as good while bottom rate assigned as bad
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

    for i = 1:numel(methodText)
        gcMethod = {'generalGMMClassifyCombine','2D combine',methodText{i}};
        [gt1,pl1,ps1,ln1,scl1] = generalClassify(fs2d,rate,fname,gcMethod);
        gcMethod = {'generalGMMClassifyCombine','3D combine',methodText{i}};
        [gt2,pl2,ps2,ln2,scl2] = generalClassify(fs3d,rate,fname,gcMethod);
        gcMethod = {'generalGMMClassifyCombine','2D3D combine',methodText{i}};
        [gt3,pl3,ps3,ln3,scl3] = generalClassify(fs,rate,fname,gcMethod);
        
        gt{i} = [gt1;gt2;gt3];
        pl{i} = [pl1;pl2;pl3];
        
    end

    featuresN = {'2D','3D','2D&3D'};
    methodsN = {'Bayes','SVM','Ens'};
    plotErrorRateGroup(gt,pl,featuresN,methodsN,'Classification performance of different methods on phtots');
    
elseif strcmp(anaMethodList{anaMethod},'generalRegressVirtual')
    
elseif strcmp(anaMethodList{anaMethod},'generalClassifyVirtual')
    
end

