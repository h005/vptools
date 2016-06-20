%% this function was created to classify combine features with GMM
% fs: fea + sc; ncases * mfea
% rate : top rate will be labeled as poitive
%        last rate will be labeled as negative
% fname: file name, ie, image's names

% output:
% groundTruth, preScore were used to plot roc curve
% fN is the legend name on roc curve

function [groundTruth, preLabel, preScore, scLabel] ...
    = gmmClassifyCombine(fs,rate,fname,method)
numGMModels = 2;
sc = fs(:,end);
% sort sc asscend
[scoredSc,index] = sort(sc);
[ncases, mfeatures] = size(fs);
mfeatures = mfeatures - 1;
num = round(ncases * rate);
negIdx = index(1:num);
posIdx = index(end - num + 1 : end);

groundTruth = zeros(1,2*num);
preLabel = zeros(1, 2 * num);
preScore = zeros(1, 2 * num);
preScore2 = zeros(1, 2 * num);

% construct combined dataSet
cfs = zeros(2 * num, mfeatures + 1);
cfs(1:num,1:end-1) = fs(negIdx,1:end-1);
cfs(1:num,end) = 0;
cfs(num+1:2*num,1:end-1) = fs(posIdx,1:end-1);
cfs(num+1:2*num,end) = 1;

% N fold
nfold = 10;
label = cfs(:,end);
fea = cfs(:,1:end-1);

groundTruth(:) = label';
% for debug
% indices = crossvalind('Kfold',length(label),nfold);
% save('indices.mat','indices');
load('indices.mat');
% transpose to mfeatures * ncases;
fea = fea';
label = label';

scLabel = [];

for j = 1:nfold
    
    disp(['fold ' num2str(j) ' ' method])
%     if j==4 && strcmp(method,'svm classify')
%         disp('debug');
%     end            
    test = (indices == j);
    train = ~test;
    
    trainFea = fea(:,train);
    testFea = fea(:,test);
    
    trainLabel = label(train);
    
    % data scale
    scaler = dataScaler(trainFea,'minMax');
    trainFea = datascaling(scaler,trainFea);
    testFea = datascaling(scaler,testFea);
    
    % get GMM 
    GMM = fitgmdist(trainFea',numGMModels,...
        'CovarianceType','diagonal','SharedCovariance',true,...
        'RegularizationValue',0.001);
    p = posterior(GMM,testFea'); % posterior
    cid = cluster(GMM,trainFea'); % trainFea cluster
    % train for each clsuter
    if strcmp(method,'bayes classify')
        for gid = 1:max(cid)
            idx = cid == gid;
            if sum(trainLabel(idx)) < 0.2 * numel(trainLabel(idx))
                continue;
            end
            mdl = bysClassify(trainFea(:,idx),trainLabel(idx));
            [tmppl,positerior,cost] = predict(mdl,testFea');
            % 两个后验概率加起来为1
            preScore(test) = preScore(test) + positerior(:,2)' .* p(:,gid)';
            preScore2(test) = preScore2(test) + positerior(:,1)' .* p(:,gid)';
        end             
    elseif strcmp(method,'svm classify')
        for gid = 1:max(cid)
            idx = cid == gid;
            if sum(trainLabel(idx)) < 0.2 * numel(trainLabel(idx))
                continue;
            end
            mdl = svmClassify(trainFea(:,idx),trainLabel(idx));
            [tmppl,positerior] = predict(mdl,testFea');
            
            preScore(test) = preScore(test) + positerior(:,2)' .* p(:,gid)';
            preScore2(test) = preScore2(test) + positerior(:,1)' .* p(:,gid)';
        end    
    elseif strcmp(method,'ens classify')
        for gid = 1:max(cid)
            idx = cid == gid;
            if sum(trainLabel(idx)) < 0.2 * numel(trainLabel(idx))
                continue;
            end
            mdl = ensClassify(trainFea(:,idx),trainLabel(idx));
            [tmppl,positerior] = predict(mdl,testFea');
            % 两个后验概率加起来为1
            preScore(test) = preScore(test) + positerior(:,2)' .* p(:,gid)';
            preScore2(test) = preScore2(test) + positerior(:,1)' .* p(:,gid)';
        end    
    end    
    
%     diffPositerior = positerior(:,1) - positerior(:,2);
%     diffInd = find(diffPositerior > 0);
%     tagLabel(1) = tmppl(diffInd(1));
%     diffInd = find(diffPositerior <= 0);
%     tagLabel(2) = tmppl(diffInd(1));
    preLabelInd = preScore > preScore2;
    preLabel(preLabelInd) = 1;
    preLabelInd = preScore <= preScore2;
    preLabel(preLabelInd) = 0;
    
end

