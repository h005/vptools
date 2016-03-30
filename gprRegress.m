%% Gaussian Process regression
function gprmdl = gprRegress(trainFea,trainScore)
trainFea = trainFea';
trainScore = trainScore';
gprmdl = fitrgp(trainFea,trainScore);