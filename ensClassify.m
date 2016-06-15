%% essemble classify
function mdl = ensClassify(trainFea,trainLabel)
% trainFea is mfeatures * ncases
trainFea = trainFea';
trainLabel = trainLabel';
% details see doc fitensemble
mdl = fitensemble(trainFea,trainLabel,'AdaBoostM1',80,'Tree');