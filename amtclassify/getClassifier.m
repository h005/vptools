%% this function was created to generate a classifier

function [mdl,scaler] = getClassifier(fs,rate,method)

sc = fs(:,end);
[sortedSc,index] = sort(sc);
[ncases,mfeatures] = size(fs);
mfeatures = mfeatures - 1;
num = round(ncases * rate);
negIdx = index(1:num);
posIdx = index(end - num + 1 : end);

% contrust combined dataSet
cfs = zeros(2*num,mfeatures+1);
cfs(1:num,1:end-1) = fs(negIdx,1:end-1);
cfs(1:num,end) = 0;
cfs(num+1:2*num,1:end-1) = fs(posIdx,1:end-1);
cfs(num+1:2*num,end) = 1;

fea = cfs(:,1:end-1);
fea = fea';
scaler = dataScaler(fea,'minMax');
trainFea = datascaling(scaler,fea);
trainLabel = cfs(:,end);
if strcmp(method,'bayes classify')
    mdl = bysClassify(trainFea, trainLabel);
elseif strcmp(method,'svm classify')
    mdl = svmClassify(trainFea,trainLabel);
elseif strcmp(method,'ens classify')
    mdl = ensClassify(trainFea,trainLabel);
end
