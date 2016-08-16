%% this function was created to get a regresser with given data
function [mdl,scaler] = getRegresser(fs,method)

score = fs(:,end);
fea = fs(:,1:end-1);

fea = fea';
score = score';

scaler = dataScaler(fea,'minMax');
trainFea = datascaling(scaler,fea);

if strcmp(method,'gaussian regress')
    mdl = gprRegress(trainFea,score);
elseif strcmp(method,'svm regress')
    mdl = svmRegress(trainFea,score);
elseif strcmp(method,'ens regress')
    mdl = ensRegress(trainFea,score);
end
