%% deep learning for features

% load data
modelList = {
    'bigben',...
    'kxm',...
    'notredame',...
    'freeGodness',...
    'tajMahal',...
    'cctv3'...
    };

rate =  0.08;

[sc,scr,fea2d,fea3d] = dataLoad(modelList);

[fs2d,fname] = combine(fea2d,scr);

[fs3d,fname] = combine(fea3d,scr);

[fs,fname] = combine(fea2d,fea3d,scr);

sc = fs(:,end);
% sort sc asscend
[srotedSc,index] = sort(sc);
[ncases, mfeatures] = size(fs);
mfeatures = mfeatures - 1;
num = round(ncases * rate);
negIdx = index(1:num);
posIdx = index(end - num + 1 : end);

groundTruth = zeros(2 * num, 2);
preLabel = zeros(1, 2 * num);
preScore = zeros(1, 2 * num);

% construct combined features
cfs = zeros(2 * num, mfeatures);
cfs(1:num, : ) = fs(negIdx, 1:end -1);
cfs(num+1 : 2*num, : ) = fs(posIdx,1:end-1);

groundTruth(1:num,1) = 1;
groundTruth(num+1:end,2) = 1;

% ten fold
nfold = 10;
fea = cfs;

indices = crossvalind('Kfold',2 * num, nfold);

% here we define the fold which index is 1 as the test dataSet
testIdx = (indices == 1);
trainIdx = ~testIdx;

% so our net input is
% mapminmax 是按照行来归一化的，所以传入的参数要转置一下
xTrain = fea(trainIdx,:);
[xTrain, ps] = mapminmax(xTrain', 0, 1);
xTest = fea(testIdx,:);
xTest = xTest';
xTest = mapminmax('apply',xTest,ps);
% 神经网络中输入的参数是按照ncases × mfeatures的，所以还需转置
xTrain = xTrain;
xTest = xTest;

rng('default');
hiddenSize1 = 100;

autoenc1 = trainAutoencoder(xTrain,hiddenSize1,...
    'MaxEpochs',400, ...
    'L2WeightRegularization',0.004, ...
    'SparsityRegularization',4, ...
    'SparsityProportion',0.15, ...
    'ScaleData', false);

% plotWeigths(autoenc1);

feat1 = encode(autoenc1,xTrain);

hiddenSize2 = 50;
autoenc2 = trainAutoencoder(feat1,hiddenSize2,...
    'MaxEpochs',400, ...
    'L2WeightRegularization',0.002, ...
    'SparsityRegularization',4, ...
    'SparsityProportion',0.1, ...
    'ScaleData', false);

feat2 = encode(autoenc2,feat1);

hiddenSize3 = 30;
autoenc3 = trainAutoencoder(feat2,hiddenSize3,...
    'MaxEpochs',400, ...
    'L2WeightRegularization',0.002, ...
    'SparsityRegularization',4, ...
    'SparsityProportion',0.1, ...
    'ScaleData', false);

feat3 = encode(autoenc3,feat2);

hiddenSize4 = 20;
autoenc4 = trainAutoencoder(feat3,hiddenSize4,...
    'MaxEpochs',400, ...
    'L2WeightRegularization',0.002, ...
    'SparsityRegularization',4, ...
    'SparsityProportion',0.1, ...
    'ScaleData', false);

feat4 = encode(autoenc4,feat3);


softnet = trainSoftmaxLayer(feat2,groundTruth(trainIdx,:)','MaxEpochs',400);

% deepnet = stack(autoenc1,autoenc2,autoenc3,autoenc4,softnet);

deepnet = stack(autoenc1,autoenc2,softnet);

deepnet = train(deepnet,xTrain,groundTruth(trainIdx,:)');

y = deepnet(xTest);
plotconfusion(groundTruth(testIdx,:)',y);




