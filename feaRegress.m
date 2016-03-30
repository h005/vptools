clear;
clc;
feafile = '/home/h005/Documents/vpDataSet/notredame/vpFea/notredame.fs';
fea2Dfile = '/home/h005/Documents/vpDataSet/notredame/vpFea/notredame.2dfs';
fea3Dfile = '/home/h005/Documents/vpDataSet/notredame/vpFea/notredame.3dfs';
feaNameFile = '/home/h005/Documents/vpDataSet/notredame/vpFea/notredame.fname';

% feaDistribution;


figure(1)
% titleText = 'gaussian regress';

titleText = {
    'gaussian regress',...
    'svm regress', ...
    'ens regress'};

method = 3;

[score,predictScore] = feaAnalysis(feafile,titleText{method});
showInfo(titleText{method},score,predictScore,'2d+3d',2,2,1);
[score,predictScore] = feaAnalysis(fea2Dfile,titleText{method});
showInfo(titleText{method},score,predictScore,'2d',2,2,2);
[score,predictScore] = feaAnalysis(fea3Dfile,titleText{method});
showInfo(titleText{method},score,predictScore,'3d',2,2,3);


