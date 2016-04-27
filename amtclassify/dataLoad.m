%% this file was careted to load data in models
% where models is a cell array
function [sc,scr,fea2d,fea3d] = dataLoad(models)

sc = {};
scr = {};
fea2d = {};
fea3d = {};
% visit models
for i = 1 : length(models)
    sceneName = models{i};
    scorefile = ['/home/h005/Documents/vpDataSet/' sceneName '/score/' sceneName '.sc'];
    fea2Dfile = ['/home/h005/Documents/vpDataSet/' sceneName '/vpFea/' sceneName '.2df'];
    fea3Dfile = ['/home/h005/Documents/vpDataSet/' sceneName '/vpFea/' sceneName '.3df'];

    sctmp = scload(scorefile,sceneName);
    scrtmp = assScore(sctmp,'ave');

    fea2dtmp = scload(fea2Dfile,sceneName);
    fea3dtmp = scload(fea3Dfile,sceneName);

    sc = {sc{:}, sctmp{:}};
    scr = {scr{:}, scrtmp{:}};
    fea2d = {fea2d{:},fea2dtmp{:}};
    fea3d = {fea3d{:},fea3dtmp{:}};
end
