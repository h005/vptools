%% this function was created to make generalClassifyCCA
% function [gt,pl,ps,ln,scl] = generalClassify(fs,rate,fname,method)

% method is a cell array contains 2 values
% method{2} is {'bayes classify','svm classify','ens classify'}
% for 'classifyEach'
% method{1} can be one of {'2d', '3d', '2d3d'}
% for 'calssifyCombine'
% method{2} can be one of {'2D combine','3D combine','2D3D combine'}

% method can be one of {'2D','3D','2D3D'}

% return para gt is ground truth
% pl predict label
% ps predict score i.e. positerior
function [gt,preLabel,ps] = generalClassifyCCA(fs2d, fs3d, rate, method)
%% prepare data
% ten fold seperate data
classifier = method{2};
mode = method{1};
nfold = 10;
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

groundTruth(1:num) = 0;
groundTruth(num+1:2*num) = 1;
label = groundTruth';

indices = crossvalind('Kfold',length(label),nfold);
% load('indices.mat');
scLabel = [];
preLabel = zeros(2 * num, 1);


%% ten fold cross valind
for j=1:nfold
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
    if strcmp(mode,'2d3d')
        N = size(test2d,1);
        test2d = (test2d - repmat(mean(test2d),N,1)) * A;
        test3d = (test3d - repmat(mean(test3d),N,1)) * B;
    elseif strcmp(mode,'2d')
        N = size(test2d,1);
        test2d = (test2d - repmat(mean(test2d),N,1)) * A;
%         test3d = getFeaturesCCA(test2d,V,tf3d,B);
        test3d = getFeaturesCCASpace(test2d,V,r,0.8);
    elseif strcmp(mode,'3d')
        N = size(test3d,1);
        test3d = (test3d - repmat(mean(test3d),N,1)) * B;
%         test2d = getFeaturesCCA(test3d,U,tf2d,A);
        test2d = getFeaturesCCASpace(test3d,U,r,0.8);
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
   
    if strcmp(classifier,'bayes classify')
        mdl1 = bysClassify(tf2d', trainLabel);
        [tmppl1,positerior1,cost1] = predict(mdl1,test2d);
        mdl2 = bysClassify(tf3d', trainLabel);
        [tmppl2,positerior2,cost2] = predict(mdl2,test3d);
        preScore1(test) = 0.5 * positerior1(:,2) + 0.5 * positerior2(:,2);
        preScore2(test) = 0.5 * positerior1(:,1) + 0.5 * positerior2(:,2);
%         preLabel(test) = tmppl;
    elseif strcmp(classifier,'svm classify')
        mdl1 = svmClassify(tf2d',trainLabel);
        [tmppl1,positerior1] = predict(mdl1,test2d);
        mdl2 = svmClassify(tf3d',trainLabel);
        [tmppl2,positerior2] = predict(mdl2,test3d);
        preScore1(test) = 0.5 * positerior1(:,2) + 0.5 * positerior2(:,2);
        preScore2(test) = 0.5 * positerior1(:,1) + 0.5 * positerior2(:,1);
%         preLabel(test) = tmppl;
    elseif strcmp(classifier,'ens classify')
        mdl1 = ensClassify(tf2d',trainLabel);
        [tmppl1,positerior1] = predict(mdl1,test2d);
        mdl2 = ensClassify(tf3d',trainLabel);
        [tmppl2,positerior2] = predict(mdl2,test3d);
        preScore1(test) = 0.5 * positerior1(:,2) + 0.5 * positerior2(:,2);
        preScore2(test) = 0.5 * positerior1(:,1) + 0.5 * positerior2(:,1);
%         [tmppl,score] = predict(mdl,testFea');
%         preScore(test) = score(:,2);
%         preLabel(test) = tmppl;
    else
        disp('parameter error')
    end
    
end
    gt = groundTruth;
    preLabelInd = preScore1 > preScore2;
    preLabel(preLabelInd) = 1;
    preLabelInd = preScore1 <= preScore2;
    preLabel(preLabelInd) = 0;
    ps = preScore1;

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

%% this function was created to compute features in another view
% where ccaFea is the features of one view projected by CCA
% ccaFeaDataSet is the featuers of another view projected by CCA by mean
% corrRate is the corrRelation rate from high to low
% fea is another view projected by CCA
function fea = getFeaturesCCASpace(ccaFea, ccaFeaDataSet, corrRate, threshold)
    N = size(ccaFea,1);
    mfeatures = size(ccaFeaDataSet,2);
    % we just use first num largest corrRate features as to compute KNN
    index = corrRate > threshold;
%     num = sum(index);
    % compute distance by pdist2 and define the distance with cosine
    K = 3; % define KNN's K
    [dis,idx] = pdist2(ccaFeaDataSet(:,index), ccaFea(:,index), 'correlation','Smallest',K);    
%     [dis, ids] = sort(dis,2);
    % dis is K * num and idx K * num
    % construct feaData original just compute all nearest the features
    fea = zeros(N,mfeatures);
    for i=1:size(ccaFea,1)
        tmpFea = ccaFeaDataSet(idx(:,i),:);
        fea(i,:) = mean(tmpFea);
    end
end

%% this function was created to compute features in another view by weighting mean
% where ccaFea is the features of one vieprojected by CCA
% ccaFeaDataSet is the features of another view projected by CCa
% fea is another view projected by CCA
function fea = getFeaturesCCASpaceWeighting(ccaFea, ccaFeaDataSet, corrRate, threshold)
    N = size(ccaFea,1);
    mfeatures = size(ccaFeaDataSet,2);
    % we jsut use first num largest corrRate features as to compute KNN
    index = corrRate > threshold;
    % compute distance by pdist2 and define  the distance with cosine
    K = 3; % define KNN's K
    [dis,idx] = pdist2(ccaFeaDataSet(:,index), ccaFea(:,index), 'cosine','Smallest',K);
    % dis is K * num and idx K * num
    weights = dis;
    for i=1:size(weights,2)
        tmpSum = sum(weights(:,i));
        weights(:,i) = weights(:,i)/tmpSum;
    end
    fea = zeros(N,mfeatures);
    % construct features
    for i = 1:N
        tmpFea = zeros(1,mfeatures);
        for j = 1:K
            tmpFea = tmpFea + weights(j,i) * ccaFeaDataSet(idx(j,i),:);
        end
    end
    
end



