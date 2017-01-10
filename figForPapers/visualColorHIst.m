%% this script was created for ploting the histogram of the given photo
clear
clc
close all
imgpath = '/home/h005/Documents/vpDataSet/kxm/imgs/img0826.jpg';
img = imread(imgpath);
%{
% img = im2double(img);
% img(:,:,1) = img(:,:,1) * 255;
% img(:,:,2) = img(:,:,2) * 255 + 256;
% img(:,:,3) = img(:,:,3) * 255 + 256 * 2;
figure
subplot(1,3,1)
h = histogram(img(:,:,1),32,...
    'FaceColor','red',...
    'Normalization','probability',...
    'EdgeColor','red');
% hold on
subplot(1,3,2)
h1 = histogram(img(:,:,2),32,...
    'FaceColor','green',...
    'Normalization','probability',...
    'EdgeColor','green');
%     'edges',[256,256+255],...
% hold on
subplot(1,3,3)
h2 = histogram(img(:,:,3),32,...
    'FaceColor','blue',...
    'Normalization','probability',...
    'EdgeColor','blue');
%     'edges',[256*2,256*3],...
%}
% plot rule of thirds
rowline1 = size(img,1)/3;
rowline2 = size(img,1)/3*2;
colline1 = round(size(img,2)/3);
colline2 = round(size(img,2)/3*2);
% plot line
figure
lineWidth = 3;
img(rowline1:rowline1+lineWidth,1:size(img,2),:) = img(rowline1:rowline1+lineWidth,1:size(img,2),:)/3;
img(rowline2:rowline2+lineWidth,1:size(img,2),:) = img(rowline2:rowline2+lineWidth,1:size(img,2),:)/3;
img(1:size(img,1),colline1:colline1+lineWidth,:) = img(1:size(img,1),colline1:colline1+lineWidth,:)/3;
img(1:size(img,1),colline2:colline2+lineWidth,:) = img(1:size(img,1),colline2:colline2+lineWidth,:)/3;
imshow(img)
% hold on
% plot row line 1
% plot([0,size(img,2)],[rowline1,rowline1])
% hold on