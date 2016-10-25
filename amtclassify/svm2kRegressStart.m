%% this file was created for svm2k regress start
% classification with svm2k and activated by sigmode function
function score = svm2kRegressStart(fs2d,fs3d,rate,vf2d,vf3d,mode)

sc = fs2d(:,end);
% sort sc asscend
[sortedSc, index] = sort(sc);
[ncases,mfetures] = size(fs2d);
num = round(ncases * rate);
negIdx = index(1:num);
posIdx = index(end - num + 1 : end);

groundTruth = zeros(1, 2 * num);
preLabel = zeros(1, 2 * num);
preScore = zeros(1, 2 * num);

% constuct combined dataSet
% the last column is score
fea2d = zeros(2 * num, mfetures-1);
fea2d(1:num,:) = fs2d(negIdx,1:end-1);
fea2d(num+1:2*num,:) = fs2d(posIdx,1:end-1);

[ncases,mfetures] = size(fs3d);
% the last column is score
fea3d = zeros(2 * num, mfetures-1);
fea3d(1:num,:) = fs3d(negIdx,1:end-1);
fea3d(num+1:2*num,:) = fs3d(posIdx,1:end-1);

groundTruth(1:num) = -1;
groundTruth(num+1:2*num) = 1;
label = groundTruth;

% transpose mfeatures * ncases
fea2d = fea2d';
fea3d = fea3d';
label = label';


[tf2d, ps] = mapminmax(fea2d,0,1);
test2d = mapminmax('apply', vf2d', ps);
[tf3d, ps] = mapminmax(fea3d,0,1);
test3d = mapminmax('apply', vf3d', ps);

tf2d = tf2d';
tf3d = tf3d';
test2d = test2d';
test3d = test3d';

testLabel = zeros(size(test3d,1),1);

CA = 4.0;
CB = 4.0;
D = 0.1;
eps = 0.01;
% this parameter about kernel
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

if strcmp(mode,'2D')
    score = pre1;
elseif strcmp(mode,'3D')
    score = pre2;
elseif strcmp(mode,'2D3D')
    score = pre;
end


score = sigmod(score);
end
function val = sigmod(x)
    val = 1 ./ (1 + exp(-x));
end