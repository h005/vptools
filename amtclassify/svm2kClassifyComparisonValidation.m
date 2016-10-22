%% this function was careted to run svm2k comparison
function [gt, pl, ln] = svm2kClassifyComparisonValidation(fs2d, fs3d, fname, rate, testModel)
addpath './svm2k'
ln = {'svm2k'};

% find testModel index
% used for test and train
% 2 means other models and used for train
% 1 means test model and used for test
testModelIndex = zeros(numel(fname),1);
for i=1:numel(fname)
   [pathstr,name,ext] = fileparts(fname{i});
   if strcmp(pathstr,testModel)
       testModelIndex(i) = 1;
   end
end

nfold = 2;
sc = fs2d(:,end);
% sort sc asscend
[sortedSc, index] = sort(sc);
[ncases, mfeatures] = size(fs2d);
num = round(ncases * rate);
negIdx = index(1:num);
posIdx = index(end - num + 1 : end);

% construct conbined dataSet
% the last column of fs2d is score
fea2d = zeros( 2 * num ,mfeatures - 1);
fea2d(1:num,:) = fs2d(negIdx,1:end-1);
fea2d(num+1:2*num,:) = fs2d(posIdx,1:end-1);

[ncases, mfeatures] = size(fs3d);
% ths last column of fs3d is score
fea3d = zeros(2 * num, mfeatures - 1);
fea3d(1:num,:) = fs3d(negIdx, 1:end-1);
fea3d(num+1:2*num,:) = fs3d(posIdx,1:end-1);

groundTruth(1:num) = -1;
groundTruth(num+1:2*num) = 1;
label = groundTruth';

modelIndices = [testModelIndex(negIdx);testModelIndex(posIdx)];
testCasesCount = sum(modelIndices);
indices = [testModelIndex(negIdx);testModelIndex(posIdx)];
% indices = crossvalind('Kfold',length(label),nfold);

scLabel = [];
preLabel = zeros(2 * num, 1);

% for j=1:nfold
j=1;
test = (indices == j);
train = ~test;
% train feature 2d namded as tf2d
% train feature 3d nameed as tf3d
tf2d = fea2d(train,:);
tf3d = fea3d(train,:);
test2d = fea2d(test,:);
test3d = fea3d(test,:);


%% these code may be recoded
% coded features by CCA
% compute CCA
[A,B,r,U,V] = canoncorr(tf2d,tf3d);
% map to another space
mode = '2d3d';
if strcmp(mode,'2d3d')
    N = size(test2d,1);
    test2d = (test2d - repmat(mean(test2d),N,1)) * A;
    test3d = (test3d - repmat(mean(test3d),N,1)) * B;
elseif strcmp(mode,'2d')
    N = size(test2d,1);
    test2d = (test2d - repmat(mean(test2d),N,1)) * A;
    test3d = getFeaturesCCA(test2d,V,tf3d,B);
elseif strcmp(mode,'3d')
    N = size(test3d,1);
    test3d = (test3d - repmat(mean(test3d),N,1)) * B;
    test2d = getFeaturesCCA(test3d,U,tf2d,A);
end

% define a threshold here to control the cca features.
% threshold is the features' coefficient of correlation
threshold = 0;
ind = r > threshold;
tf2d = U(:,ind);
tf3d = V(:,ind);

%%
% data scale
[tf2d, ps] = mapminmax(tf2d',0,1);
tf2d = tf2d';
test2d = mapminmax('apply',test2d', ps);
test2d = test2d';

[tf3d, ps] = mapminmax(tf3d',0,1);
tf3d = tf3d';
test3d = mapminmax('apply',test3d',ps);
test3d = test3d';

trainLabel = label(train);
testLabel = label(test);

%     CA = 0.2;
%     CB = 0.2;
%     D = 0.1;
%     eps = 0.01;
CA = 4.0;
CB = 4.0;
D = 0.1;
eps = 0.01;
% this parameter is about kernel
ifeature = 1;

[acorr,acorr1,acorr2,...
    pre,pre1,pre2,...
    hit,hit1,hit2,...
    tpre,tpre1,tpre2,...
    ga,gb,bam,bbm,...
    alpha_A,alpha_B]= ...
    mc_svm_2k_lava2(tf2d,tf3d,trainLabel,...
    test2d,test3d,testLabel,...
    CA,CB,D,eps,ifeature);

preLabel(test) = pre;

pl = preLabel > 0;
pl = 2 * pl - 1;
pl = pl';
modelIndices = modelIndices == 1;
gt = groundTruth(modelIndices);
pl = pl(modelIndices);
% end
end


%% this function was created to compute features in another view
% where ccaFea is the features of one view projected by CCA
% ccaFeaDataSet is the features of another view projected by CCA
% feaDataSet is the features of another view
% convertPara is the convertParameters used to convert the features

% ccaFea, ccaFeaDataSet and feaDataSet are all ncases * mfeatures

function fea = getFeaturesCCA(ccaFea, ccaFeaDataSet, feaDataSet, convertPara)
    N = size(ccaFea,1);
    % compute distance by pdist2 and define the distance with cosine
    dis = pdist2(ccaFea, ccaFeaDataSet,'cosine');
    K = 1; % define K as 5
    [dis,index] = sort(dis,2);
    % construct feaData original just compute all nearest the features
    feaDataOriginal = zeros(size(ccaFea,1),size(feaDataSet,2));
    % alloc some space
%     fea = zeros(size(ccaFea,1),);
    for i=1:size(feaDataOriginal,1)
        tmpFea = feaDataSet(index(i,1:K),:);
        feaDataOriginal(i,:) = mean(tmpFea);
    end
    fea = (feaDataOriginal - repmat(mean(feaDataOriginal),N,1)) * convertPara;
end
