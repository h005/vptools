%% this script was a start file
%% for generalRegress
clear
close all
clc
addpath('../');

modelList = {
    'bigben',...
    'kxm',...
    'notredame',...
    'freeGodness',...
    'tajMahal',...
    'cctv3'...
    };

anaMethodList = {
    'generalClassifyEach',... % 1
    'generalClassifyCombine',... % 2
    'generalRegress',... % 3
    'generalRegressVirtual'... % 4
    'generalClassifyVirtual'... % 5
    'encodingClassifyCombine',... % 6
    'svm2kClassifyCombine',... % 7
    'svm2kClassifyCombineCCA',... % 8
    'svm2kRegressCombineCCA',... %9
    'combineCCA',... % 10
    'generalClassifyCombineFisherVector',... % 11
    'LDL'}; % 12

anaMethod = 9;

if strcmp(anaMethodList{anaMethod},'generalClassifyEach')
%%
    % top rate pictures will be assign as good
    % last rate pictures will be assign as bad
    % this parameters shold be modified as you like
    rate = 0.08;

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

    % general classify method paramenters
    gcMethod = {anaMethodList{anaMethod},'2D',methodText{method}};

    [gt,pl,ps,ln,scl] = generalClassify(fs2d,rate,fname,gcMethod);
    titleLabel = ['2D feature ' plotMethods{plotMethodsId} ' curve of ' methodText{method}];
    classifyPlotHelper(gt,ps,scl,ln,plotMethods{plotMethodsId},titleLabel);

    % 3D feature
    [fs3d,fname] = combine(fea3d,scr);

    % general classify method parameters
    gcMethod = {anaMethodList{anaMethod},'3D',methodText{method}};

    [gt,pl,ps,ln,scl] = generalClassify(fs3d,rate,fname,gcMethod);
    titleLabel = ['3D feature ' plotMethods{plotMethodsId}  ' curve of ' methodText{method}];
    classifyPlotHelper(gt,ps,scl,ln,plotMethods{plotMethodsId},titleLabel);
elseif strcmp(anaMethodList{anaMethod},'generalClassifyCombineFisherVector')
    rate = 0.08;
    [sc,scr,fea2d,fea3d] = dataLoad(modelList);
    [fs,fname] = combine(fea2d,fea3d,scr);
    [fs3d,fname] = combine(fea3d,scr);
    % set Method
    methodText = {
    'bayes classify',...
    'svm classify',...
    'ens classify'
    };
    for i = 1:numel(methodText)
        gcMethod = {'generalClassifyCombineFV','2D combine',methodText{i}};
%         [gt1,pl1,ps1,ln1,scl1] =
        gcMethod = {'generalClassifyCombineFV','2D combine',methodText{i}};

        gcMethod = {'generalClassifyCombineFV','2D combine',methodText{i}};
    end


elseif strcmp(anaMethodList{anaMethod},'generalClassifyVirtual')
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

%     virtualModel = {'teaHouse'};
    virtualModel = {'zb'};

    [vfea2d,vfea3d] = vdataLoad(virtualModel);

    [vf,vfname] = combine(vfea2d,vfea3d);

    vf = vf';

    testFea = datascaling(scaler,vf);

    ps = predict(mdl,testFea');


elseif strcmp(anaMethodList{anaMethod},'generalClassifyCombine')
%% calssiyfCombine
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
    % select for some features
    % details was showed in feaNameLoad.m
%     [visualFea, geometricFea,validVisIndex, validGeoIndex] = feaNameLoad();
%     fs2d = fs2d(:,[validVisIndex,size(fs2d,2)]);
%     fs3d = fs3d(:,[validGeoIndex,size(fs3d,2)]);
%     fs = fs(:,[validVisIndex,visualFea{end}.index(end)+validGeoIndex, size(fs,2)]);

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
    titleText = {[methodText{method} ' of different method on photos']};
    % plot classify error rate
    plotErrorRate(gt,pl,ln,titleText);
    plotMethods = {'ROC','PR','ROC PR'};
    plotMethodsId = 1;
    titleLabel = ['combine features ' plotMethods{plotMethodsId} ' curve of ' methodText{method}];
    classifyPlotHelper(gt,ps,scl,ln,plotMethods{plotMethodsId},titleLabel);
elseif strcmp(anaMethodList{anaMethod},'combineCCA')
    %% calssiyfCombine
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
    % select for some features
    % details was showed in feaNameLoad.m
%     [visualFea, geometricFea,validVisIndex, validGeoIndex] = feaNameLoad();
%     fs2d = fs2d(:,[validVisIndex,size(fs2d,2)]);
%     fs3d = fs3d(:,[validGeoIndex,size(fs3d,2)]);
%     fs = fs(:,[validVisIndex,visualFea{end}.index(end)+validGeoIndex, size(fs,2)]);

    % set Method
    methodText = {
        'bayes classify',...
        'svm classify',...
        'ens classify'
        };
    method = 3;
    
    combineMethod = {'stack','weight'};
    combineMethodInd = 1;
    
    % result preparing
    % gt  groundTruth
    % pl  preLabel
    % ln  plotroc legend name
    % general cca classify methods
    gccaMethod = {'2d',methodText{method},combineMethod{combineMethodInd}};
%     [gt,pl,ps,ln,scl] = generalClassifyCCA(fs2d, fs3d, rate, method)
    [gt1,pl1,ps1] = generalClassifyCCA(fs2d,fs3d,rate,gccaMethod);
    gccaMethod = {'3d',methodText{method},combineMethod{combineMethodInd}};
    [gt2,pl2,ps2] = generalClassifyCCA(fs2d,fs3d,rate,gccaMethod);
    gccaMethod = {'2d3d',methodText{method},combineMethod{combineMethodInd}};
    [gt3,pl3,ps3] = generalClassifyCCA(fs2d,fs3d,rate,gccaMethod);

    gt = [gt1;gt2;gt3];
    ps = [ps1;ps2;ps3];
    ln = {'2d','3d','2d3d'};
    pl = [pl1;pl2;pl3];

    
    titleText = {'Combine cca of different method on photos'};
    plotErrorRate(gt,pl,ln,titleText);
    
%     scl = scl1;
%     titleText = {[methodText{method} ' of different method on photos']};
%     % plot classify error rate
%     plotErrorRate(gt,pl,ln,titleText);
%     plotMethods = {'ROC','PR','ROC PR'};
%     plotMethodsId = 1;
%     titleLabel = ['combine features ' plotMethods{plotMethodsId} ' curve of ' methodText{method}];
%     classifyPlotHelper(gt,ps,scl,ln,plotMethods{plotMethodsId},titleLabel);
elseif strcmp(anaMethodList{anaMethod},'encodingClassifyCombine')
%% encoding classify by combined features CCA
    % top rate pictures will be assigned as good
    % last rate pictures will be assigned as bad
    % this paramenters should will be modified as needed
    rate = 0.8;
    % load Data
    % sc = scload(scorefile,sceneName);
    [sc,scr,fea2d,fea3d] = dataLoad(modelList);
    [fs,fname] = combine(fea);


elseif strcmp(anaMethodList{anaMethod},'generalRegress')
%% generalRegress
    % scr score generalRegress

    [sc,scr,fea2d,fea3d] = dataLoad(modelList);

    [fs,fname] = combine(fea2d,fea3d,scr);
    [fs2d,fname] = combine(fea2d,scr);
    [fs3d,fname] = combine(fea3d,scr);
    titleText = {
        'gaussian generalRegress',...
        'svm generalRegress', ...
        'ens generalRegress'};
    % generalRegress method
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


elseif strcmp(anaMethodList{anaMethod},'svm2kClassifyCombine')
%% svm2k Classify combine
    rate = 0.08;
    [gt1,pl1] = svm2kStart(modelList,rate,0.8);
    [gt2,pl2] = svm2kStart(modelList,rate,0.6);
    [gt3,pl3] = svm2kStart(modelList,rate,0);
    gt = [gt1;gt2;gt3];
    pl = [pl1;pl2;pl3];    
    ln = {'svm2kCoorRate 0.8','svm2kCoorRate 0.6','svm2kCoorRate 0'};
    titleText = {'Svm2k of different method on photos'};
    plotErrorRate(gt,pl,ln,titleText);
elseif strcmp(anaMethodList{anaMethod},'svm2kClassifyCombineCCA')
%% CCA with svm2k combine
    rate = 0.1;
    % for valid both 2d and 3d features
    % valid 2d or 3d featurs by modeList.
    modeList  = {'2d3d','2d','3d'};
    % valid all the methods
    [gt1,pl1] = svm2kCCAStart(modelList,rate,modeList{1});
    [gt2,pl2] = svm2kCCAStart(modelList,rate,modeList{2});
    [gt3,pl3] = svm2kCCAStart(modelList,rate,modeList{3});
    gt = [gt1;gt2;gt3];
    pl = [pl1;pl2;pl3];
    ln = {'2d3d','2d','3d'};
%     ln = {'svm2k'};
    titleText = {'Svm2k of different method on photos'};
    plotErrorRate(gt,pl,ln,titleText);
elseif strcmp(anaMethodList{anaMethod},'svm2kRegressCombineCCA')
%% CCA regress with svm2k combine just apply sigmod function active the distance to hyper plane
    rate = 0.1;
    addpath('./svm2k/')
    [sc,scr,fea2d,fea3d] = dataLoad(modelList);
    [fs,fname] = combine(fea2d,fea3d,scr);
    [fs2d,fname] = combine(fea2d,scr);
    [fs3d,fname] = combine(fea3d,scr);
    % set Method
    methodText = {'Svm2k regress'};
    virtualModel = {'villa7s'};
    
    [vfea2d,vfea3d] = vdataLoad(virtualModel);
    len2d = numel(vfea2d{1}.fs);
    [vf, vfname] = combine(vfea2d,vfea3d);
    vf2d = vf(:,1:len2d);
    vf3d = vf(:,len2d+1:end);
    
    ps = svm2kRegress(fs2d,fs3d,rate,vf2d,vf3d);
    showColorMap;
    
elseif strcmp(anaMethodList{anaMethod},'generalRegressVirtual')
%% virtual generalRegress
    [sc,scr,fea2d,fea3d] = dataLoad(modelList);

    [fs,fname] = combine(fea2d,fea3d,scr);

    titleText = {
        'gaussian regress',...
        'svm regress', ...
        'ens regress'};
    % generalRegress method
    Rmethod = 3;

%     failed with gmm the features was not a gauss distribution
%     idx = gmmClassify(fs(:,1:end-1),length(modelList));

%     generalRegress(fs,fs2d,fs3d,titleText{Rmethod});

%     Train without direction features
%     boundingBox 13:21, ballCoord 22:23, 2DTheta ,37:41
    directionIndex = [];
    allIndex = 1:size(fs,2);
    unDirIndex = setdiff(allIndex,directionIndex);
    fs = fs(:,unDirIndex);

    [mdl,scaler] = getRegresser(fs,titleText{Rmethod});

%     virtualModel = {'zb'};
    virtualModel = {'njuSample'};
%     virtualModel = {'njuGuLou'};

    [vfea2d,vfea3d] = vdataLoad(virtualModel);

    [vf,vfname] = combine(vfea2d,vfea3d);

    allIndex = 1:size(vf,2);
    unDirIndex = setdiff(allIndex,directionIndex);
    vf = vf(:,unDirIndex);

    vf = vf';

    testFea = datascaling(scaler,vf);

%     [ps,score] = predict(mdl,testFea');
    ps = predict(mdl,testFea');

%     videoResult
    showColorMap;
end
