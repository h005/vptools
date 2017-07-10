%% show color map

[psc,psind] = sort(ps,'descend');

len = numel(ps);
% villa for others
% sizet = [64,16];
% villa7_1
sizet = [64,16];
% njuActivity test
% sizet = sizet./2;
% for VideoCut3Sample
% sizet = [64,15];
psImg = reshape(ps,sizet(1),sizet(2));

if strcmp(virtualModel{2},'circle')
    psImg = [psImg;psImg(1,:)];
    sizet(1) = sizet(1) + 1;
else

end

% this was created for debug
image(psImg,'CDataMapping','scaled')
img = imresize(psImg,sizet * 8);

% show in 3D
figure(1)
surf(img);
colormap jet
axis on
xlabel('x label');
ylabel('y label');

% show in 2D
% hold on
fig = figure(2);
image(img,'CDataMapping','scaled')
colormap jet
% colorbar
axis off
savePath = ['../../' virtualModel{1} '/colormap90_360gaussianProcess' virtualModel{1} '.jpg'];
disp(savePath)
% save and read to get color information
saveas(fig,savePath);
R = imread(savePath);
Rgray = rgb2gray(R);
Rcol = sum(Rgray);
Rrow = sum(Rgray,2);
RrowGrad = abs(Rrow(2:end) - Rrow(1:end-1));
[RrowGrad,RrowIndex] = sort(RrowGrad,'descend');

RcolGrad = abs(Rcol(2:end) - Rcol(1:end-1));
[RcolGrad,RcolIndex] = sort(RcolGrad,'descend');

rowSize = [RrowIndex(1),RrowIndex(2)];
colSize = [RcolIndex(1),RcolIndex(2)];
rowSize = sort(rowSize);
colSize = sort(colSize);

R = R(rowSize(1):rowSize(2),colSize(1):colSize(2),:);
R = imresize(R,sizet * 8);
% imshow(R)
savePath = ['../../' virtualModel{1} '/colormap90_360gaussianProcessHeatmap' virtualModel{1} '.jpg'];
disp(savePath)
% save and read to get color information
imwrite(R,savePath);
figure(2)
colorbar
savePath = ['../../' virtualModel{1} '/colormap90_360gaussianProcess' virtualModel{1} '.jpg'];
disp(savePath)
% grid off

% image(img)

% figure
% imshow(img)
% colormap jet

% x = 1:512;
% y = 1:512;
% 
% [X,Y] = meshgrid(x,y);


