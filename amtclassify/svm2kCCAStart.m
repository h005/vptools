%% this script was created to apply svm2k and CCA to classify
function [gt, pl, ps] = svm2kCCAStart(modelList, rate, mode)
addpath('./svm2k/');
[sc, scr, fea2d, fea3d] = dataLoad(modelList);
[fs, fname] = combine(fea2d,fea3d,scr);
[fs2d, fname2d] = combine(fea2d,scr);
[fs3d, fname3d] = combine(fea3d,scr);

%% these code was created for selecting good images
% sc = fs(:,end);
% % sort sc asscend
% [sortedSc,index] = sort(sc);
% ncases = size(fs,1);
% num = round(ncases * rate);
% negIdx = index(1:num);
% posIdx = index(end - num + 1 : end);
% 
% disp('neg data')
% for i=1:num
%     disp([fname{negIdx(i)} ' ' num2str(sc(negIdx(i)))])
% end
% disp('pos data')
% for i=1:num
%     disp([fname{posIdx(i)} ' ' num2str(sc(posIdx(i)))])
% end
%%

[gt, ps] = svm2kClassifyValidation(fs2d,fs3d,rate,mode);
pl = ps > 0;
pl = 2 * pl - 1;
pl = pl';