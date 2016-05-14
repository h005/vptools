%%
% fs: fea + sc; ncases * mfea
% feaName: feature's name with its index in fs
% rate: top rate will be labeled as positve
%       last rate will be labeled as negative
% fname: file name, ie image's names

% output:
% groundTruth, preLabel were used to plotroc curve
% fN is the legend name on roc curve

function [groundTruth, preLabel, fN] ...
    = classifyEach(fs,feaName,rate,fname,method)
sc = fs(:,end);
% sort sc asscend
[sortedSc,index] = sort(sc);
[ncases, mfeatures] = size(fs);
num = round(ncases*rate);
negIdx = index(1:num);
posIdx = index(end - num + 1 : end);

groundTruth = zeros(length(feaName),2*num);
preLabel = zeros(length(feaName),2*num);

% construct new calssify data
for i=1:length(feaName)
    ind = feaName{i}.ind;
    % single fea score
    sfs = zeros(2*num,length(ind)+1);
    sfs(1:num,1:length(ind)) = fs(negIdx,ind);
    sfs(1:num,end) = 0;
    sfs(num+1:2*num,1:length(ind)) = fs(posIdx,ind);
    sfs(num+1:2*num,end) = 1;    

    % N fold
    nfold = 10;
    label = sfs(:,end);
    fea = sfs(:,1:end-1);
    
    groundTruth(i,:) = label';
    
    indices = crossvalind('Kfold',length(label),nfold);
    % transpose mfeatures * ncases
    fea = fea';
    label = label';

    predictLabel = zeros(1,length(label));

    for j=1:nfold

        test = (indices == j);
        train = ~test;

        trainFea = fea(:,train);
        testFea = fea(:,test);

        trainLabel = label(train);

        % data scale
        scaler = dataScaler(trainFea,'minMax');
        trainFea = datascaling(scaler,trainFea);
        testFea = datascaling(scaler,testFea);

        if strcmp(method,'bayes classify')
            % there is kfoldLoss function should be tried
            mdl = bysClassify(trainFea,trainLabel);
            [tmppl,postierior,cost] = predict(mdl,testFea');
            predictLabel(test) = postierior(:,2);        
        elseif strcmp(method,'svm classify')
            mdl = svmClassify(trainFea,trainLabel);
            [tmppl,score] = predict(mdl,testFea');
            predictLabel(test) = score(:,2);
        elseif strcmp(method,'ens classify')
            mdl = ensClassify(trainFea,trainLabel);
            [tmppl,score] = predict(mdl,testFea');
            predictLabel(test) = score(:,2);
        end
    end
    
    preLabel(i,:) = predictLabel;
    
end
% can not extract the name in cell array
% fname = feaName(:).name;

plotroc(groundTruth,preLabel);
% legend('test1','test2');
fN = cells(1,length(feaName));
for i=1:length(feaName)
    fN{i} = feaName{i}.name;
end



