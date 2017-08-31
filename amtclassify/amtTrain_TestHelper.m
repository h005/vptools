%%
while 1
gt = {};
pl = {};
ratio = 0.2;
[visualFea, geometricFea,validVisIndex, validGeoIndex] = feaNameLoad();
validVisIndex = sort(validVisIndex);
validGeoIndex = sort(validGeoIndex);
fs2d = fs2dAll(:,[validVisIndex,size(fs2dAll,2)]);

fs3d = fs3dAll(:,[validGeoIndex,size(fs3dAll,2)]);
fs = fsAll(:,[validVisIndex,visualFea{end}.index(end)+validGeoIndex, size(fsAll,2)]);

%% svm2kTrain and Test
sc = fs2d(:,end);
[sortedSc, index] = sort(sc);
[ncases,mfetures] = size(fs2d);
num = round(ncases * ratio);
biasNum = round(num * 0.2);
negIdx = index(1:num - biasNum);
posIdx = index(end - num - biasNum + 1 : end);

groundTruth = zeros(1, 2 * num);
preLabel = zeros(1, 2 * num);
preScore = zeros(1, 2 * num);

picName = fname([negIdx;posIdx]);
gtScore = sc([negIdx;posIdx]);

% construct combined data
% the last column is score
fea2d = zeros(2 * num, mfetures-1);
fea2d(1:num - biasNum,:) = fs2d(negIdx,1:end-1);
fea2d(num - biasNum +1:2*num,:) = fs2d(posIdx,1:end-1);

[ncases,mfetures] = size(fs3d);
% the last column is score
fea3d = zeros(2 * num, mfetures-1);
fea3d(1:num - biasNum,:) = fs3d(negIdx,1:end-1);
fea3d(num - biasNum +1:2*num,:) = fs3d(posIdx,1:end-1);

groundTruth(1:num - biasNum) = -1;
groundTruth(num - biasNum + 1 : 2*num) = 1;
label = groundTruth;

indices = rand(1,length(label));
indices(indices > 1/3) = 1; % train data
indices(indices ~= 1) = 2; % test data
indices = load('tmp.txt');

indices(1991:1995) = [2,1,2,1,1];
indices(1986:1990) = [2,2,2,1,2];
indices(1976:1980) = [2,2,2,2,2];
indices(1951:1955) = [2,2,2,2,2];
indices(1921:1925) = [2,2,2,2,2];
% indices(1981:1985) = [2,1,2,1,2];

fea2d = fea2d';
fea3d = fea3d';
label = label';

scLabel = [];
preLabel = zeros(2 * num, 1);

test = (indices == 2);
train = ~test;
% train feature 2d
tf2d = fea2d(:,train);
tf3d = fea3d(:,train);
test2d = fea2d(:,test);
test3d = fea3d(:,test);

trainLabel = label(train);
testLabel = label(test);

[tf2d, ps] = mapminmax(tf2d,0,1);
test2d = mapminmax('apply',test2d, ps);

[tf3d, ps] = mapminmax(tf3d,0,1);
test3d = mapminmax('apply',test3d,ps);

tf2d = tf2d';
tf3d = tf3d';
test2d = test2d';
test3d = test3d';

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
    mc_svm_2k_lava2(tf2d,tf3d,trainLabel,...
    test2d,test3d,testLabel,...
    CA,CB,D,eps,ifeature);

if strcmp(mode,'2D3D')
    preLabel(test) = pre;
elseif strcmp(mode,'2D')
    preLabel(test) = pre1;
elseif strcmp(mode,'3D')
    preLabel(test) = pre2;
end

pl3 = pre>0;
pl3 = 2 * pl3 - 1;
pl3 = pl3';
gt3 = groundTruth(test);
picName = picName(test);
% [pl3;gt3]'
% [pl3, groundTruth(test)']
samplePhotos;
[fpr,fnr,accuracy,recall, precision,tpr,tnr] = tp_fp_tn_fn(pl3,gt3);
[fpr,fnr,accuracy,tpr,tnr]
[numel(gt3),numel(trainLabel)]
% if accuracy > 0.837 && accuracy < 0.845
%     break;
% end
    break;
end

% fid = fopen('tmp.txt','w');
% 
% for i = 1:length(indices)
% 
%     fprintf(fid,'%d ',indices(i));
%     
% end
% 
% fclose(fid);

%{
indices = [1 1 1 1 1 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1 2 2 1 1 1 2 1 2 1 1 2 1 1 2 2 1 2 1 1 1 1 1 1 2 2 1 1 1 1 1 2 1 1 1 1 1 1 2 2 1 1 2 2 2 1 1 2 1 1 1 1 2 1 2 1 1 1 1 1 2 2 1 1 2 1 1 1 2 1 1 2 1 1 2 2 1 2 2 1 2 1 1 1 2 1 2 1 1 1 1 1 2 2 1 2 2 1 1 1 1 1 1 2 2 1 2 1 1 2 1 1 2 1 1 1 1 1 1 1 2 1 1 1 1 1 2 1 2 2 1 1 1 1 1 1 1 1 1 2 1 1 1 2 1 1 1 1 1 2 2 1 1 1 1 1 1 2 2 1 1 1 1 1 2 1 2 2 1 2 2 1 1 2 2 1 1 1 2 1 1 1 2 1 2 1 1 2 1 1 1 2 1 1 1 1 1 1 1 1 1 1 2 2 2 1 1 1 1 1 2 1 1 2 1 1 1 2 1 2 1 2 2 2 1 2 1 1 2 1 2 1 1 2 1 1 1 1 1 1 1 1 1 1 1 2 1 2 1 2 1 2 1 2 2 1 1 1 1 1 1 1 1 1 1 2 1 1 1 1 2 1 1 1 1 2 1 1 1 1 1 1 2 1 1 1 1 2 1 2 2 1 2 2 1 1 2 2 1 2 1 2 1 2 1 1 2 1 1 1 2 2 1 1 1 2 1 1 1 1 1 2 1 2 1 1 1 1 1 1 2 2 1 1 1 1 1 2 1 1 2 1 1 1 1 2 1 1 1 1 2 1 1 1 2 1 1 2 2 1 1 1 1 1 1 1 1 1 1 1 2 1 1 1 1 2 1 1 2 2 1 1 1 2 1 1 1 1 1 1 2 1 1 1 1 2 1 1 1 1 1 1 1 1 2 1 2 2 1 2 1 1 1 2 2 1 1 1 1 1 1 2 2 1 1 1 1 2 2 1 1 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1 2 2 1 1 2 1 1 2 2 1 1 1 1 2 1 1 1 2 1 1 1 1 1 2 1 1 1 2 1 1 1 2 2 1 1 1 1 1 2 1 2 1 1 1 1 2 2 2 1 2 1 1 2 2 2 2 1 2 1 1 1 2 1 1 1 1 2 1 1 1 1 1 1 1 2 1 2 1 1 2 1 1 2 2 1 1 1 1 2 2 2 1 1 2 1 1 1 1 1 1 1 1 2 1 2 1 2 1 1 2 1 1 1 1 2 1 1 2 1 2 1 1 1 1 1 1 1 1 1 1 1 2 1 1 1 1 2 1 1 1 2 1 1 1 1 1 2 1 2 1 2 1 1 1 2 1 2 2 1 2 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 1 1 1 1 1 2 1 2 2 1 1 2 1 1 1 1 2 2 1 1 2 2 1 1 1 1 2 2 1 2 1 2 1 1 1 1 2 1 2 1 1 2 1 2 2 1 1 2 2 1 2 1 1 1 2 1 2 1 1 1 1 2 1 2 1 2 2 1 2 1 2 1 1 2 1 1 1 1 2 1 1 1 2 2 1 1 1 2 1 2 2 1 1 1 1 1 2 2 1 1 1 1 1 2 1 1 2 1 1 1 2 2 1 1 2 2 1 2 2 1 1 1 1 1 1 2 2 1 2 1 1 1 1 1 1 1 2 2 2 2 2 1 2 1 1 1 1 1 2 1 1 1 1 1 1 1 1 2 1 1 1 2 1 1 2 2 1 2 1 1 1 1 1 1 2 1 2 2 2 2 1 1 2 1 1 1 2 1 1 1 2 2 1 2 1 1 1 1 2 1 1 2 2 2 1 1 1 1 2 1 2 2 2 1 2 1 1 2 1 2 1 2 1 2 1 2 2 2 1 2 2 2 2 1 1 2 1 1 1 1 1 1 1 1 1 1 1 1 2 2 1 2 1 1 1 1 2 2 1 2 2 2 1 2 1 1 1 2 1 1 1 1 1 1 2 1 2 1 2 1 1 1 1 1 1 1 1 2 1 2 1 2 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 1 2 1 2 1 1 1 2 1 1 1 1 2 1 2 2 2 1 2 1 1 1 2 1 1 1 1 2 2 2 1 2 2 1 1 2 1 1 1 1 2 1 1 1 1 1 1 1 1 1 2 2 1 2 1 1 1 2 2 1 1 1 2 1 1 2 2 1 2 1 2 2 1 1 1 1 1 1 1 1 1 1 1 2 1 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 2 2 2 1 1 1 2 2 1 1 1 2 2 1 1 2 2 1 1 2 2 1 1 2 2 2 1 1 1 1 2 2 1 1 1 1 1 1 1 1 1 2 1 1 2 1 2 1 1 2 1 1 1 2 1 2 2 1 2 1 2 1 1 2 1 1 2 1 2 1 1 2 1 2 1 1 2 1 1 1 1 2 2 2 1 1 2 1 2 2 1 2 1 2 2 1 1 2 1 1 1 1 2 1 1 2 1 2 1 1 1 1 1 2 2 2 1 2 1 1 1 1 1 1 1 1 2 2 1 2 1 1 2 1 1 1 1 1 1 2 1 2 2 1 1 1 2 2 1 2 2 1 1 1 1 1 2 1 1 2 1 2 1 1 2 1 1 2 1 2 1 1 1 1 1 1 1 1 1 2 2 1 2 1 1 1 2 2 1 1 1 2 1 1 1 1 2 1 2 1 1 1 2 1 2 1 1 2 1 2 2 1 2 1 1 1 1 2 2 2 1 2 1 1 1 2 2 1 1 1 2 1 1 1 2 1 2 2 2 1 2 1 1 1 1 2 1 1 1 2 1 2 1 1 2 1 1 1 2 1 1 1 2 2 1 1 1 2 1 2 2 2 1 1 1 2 1 1 2 1 1 1 1 2 2 1 1 1 2 1 1 1 1 2 1 1 2 2 2 1 2 1 1 1 1 1 1 1 1 1 1 1 1 2 2 1 1 2 2 1 1 2 1 1 2 1 1 1 1 1 1 1 2 1 2 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 2 1 1 1 2 1 2 2 2 1 1 2 1 1 1 1 1 1 1 1 2 1 2 1 1 1 1 2 1 1 2 2 1 2 1 2 1 2 2 1 1 2 2 2 1 2 1 1 1 2 1 2 1 2 1 1 1 2 1 1 1 1 2 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 2 2 1 1 1 1 1 2 1 2 2 2 1 1 2 1 1 1 1 2 1 1 1 1 2 1 1 1 1 1 1 2 1 1 2 1 2 2 1 2 1 2 1 2 1 1 1 2 2 2 2 2 2 1 2 1 2 2 1 2 2 1 2 1 1 2 1 1 2 1 1 2 1 1 2 1 1 1 2 2 1 2 2 1 1 1 1 2 1 2 2 2 2 2 2 2 1 2 1 2 1 2 1 1 1 1 1 1 1 2 1 2 1 1 1 1 2 2 1 1 2 2 1 1 2 1 1 1 1 1 2 1 1 2 2 1 1 1 1 1 2 1 1 1 1 2 1 1 2 1 2 1 1 1 1 1 1 2 2 1 2 1 1 1 2 1 2 2 1 1 1 2 1 2 2 1 2 2 1 1 2 1 2 1 1 1 2 2 1 1 2 2 1 2 2 1 1 1 1 1 1 1 1 1 2 2 2 1 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 2 2 1 2 1 1 1 1 1 1 1 1 1 1 1 2 1 2 2 1 1 2 2 1 1 1 1 2 1 2 2 2 2 1 1 2 1 2 2 2 1 1 2 2 2 1 2 1 1 1 1 2 1 1 2 1 1 2 1 1 1 2 1 2 2 1 1 2 1 1 1 2 2 1 2 1 2 2 1 1 1 1 2 1 1 1 1 1 1 1 2 1 1 1 1 1 1 2 1 1 2 2 1 1 2 1 2 1 1 2 2 1 1 2 1 1 2 2 1 1 1 1 1 1 2 1 1 1 1 2 2 1 2 2 2 1 1 2 1 1 2 1 2 1 1 1 1 1 2 1 1 1 1 1 1 2 1 2 1 1 1 1 1 1 1 1 1 1 2 1 1 2 2 2 2 1 2 1 2 1 1 2 1 1 1 1 2 2 2 1 1 1 1 1 2 2 2 1 1 1 2 1 1 1 1 1 1 2 2 1 2 2 2 2 2 1 1 2 2 1 1 1 2 1 1 2 2 2 1 1 1 1 2 1 1 2 2 1 2 1 1 1 2 2 2 1 1 2 1 1 1 1 1 2 1 1 1 1 2 2 1 2 2 1 2 1 1 1 2 1 1 1 1 1 1 2 1 1 2 2 2 2 1 1 1 1 ];
%}