%% this script was created to apply svm2k and CCA to classify
function [gt, pl, ps] = svm2kCCAStart(modelList, rate, mode)
addpath('./svm2k/');
[sc, scr, fea2d, fea3d] = dataLoad(modelList);
[fs, fname] = combine(fea2d,fea3d,scr);
[fs2d, fname2d] = combine(fea2d,scr);
[fs3d, fname3d] = combine(fea3d,scr);

[gt, ps] = svm2kClassifyValidation(fs2d,fs3d,rate,mode);
pl = ps > 0;
pl = 2 * pl - 1;
pl = pl';