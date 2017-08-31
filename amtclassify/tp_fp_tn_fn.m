%% this script was careted to compute the tp fp tn fn

function [fpr,fnr,accuracy,recall, precision,tpr,tnr] = tp_fp_tn_fn(pl3,gt3)

predict = pl3;
groundTruth = gt3;

tp = sum(groundTruth(predict == 1) == 1);
tn = sum(groundTruth(predict == -1) == -1);
fp = sum(groundTruth(predict == 1) == -1);
fn = sum(groundTruth(predict == -1) == 1);

% tp = sum(groundTruth(predict == -1) == -1);
% tn = sum(groundTruth(predict == 1) == 1);
% fp = sum(groundTruth(predict == -1) == 1);
% fn = sum(groundTruth(predict == 1) == -1);

fpr = fp / (fp + tn);
fnr = fn / (tp + fn);
accuracy = (tp + tn) / (tp + tn + fp + fn);

precision = tp / (tp + fp);
recall = tp / (tp + fn);

tpr = tp / (tp + fn);
tnr = tn / (fp + tn);