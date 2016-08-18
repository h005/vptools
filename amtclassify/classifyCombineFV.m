%% this function was created to classify fisherVector features
% fs: fea + sc; ncases * mfea
% rate : top rate will be labeled as positive
%        last rate will be labeled as negative
% fname: file name, ie image's names

% output:
% groundTruth, preScore were used to plotroc curve
% fN is the legend name on roc curve

function [groundTruth, preLabel, preScore, scLabel] ... 
    = classifyCombineFV(fs,rate,fname,method)
% score
sc = fs(:,end);
[sortedSc, index] = sort(sc);
% [ncases, mfeatures] = size(fs);
ncases = numel(fname);
num = round(ncases * rate);
negIdx = index(1:num);
posIdx = index(end - num + 1 : end);

groundTruth = zeros(1, 2 * num);
preLabel = zeros(1, 2 * num);
preScore = zeros(1, 2 * num);

% generate fea
% 1. load all sift mats to generate a dictionary.
% 2. GMM 
% 3. generate features for train and test items; 

% deal with fname

% assume that our generate data is dict
% dict is mfeatures * ncases
siftFname = convertFname(fname);
dict = siftLoader(siftFname);
numClusters = 30;
[means, covariances, priors] = vl_gmm(dict,numClusters);
fea1 = siftLoader(siftFname{negIdx});
fea2 = siftLoader(siftFname{posIdx});
fea = [fea1,fea2];
fea = vl_fisher(fea, means, covariances, priors);


% N fold
nfold = 10;
label = zeros(2*num,1);
label(num + 1 : 2 * num) = 1;
groundTruth(:) = label';

indices = crossvalind('Kfold',length(label),nfold);

for j=1:nfold
    
    test = (indices == j);
    train = ~test;
    
    trainFea = fea(:,train);
    testFea = fea(:,test);
    
    trainLabel = label(train);
    
    % data scale
%     scaler =  dataScaler(trainFea,'minMax');
%     trainFea = datascaling(scaler,trainFea);
%     testFea = datascaling(scaler,testFea);
    
    if strcmp(method,'bayes classify')
        mdl = bysClassify(trainFea, trainLabel);
        [tmppl,positerior,cost] = predict(mdl,testFea');
        preScore(test) = positerior(:,2);
        preLabel(test) = tmppl;
    elseif strcmp(method,'svm classify')
        mdl = svmClassify(trainFea,trainLabel);
        [tmppl,score] = predict(mdl,testFea');
        preScore(test) = score(:,2);
        preLabel(test) = tmppl;
    elseif strcmp(method,'ens classify')
        mdl = ensClassify(trainFea,trainLabel);
        [tmppl,score] = predict(mdl,testFea');
        preScore(test) = score(:,2);
        preLabel(test) = tmppl;        
    end
    scLabel = mdl.ClassNames(end);    
end

end
function siftFname = convertFname(fname)
    siftFname = cell(1,numel(fname));
    for i=1:numel(fname)
        [model,name,ext] = fileparts(fname{i});
        siftFname{i} = ['../vpData/', model, '/sift/' name '.mat'];        
    end
end
