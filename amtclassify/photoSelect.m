%% this script was created for get the result for some high quality and low quality photos

clear
close all
clc

addpath('../');

modelList = {
    'bigben',...
    'kxm',...
    'notredame'...
    'freeGodness'...
    'tajMahal',...
    'cctv3'
%     'tam'
};

rate = 0.1;
% load Data
% sc = scload(scorefile,sceneName);
[sc,scr,fea2d,fea3d] = dataLoad(modelList);

score = zeros(numel(scr),1);
for i=1:numel(scr)
    score(i) = scr{i}.fs;
end

[scored,index] = sort(score);

num = 20;
disp('...............high quality...........')
len = length(index);
for i=1:num
    disp(scr{index(len - i + 1)}.fname)
end

disp('............low quality.............')
for i=1:num
    disp(scr{index(i)}.fname)
end

