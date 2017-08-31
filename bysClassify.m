%% bayes classify
function mdl = bysClassify(trainFea,trainLabel)
% trainFea is mfeatures * ncases
trainFea = trainFea';
trainLabel = trainLabel';
mdl = fitcnb(trainFea,trainLabel);
% mdl = fitcnb(trainFea,trainLabel,'Distribution','kernel','Kernel','normal');
