%% this function was created to compute gist features
function [fea, feaPara] = gistFeaGen(filelist)

fea = cell(numel(filelist),1);
feaPara = cell(numel(filelist),1);

param.imageSize = [256 256]; % it works also with non-square images
param.orientationsPerScale = [8 8 8 8];
param.numberBlocks = 1;
param.fc_prefilt = 4;

for i=1:numel(filelist)
    
    disp(filelist{i})
    img1 = imread(filelist{i});
    [gist, param] = LMgist(img1, '', param);
    fea{i} = gist;
    feaPara{i} = param;
    
end