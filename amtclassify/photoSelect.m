%% this script was created for get the result for some high quality and low quality photos

clear
close all
clc

addpath('../');

% modelList = {
%     'bigben',...
%     'kxm',...
%     'notredame'...
%     'freeGodness'...
%     'tajMahal',...
%     'cctv3'
% %     'tam'
% };

modelList = {
    'bigben',...
    'kxm',...
    'notredame',...
    'freeGodness',...
    'tajMahal',...
    'cctv3',...
    'capitol',...
    'Sacre',...
    'TengwangPavilion',...
    'mont',...
    'HelsinkiCathedral',...
    'BuckinghamPalace',...
    'BritishMuseum',...
    'BrandenburgGate',...
    'potalaPalace'
    };

rate = 0.08;
% load Data
% sc = scload(scorefile,sceneName);
[sc,scr,fea2d,fea3d] = dataLoad(modelList);
[fs, fname] = combine(fea2d,fea3d,scr);
[fs2d, fname2d] = combine(fea2d,scr);
[fs3d, fname3d] = combine(fea3d,scr);

score = fs2d(:,end);

[scored,index] = sort(score);

ncases = numel(score);
num = round(ncases * rate);
negIdx = index(1:num);
posIdx = index(end - num + 1 : end);
idx = [negIdx;posIdx];
label = zeros(2*num,1);
label(num+1:end) = 1;
% load indices
% disp('.............. resulta ..............');
% load svmPrelabel
% load pl
% for i=1:2*num
%     disp([fname{idx(i)} ' ' num2str(label(i)) ' ' num2str(preLabel(i)) ' ' num2str(pl{3}(3,i))])
% end




% num = 20;
disp('...............high quality...........')
len = length(index);
for i=1:num
    disp(scr{index(len - i + 1)}.fname)
end

disp('............low quality.............')
for i=1:num
    disp(scr{index(i)}.fname)
end

