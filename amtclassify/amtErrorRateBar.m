%% this script was created to plot classify error bar
% just for combine classify
clear
close all
clc
time = tic;
addpath('../');
addpath('../fisherVector/')
addpath('./svm2k')

modelList = {
    'bigben',...
    'kxm',...
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

% top rate pictures will be assign good
% last rate pictures will be assign bad
% this parameters should bbe modified as needed
rate = 0.10;
% load Data
% sc = scload(scorefile,sceneName);
[sc,scr,fea2d,fea3d] = dataLoad(modelList);
[fs,fname] = combine(fea2d,fea3d,scr);
[fs2d,fname] = combine(fea2d,scr);
[fs3d,fname] = combine(fea3d,scr);

% this code was created for some selected features
[visualFea, geometricFea,validVisIndex, validGeoIndex] = feaNameLoad();
validVisIndex = sort(validVisIndex);
validGeoIndex = sort(validGeoIndex);
fs2d = fs2d(:,[validVisIndex,size(fs2d,2)]);
fs3d = fs3d(:,[validGeoIndex,size(fs3d,2)]);
fs = fs(:,[validVisIndex,visualFea{end}.index(end)+validGeoIndex, size(fs,2)]);
% set Method
methodText = {
    'bayes classify',...
%     'svm classify',...
    'ens classify'
    };
method = 3;

for i=1:numel(methodText)
    
    % result preparing
    % gt  groundTruth
    % pl  preLabel
    % ln  plotroc legend name
    % general classify methods
    
%     gcMethod = {'FVclassifyCombine','2D combine',methodText{i}};
%     [gt1,pl1,ps1,ln1,scl1] = generalClassify(fs2d,rate,fname,gcMethod);
    
%     gcMethod = {'generalClassifyCombine','2D combine',methodText{i}};
%     [gt1,pl1,ps1,ln1,scl1] = generalClassify(fs2d,rate,fname,gcMethod);
    
    gcMethod = {'generalClassifyCombine','2D combine',methodText{i}};
    [gt1,pl1,ps1,ln1,scl1] = generalClassify(fs2d,rate,fname,gcMethod);

    gcMethod = {'generalClassifyCombine','3D combine',methodText{i}};
    [gt2,pl2,ps2,ln2,scl2] = generalClassify(fs3d,rate,fname,gcMethod);

%     gcMethod = {'FVclassifyCombine','2D3D combine',methodText{i}};
%     [gt3,pl3,ps3,ln3,scl3] = generalClassify(fs3d,rate,fname,gcMethod);

    gcMethod = {'generalClassifyCombine','2D3D combine',methodText{i}};
    [gt3,pl3,ps3,ln3,scl3] = generalClassify(fs,rate,fname,gcMethod);
    
    gt{i} = [gt1;gt2;gt3];
    ps = [ps1;ps2;ps3];
    ln{i} = [ln1;ln2;ln3];
    pl{i} = [pl1;pl2;pl3];
%     scl = scl1;

    % plot classify error rate    
%     plotMethods = {'ROC','PR','ROC PR'};
%     plotMethodsId = 1;
%     titleLabel = ['combine features ' plotMethods{plotMethodsId} ' curve of ' methodText{method}];
%     classifyPlotHelper(gt,ps,scl,ln,plotMethods{plotMethodsId},titleLabel);
disp(methodText{i})
end

methodText = {'SVM-2K'};
mode = {'2D','3D','2D3D'};

[gt1,ps1] = svm2kClassify(fs2d,fs3d,rate,mode{1});
pl1 = ps1>0;
pl1 = 2 * pl1 - 1;
pl1 = pl1';
disp('SVM-2K 2D')
[gt2,ps2] = svm2kClassify(fs2d,fs3d,rate,mode{2});
pl2 = ps2>0;
pl2 = 2 * pl2 - 1;
pl2 = pl2';
disp('SVM-2K 3D')
[gt3,ps3] = svm2kClassify(fs2d,fs3d,rate,mode{3});
pl3 = ps3>0;
pl3 = 2 * pl3 - 1;
pl3 = pl3';
disp('SVM-2K 2D3D')
gt{numel(gt)+1} = [gt1;gt2;gt3];
pl{numel(gt)} = [pl1;pl2;pl3];


featuresN = {'2D','3D','2D&3D'};
methodsN = {'Bayes','Ens','SVM-2K'};
plotErrorRateGroup(gt,pl,featuresN,methodsN,'Classification performance of different methods on photos');
toc(time)
