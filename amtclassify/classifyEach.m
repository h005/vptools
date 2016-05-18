%%
% fs: fea + sc; ncases * mfea
% feaName: feature's name with its index in fs
% rate: top rate will be labeled as positve
%       last rate will be labeled as negative
% fname: file name, ie image's names

% output:
% groundTruth, preLabel were used to plotroc curve
% fN is the legend name on roc curve

% k-fold classify with each given feature and plot the ROC and 
% Precision Recall curve
function [groundTruth, preLabel, fN, sclabel] ...
    = classifyEach(fs,feaName,rate,fname,method)
sc = fs(:,end);
% sort sc asscend
[sortedSc,index] = sort(sc);
[ncases, mfeatures] = size(fs);
num = round(ncases*rate);
negIdx = index(1:num);
posIdx = index(end - num + 1 : end);

sclabel = [];

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
    sclabel = mdl.ClassNames(end);
end

% if strcmp(method,'bayes classify')
%     titleLabel = [titleLabel 'Naive Bayes Classification'];
% elseif strcmp(method,'svm classify')
%     titleLabel = [titleLabel 'SVM Classification'];
% elseif strcmp(method,'ens classify')
%     titleLabel = [titleLabel 'Ensemble Learning Classification'];
% end

% can not extract the name in cell array
% fname = feaName(:).name;

% use prefcurve is better
% plotroc(groundTruth,preLabel);
% legend('test1','test2');
fN = cell(1,length(feaName));
for i=1:length(feaName)
    fN{i} = feaName{i}.name;
end
%{
X = cell(length(feaName),1);
Y = cell(length(feaName),1);

for i=1:length(feaName)
   
    [tmpx,tmpy,tmpt,tmpauc] = ...
        perfcurve(groundTruth(i,:),preLabel(i,:),mdl.ClassNames(end));
    X{i} = tmpx;
    Y{i} = tmpy;
    
end

%% plot roc curve
figure
plot(X{1},Y{1});
hold on 
for i=2:length(feaName)
    plot(X{i},Y{i});
end
legend(fN,'Location','best');
xlabel('False positive rate');
ylabel('True positive rate');
title(titleLabel);
hold off

%% plot Precision Recall curve
X = cell(length(feaName),1);
Y = cell(length(feaName),1);
% [prec, tpr, fpr, thresh] = prec_rec(score, target, 'plotROC',0,'plotPR',0);

for i=1:length(feaName)
    [prec, tpr, fpr, thresh] = ...
        prec_rec(preLabel(i,:), 1-groundTruth(i,:), 'plotROC',0,'plotPR',0);
    X{i} = [0; tpr];
    Y{i} = [1; prec];
end
figure
plot(X{1},Y{1},'Marker',plotMarker{1})
hold on
for i=2:length(feaName)
    plot(X{i},Y{i},'Marker',plotMarker{i});
end
legend(fN,'Location','best');
xlabel('recall');
ylabel('precision');
title(['Performance of ' prTitle ' on the photos']);
%}
