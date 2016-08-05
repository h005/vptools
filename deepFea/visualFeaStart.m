%% fea2d start
% this script was created to compute deep visual features for each model

clear
clc
modelList = {
    'bigben',...
    'kxm',...
    'notredame',...
    'freeGodness',...
    'tajMahal',...
    'cctv3'...
    };

% load filename list
for i=1:numel(modelList)
    fileList = fileLoad(modelList{i});
%     fileList = {fileList{1}, fileList{2}};
    fea = visFea(fileList);
    deepFeaGen(modelList{i},fileList,fea);
    disp(['deepFeaGen done ' modelList{i}]);
end

