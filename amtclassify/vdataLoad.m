%% this file was created to load features of virtual models
% where models is a cell array
function [fea2d,fea3d] = vdataLoad(models)

fea2d = {};
fea3d = {};
% visit models
for i = 1 : length(models)
    sceneName = models{i};
    fea2Dfile = ['/home/h005/Documents/vpDataSet/' sceneName '/vpFea/' sceneName '.2df'];
    fea3Dfile = ['/home/h005/Documents/vpDataSet/' sceneName '/vpFea/' sceneName '.3df'];

    fea2dtmp = scload(fea2Dfile,sceneName);
    fea3dtmp = scload(fea3Dfile,sceneName);

    fea2d = {fea2d{:},fea2dtmp{:}};
    fea3d = {fea3d{:},fea3dtmp{:}};
end