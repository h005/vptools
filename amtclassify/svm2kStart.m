%% this script was created to apply svm2k to classify
function [gt,pl,ps] = svm2kStart(modelList,rate)
addpath('./svm2k/');
[sc,scr,fea2d,fea3d] = dataLoad(modelList);
[fs,fname] = combine(fea2d,fea3d,scr);
[fs2d,fname2d] = combine(fea2d,scr);
[fs3d,fname3d] = combine(fea3d,scr);

[gt,ps] = svm2kClassify(fs2d,fs3d,rate);
pl = ps>0;
pl = 2 * pl - 1;
pl = pl';