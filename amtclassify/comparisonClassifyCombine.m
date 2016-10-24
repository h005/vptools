%% this function was created to compare classify combine features
% fs: fea + sc; ncases * mfea
% rate : top rate will be labeled as positive
%        last rate will be labeled as negative
% fname: file name, ie image's names

% output:
% groundTruth, preScore were used to plotroc curve
% fN is the legend name on roc curve

function [groundTruth, preLabel, preScore, scLabel] ... 
    = comparisonClassifyCombine(fs,rate,fname,method,testModel)

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

sc = fs(:,end);
% sort sc asscend
[sortedSc,index] = sort(sc);
[ncases,mfeatures] = size(fs);
mfeatures = mfeatures - 1;
num = round(ncases * rate);
negIdx = index(1:num);
posIdx = index(end - num + 1 : end);

groundTruth = zeros(1, 2 * num);
preLabel = zeros(1, 2 * num);
preScore = zeros(1, 2 * num);

modelIndices = [testModelIndex(negIdx);testModelIndex(posIdx)];
testCasesCount = sum(modelIndices);
indices = [testModelIndex(negIdx);testModelIndex(posIdx)];

% contrust combined dataSet
cfs = zeros(2*num,mfeatures+1);
cfs(1:num,1:end-1) = fs(negIdx,1:end-1);
cfs(1:num,end) = 0;
cfs(num+1:2*num,1:end-1) = fs(posIdx,1:end-1);
cfs(num+1:2*num,end) = 1;

% N fold
nfold = 2;
label = cfs(:,end);
fea = cfs(:,1:end-1);

groundTruth(:) = label';

% indices = crossvalind('Kfold',length(label),nfold);

% transpose mfeatures * ncases
fea = fea';
label = label';

scLabel = [];

% for j=1:nfold
% we just need to test fold 1
j = 1;

test = (indices == j);
train = ~test;

trainFea = fea(:,train);
testFea = fea(:,test);

trainLabel = label(train);

% data scale
scaler =  dataScaler(trainFea,'minMax');
trainFea = datascaling(scaler,trainFea);
testFea = datascaling(scaler,testFea);

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
modelIndices = modelIndices == 1;
preScore = preScore(modelIndices);
preLabel = preLabel(modelIndices);
groundTruth = groundTruth(modelIndices);
% end



