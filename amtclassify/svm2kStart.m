%% this script was created to apply svm2k to classify
function [gt,pl,ps] = svm2kStart(modelList,rate,mode)
addpath('./svm2k/');
[sc,scr,fea2d,fea3d] = dataLoad(modelList);
[fs,fname] = combine(fea2d,fea3d,scr);
[fs2d,fname2d] = combine(fea2d,scr);
[fs3d,fname3d] = combine(fea3d,scr);

% % this was added for KCCA preprocess
% kerneltype = 'gauss';   % kernel type
% kernelpar = 1;  % kernel parameter
% reg = 1E-5; % regularization
% Mmax = 50;  % max. M (number of components in incomplete Cholesky decomp.)
% [f2d,f3d,coor] = km_kcca(fs2d(:,1:end-1),fs3d(:,1:end-1),kerneltype,kernelpar,reg,min([size(fs2d,2),size(fs3d,2)])-1,'ICD',Mmax);
% f2d = [f2d,fs2d(:,end)];
% f3d = [f3d,fs3d(:,end)];
% [gt,ps] = svm2kClassify(f2d,f3d,rate);

% % this was added for CCA preprocess
% [A,B,r,U,V] = canoncorr(fs2d(:,1:end-1),fs3d(:,1:end-1));
% ind = r > 0;
% fs2d = [U(:,ind),fs2d(:,end)];
% fs3d = [V(:,ind),fs3d(:,end)];




[gt,ps] = svm2kClassify(fs2d,fs3d,rate,mode);
pl = ps>0;
pl = 2 * pl - 1;
pl = pl';

% for i=1:length(picName)
%     disp([picName{i} ' ' num2str(pl(i)) ' ' num2str(gt(i))])
% end