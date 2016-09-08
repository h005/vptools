%% this script was created to compute vanish Feature
% and write features to .vnf file
clear;
clc;

modelList = {
    'bigben',...
    'kxm',...
    'notredame',...
    'freeGodness',...
    'tajMahal',...
    'cctv3'...
    };

suffix = {
    '.vnf',...
    '.2dvnf',...
    '.2dvnfname'...
    };

clearFiles(modelList,suffix);
disp('clear done');

% load filename first
for i = 1:numel(modelList)
    fileList = fileLoad(modelList{i});
    fea = vanishFeaGen(fileList);  
%     write features to files
    writeFea(modelList{i}, fileList, fea);
    disp(['vanishFeaGen done ' modelList{i}])
end
