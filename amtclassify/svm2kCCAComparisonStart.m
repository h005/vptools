%% this function was created for comparison of svm2kCCAStart
function [gt, pl, ps] = svm2kCCAComparisonStart(modelList, rate, mode)
addpath('./svm2k/');
[sc, scr, fea2d, fea3d] = dataLoad(modelList);

[fs, fname] = combine(fea2d,fea3d,scr);
[fs2d, fname2d] = combine(fea2d,scr);
[fs3d, fname3d] = combine(fea3d,scr);

% details was showed in feaNameLoad.m
[visualFea, geometricFea,validVisIndex, validGeoIndex] = feaNameLoad();
fs2d = fs2d(:,[validVisIndex,size(fs2d,2)]);
fs3d = fs3d(:,[validGeoIndex,size(fs3d,2)]);
fs = fs(:,[validVisIndex,visualFea{end}.index(end)+validGeoIndex, size(fs,2)]);

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