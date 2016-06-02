%% pic mean shift with position
function [id,cluster,label,clusterCenter] = picMeanShiftPS(ps)
% this function was created to cluster pics by camera
% position first, then by camera direction and camera up direction
% all by mean shift

ncases = size(ps,1);
label = cell(ncases,1);
id = 1:ncases;

disGraph = [];
for i = 1:ncases
    disVec = getCameraDistance(ps,ps(i,:));
    disGraph(i,:) = disVec;
end
minDis = min(min(disGraph));
% maxDis = max(max(disGraph));

[N,edges] = histcounts(disGraph);
rMax = edges(end);
total = sum(N);
acc = 0;
for i = 1 : N
    if acc / total > 0.95
        rMax = edges(i);
        break;
    end
    acc = N(i) + acc;  
end

r = (rMax - minDis) * 0.1 + minDis;
clear disGraph;

for i = 1:ncases
    innerSet = [];
    mps = ps(i,:);
    while 1
        disVec = getCameraDistance(ps,mps);
        
        % find distance within r
        indSet = find(disVec < r);
        if isempty(setxor(innerSet,indSet))
            break;
        end
        innerSet = indSet;
        for j = 1:length(indSet)
            % get mean value
            mps = mean(ps(indSet,:),1);
        end
    end
    label{i}.mps = mps;
    label{i}.nearSet = innerSet;
    disp(['camera position cluster: ' num2str(i)]);
end

clusterId = 0;
cluster = zeros(1,ncases);
for i = 1:ncases
    if cluster(i) ~= 0
        continue;
    else
        clusterId = clusterId + 1;
        cluster(i) = clusterId;
    end
    for j = i+1:ncases
        if cluster(j) ~= 0
            continue;
        else
            if isempty(setxor(label{i}.nearSet,label{j}.nearSet))
                cluster(j) = cluster(i);
            end
        end
    end
end
clusterCenter = zeros(clusterId,3);
for i=1:clusterId
    index = find(cluster == i);
    clusterCenter(i,1:3) = label{index(1)}.mps;
end


function edis = getCameraDistance(ps,mps)
% compute cameras' Euclidean distance
ncases = size(ps,1);
edis = zeros(ncases,1);
tmpEdis = ps - repmat(mps,ncases,1);
for i = 1:ncases
    edis(i) = norm(tmpEdis(i,:));
end