%% amt regress
function [score,predictScore] = amtRegress(fs,method)

ncases = size(fs,1);
% fs ncases * m, and the last column is score
score = fs(:,end);
fea = fs(:,1:end-1);

% N fold
nfold = 10;
indices = crossvalind('Kfold',length(score),nfold);

% transpose mfeatures * ncases
fea = fea';
score = score';

predictScore = zeros(1,ncases);

for i=1:nfold
    test = (indices == i);
    train = ~test;

    trainFea = fea(:,train);
    testFea = fea(:,test);

    trainScore = score(train);

    % data scale
    scaler = dataScaler(trainFea,'minMax');
    trainFea = datascaling(scaler,trainFea);
    testFea = datascaling(scaler,testFea);
    % attention trainFea is mfeatures * ncases
    % score is 1 * ncases
    if strcmp(method,'gaussian regress')
        mdl = gprRegress(trainFea,trainScore);
        tmpps = predict(mdl,testFea');
        predictScore(test) = tmpps;
    elseif strcmp(method,'svm regress')
        mdl = svmRegress(trainFea,trainScore);
        tmpps = predict(mdl,testFea');
        predictScore(test) = tmpps;
    elseif strcmp(method,'ens regress')
        mdl = ensRegress(trainFea,trainScore);
        tmpps = predict(mdl,testFea');
        predictScore(test) = tmpps;
    end
end
