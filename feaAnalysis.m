%% fea analysis
function [score,predictScore] = feaAnalysis(feafile,method)
% feafile = '/home/h005/Documents/vpDataSet/notredame/vpFea/notredame.fs';
feaData = load(feafile);

% ncases * m
% last two columns are score
fea  = feaData(:,1:end-2);

score = feaData(:,end-1 : end);
score(find(score(:,2)==0),2) = 1;
score = score(:,1) ./ score(:,2);

% transpose mfeatures * ncases
fea = fea';
score = score';
% test for gaussian process regress
% score = ones(1,length(score));

%% N fold
nfold = 10;
index = randperm(size(score,2));

predictScore = zeros(1,size(score,2));

%% regress
for i=1:nfold
    ind = getPart(index,floor(size(score,2)/nfold),i);
    trainInd = setxor(index,ind,'stable');
    trainDt = fea(:,trainInd);
    trainScore = score(trainInd);
    
    predictDt = fea(:,ind);
    
    % data scale
    scaler = dataScaler(trainDt,'minMax');
    trainDt = datascaling(scaler,trainDt);
    predictDt = datascaling(scaler,predictDt);
    % attention trainDt is mfeatures * ncases
    % score is 1 * ncases
    if strcmp(method,'gaussian regress')
        mdl = gprRegress(trainDt,trainScore);
    elseif strcmp(method,'svm regress')
        mdl = svmRegress(trainDt,trainScore);
    elseif strcmp(method,'ens regress')
        mdl = ensRegress(trainDt,trainScore);
    end
    tmpps = predict(mdl,predictDt');
    predictScore(ind) = tmpps;
end