%% this function was created for svm2k regress
% fs2d, fs3d, test2d, test3d are all ncases * mfeatures
function [pre] = svm2kRegress(fs2d,fs3d,rate,test2d,test3d)

sc = fs2d(:,end);
% sort sc asscend
[sortedSc, index] = sort(sc);
[ncases, mfeatures] = size(fs2d);
num = round(ncases * rate);
negIdx = index(1:num);
posIdx = index(end - num + 1 : end);

% construct combined dataSet
% the last column of fs2d or fs3d is score
fea2d = zeros(2 * num, mfeatures  - 1);
fea2d(1:num,:) = fs2d(negIdx,1:end-1);
fea2d(num+1:2*num,:) = fs2d(posIdx,1:end-1);

[ncases, mfeatures] = size(fs3d);
% the last column of fs3d is score
fea3d = zeros(2 * num, mfeatures - 1);
fea3d(1:num,:) = fs3d(negIdx,1:end-1);
fea3d(num+1:2*num,:) = fs3d(posIdx,1:end-1);

groundTruth(1:num) = -1;
groundTruth(num+1:2*num) = 1;
label = groundTruth';

% coded features by CCA
% compute CCA
tf2d = fea2d;
tf3d = fea3d;
[A,B,r,U,V] = canoncorr(tf2d,tf3d);
% map to another space
N = size(test2d, 1);
test2d = (test2d - repmat(mean(test2d),N,1)) * A;
test3d = (test3d - repmat(mean(test3d),N,1)) * B;

% define a threshold here to control the cca features.
% threshold is the features' coefficient of correlation
threshold = 0;
ind = r > threshold;
tf2d = U(:,ind);
tf3d = V(:,ind);

% data scale
[tf2d,ps] = mapminmax(tf2d',0,1);
tf2d = tf2d';
test2d = mapminmax('apply',test2d',ps);
test2d = test2d';

[tf3d,ps] = mapminmax(tf3d',0,1);
tf3d = tf3d';
test3d = mapminmax('apply',test3d',ps);
test3d = test3d';
testLabel = zeros(size(test3d,1),1);

% svm 2k parameter
CA = 3.5;
CB = 3.5;
D = 0.1;
eps = 0.01;
% this parameter is about kernel
ifeature = 1;

[acorr,acorr1,acorr2,...
    pre,pre1,pre2,...
    hit,hit1,hit2,...
    tpre,tpre1,tpre2,...
    ga,gb,bam,bbm,...
    alpha_A,alpha_B]= ...
    mc_svm_2k_lava2(tf2d,tf3d,label,...
    test2d,test3d,testLabel,...
    CA,CB,D,eps,ifeature);

pre = sigmod(pre);
end
function val = sigmod(x)
    val = 1 ./ (1 + exp(-x));
end
