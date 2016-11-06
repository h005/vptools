%% this file was created for comparison experiments
% use models in modelList for train and testModel for test
% just compare both 2D3D features
clear
close all
clc

addpath('../')

modelList = {
    'kxm',...
    'bigben',...
    'notredame',...
    'freeGodness',...
    'tajMahal',...
    'cctv3',...
    'capitol',...
    'Sacre',...
    'TengwangPavilion',...
    'mont',...
    'HelsinkiCathedral',...
    'BuckinghamPalace',...
    'BritishMuseum',...
    'BrandenburgGate',...
    'potalaPalace'
};

testModel = {
    'kxm',...
    'potalaPalace',...
    'tajMahal'    
    };

% this code was created for some selected features
[visualFea, geometricFea,validVisIndex, validGeoIndex] = feaNameLoad();

% top rate pictures will be assign good
% last rate pictures will be assign bad
% this parameters should bbe modified as needed
rate = 0.10;
% load Data
% sc = scload(scorefile,sceneName);
[sc,scr,fea2d,fea3d] = dataLoad(modelList);
[fs,fname] = combine(fea2d,fea3d,scr);
% used for svm2k
[fs2d,fname] = combine(fea2d,scr);
[fs3d,fname] = combine(fea3d,scr);


methodTest = {'ens classify',...
    'bayes classify',...
    'svm classify',...
    'SVM-2K classify'};
svm2kMethod = {'svm2k'};

tic
Nmethod = 1; % which methods in methodTest will you test
for i = 1:numel(testModel)
    
    % result preparing
    % gt groundTruth
    % pl preLabel
    % ln plotroc legend name

    % cat function can cantact two cell arrays
%     gcMethod = cat(2,gcMethod,testModel);

    
    gcMethod = {'comparisonClassifyCombine','2D3D combine',methodTest{1},testModel{i}};
    [gt1,pl1,ps1,ln1,scl1] = generalClassify(fs,rate,fname,gcMethod);
    disp(methodTest{1})
    gcMethod = {'comparisonClassifyCombine','2D3D combine',methodTest{2},testModel{i}};
    [gt2,pl2,ps2,ln2,scl2] = generalClassify(fs,rate,fname,gcMethod);
    disp(methodTest{2})
    gcMethod = {'comparisonClassifyCombine','2D3D combine',methodTest{3},testModel{i}};
    [gt3,pl3,ps3,ln3,scl3] = generalClassify(fs,rate,fname,gcMethod);
    disp(methodTest{3})
    
%     gcMethod = {'comparisonClassifyCombine','2D3D combine',svm2kMethod{1},testModel{i}};
%     [gt0,pl0,ps0,ln0,scl0] = generalClassify(fs,rate,fname,gcMethod);
%     disp(svm2kMethod{1})
    [gt0, pl0, ln0] = svm2kClassifyComparisonValidation(fs2d, fs3d, fname, rate, testModel{i},'2D3D combine');
    
    gt{i} = [gt1;gt2;gt3;gt0];
    ps=[ps1;ps2;ps3];
    ln{i} = [ln1;ln2;ln3;ln0];
    pl{i} = [pl1;pl2;pl3;pl0];
    
    disp([testModel{i} ' done'])
end

toc

methodN = {'Ens','SVM','Bayes','SVM-2K'};

plotErrorRateGroup(gt,pl,methodN,methodTest,'Classification performance of different methods on photos');

