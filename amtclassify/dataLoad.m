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
    scorefile = ['../vpData/' sceneName '/score/' sceneName '.sc'];
    fea2Dfile = ['../vpData/' sceneName '/vpFea/' sceneName '.2dvnf'];
    fea3Dfile = ['../vpData/' sceneName '/vpFea/' sceneName '.3df'];

    sctmp = scload(scorefile,sceneName);
    scrtmp = assScore(sctmp,'ave');

    fea2dtmp = scload(fea2Dfile,sceneName);
    fea3dtmp = scload(fea3Dfile,sceneName);

    index = ones(1,numel(fea2dtmp));
    index = logical(index);
    % after compute vanish line features, nan error appears
    % when we encountered these cases just delete these pictures
    % check for 2D features    
    for j=1:numel(fea2dtmp)
        if sum(isnan(fea2dtmp{j}.fs)~=0)
            index(j) = 0;
        end
    end
    % check for 3D features
    for j=1:numel(fea3dtmp)
        if sum(isnan(fea3dtmp{j}.fs)~=0)
            index(j) = 0;
        end
    end
    
    sc = {sc{:}, sctmp{:}};
    scr = {scr{:}, scrtmp{:}};
    fea2d = {fea2d{:},fea2dtmp{index}};
    fea3d = {fea3d{:},fea3dtmp{index}};
    disp([sceneName ' ' num2str(sum(index)) ' pictures loaded'])
end
