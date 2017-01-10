%% this file was created showing cluster score for each model
% model is the model name such as 'kxm','bigben','freeGodness' ...
% clusterFile is the summary file of cluster result with the suffix
% .cluster
% clusters is the cluster id array will showed
% mode = 0 show the distribution of each cluster
% mode = 1 show the average score of each cluster
function showClusterScore(model,clusterFile,clusters,mode)
addpath ../amtclassify/
[sc,scr,fea2d,fea3d] = dataLoad(model);
sceneName = model{1};
% readin the clusterFile
fid = fopen(clusterFile,'r');
tline = fgetl(fid);
tline = strtrim(tline);
tmp = strread(tline);
nCluster = tmp(1);
nCases = tmp(2);
index = 0;
for i=1:nCases
    tline = fgetl(fid);
    tline = strtrim(tline);
%     tline = './img0004.jpg 2904.133107 -3008.840410 -29.328720 -0.469484 0.844504 0.257677 0.127224 -0.224090 0.966229 4';
    % spearate the file name and the camera info first.
    spaceId = find(tline == ' ');
    fileName = tline(1:spaceId(1));
    [pathstr,name,ext] = fileparts(fileName);
    fileName = [sceneName '/' name ext];
    fileName = strtrim(fileName);
    cId = tline(spaceId(end)+1:end);
    cId = strread(cId);
    tline = tline(spaceId(1)+1:spaceId(end));
    tline = strtrim(tline);
    posInfo = strread(tline);
    if mode == 1
        sc = scr;
    end
    id = findName(sc,fileName);
    if id == -1
        disp([fileName ' does not have scores']);
        continue;
    end
    index = index + 1;
    pic{index}.fn = fileName;
    pic{index}.cId = cId;
    pic{index}.sc = sc{id}.fs;
    pic{index}.pos = posInfo;
end

% show the distribution by clusters
if mode == 0
    showClusterDistribution(clusters, nCluster, pic);
elseif mode == 1
    showClusterAverageScore(clusters, nCluster, pic);
end

end

function showClusterAverageScore(clusters, nCluster, pic)

if numel(clusters) == 0
    % without assign the clusterId will showed
    % show all
    m = 3;
    n = 5;
    % there is no need to show the figures
    clusterScore = cell(1,nCluster);
    averageScore = zeros(1,nCluster);
    for i=1:nCluster
        id = findScore(pic,i);
        for j = 1:numel(id)
            clusterScore{i} = [clusterScore{i}, pic{id(j)}.sc];
        end
        averageScore(i) = mean(clusterScore{i});
    end
    
    disp(averageScore)
    
end

end

function showClusterDistribution(clusters,nCluster,pic)
if numel(clusters) == 0
    % without assign the clusterId will showed
    % show all
    m = 3;
    n = 5;
    figure
    clusterScore = cell(1,nCluster);
    for i=1:nCluster
        id = findScore(pic,i);
        for j=1:numel(id)
            clusterScore{i} = [clusterScore{i}, pic{id(j)}.sc];
        end
        subplot(m,n,i);
        histogram(clusterScore{i},'Normalization','count')
    end
else
    m = 2;
    n = 3;
    figure
    clusterScore = cell(1,numel(clusters));
    for i = 1:numel(clusters)
        id = findScore(pic,clusters(i));
        for j = 1:numel(id)
            clusterScore{i} = [clusterScore{i}, pic{id(j)}.sc];
        end
        subplot(m,n,i);
        histogram(clusterScore{i},'Normalization','count');
    end
end
end

function id = findName(sc,fileName)
    id = -1;
    for i = 1 : numel(sc)
        if strcmp(sc{i}.fname,fileName)
            id = i;
            return;
        end
    end
end

function id = findScore(pic,cId)
    id = [];
    index = 0;
    for i=1:numel(pic)
        if i == 386
            a = 1:3;
        end
%         [i, pic{i}.cId]
        if pic{i}.cId == cId
            index = index + 1;
            id(index) = i;
        end
    end
end