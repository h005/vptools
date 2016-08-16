% ensemble regress
function regTreeEns = ensRegress(trainFea,trainScore)
% trainFea is mfeatures * ncases
trainFea = trainFea';
trainScore = trainScore';
regTreeTemp = templateTree('Surrogate','On');
regTreeEns = fitensemble(trainFea,trainScore,'Bag',50,regTreeTemp,'Type','regression');
