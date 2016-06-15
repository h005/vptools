%% show color map

[psc,psind] = sort(ps,'descend');

len = numel(ps);
% villa for others
% sizet = [64,16];
% villa7_1
sizet = [64,16];
psImg = reshape(ps,sizet(1),sizet(2));
img = imresize(psImg,sizet * 8);

surf(img);
colormap jet
axis on
xlabel('x lable');
ylabel('y label');
% hold on
fig = figure;
image(img,'CDataMapping','scaled')
colormap jet
colorbar
axis off
savePath = ['/home/h005/Documents/vpDataSet/' virtualModel{1} '/colormap90_360svm' virtualModel{1} '.jpg'];
disp(savePath)
saveas(fig,savePath);
% grid off

% image(img)

% figure
% imshow(img)
% colormap jet

% x = 1:512;
% y = 1:512;
% 
% [X,Y] = meshgrid(x,y);


