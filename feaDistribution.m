% feature distribution
close all
clear;
clc;
feafile = '/home/h005/Documents/vpDataSet/notredame/vpFea/notredame.fs';
feaNameFile = '/home/h005/Documents/vpDataSet/notredame/vpFea/notredame.fname';

feaData = load(feafile);
fid = fopen(feaNameFile);
feaName = textscan(fid,'%s');
fclose(fid);


% ncases * m
% last two columns are score
fea = feaData(:,1:end-2);

score = feaData(:,end-1:end);

score(find(score(:,2)==0),2) = 1;
% score = score(:,1) ./ score(:,2);

% hist(fea(:,1));
figure(1)

for i=1:20
    subplot(4,5,i);
    histogram(fea(:,i),'Normalization','probability');
    title(feaName{1}(i));
end

figure(2)
for i=21:40
    subplot(4,5,i-20)
    histogram(fea(:,i),'Normalization','probability');
    title(feaName{1}(i));    
end

figure(3)
for i=41:45
    subplot(4,5,i-40)
    histogram(fea(:,i),'Normalization','probability');
    title(feaName{1}(i));
end

figure(4)
histogram(score(:,2),'BinWidth',10,'Normalization','count');
title('score');

score = score(:,1) ./ score(:,2);
figure(5)
histogram(score,'Normalization','probability');
title('score');