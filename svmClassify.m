%% svm classify
function mdl = svmClassify(trainFea,trainLabel)
% trainFea is mfeatures * ncases
trainFea = trainFea';
trainLabel = trainLabel';
mdl = fitcsvm(trainFea,trainLabel);