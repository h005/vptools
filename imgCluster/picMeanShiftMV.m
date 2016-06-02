%% mean shift cluster imgs metric distance by mv matrix
function [cluster,label,clusterCenter] = picMeanShiftMV(mv)
% mv matrix is matrix ncases * 4 * 4
ncases = size(mv,1);
label = cell(ncases,1);
id = 1:ncases;
% logmv is cells ncases * 1
logmv = convert2logm(mv);
disp('picMeanShiftMV convert done');
% comput r
disGraph = [];
for i = 1:ncases
    disVec = getVecDistance(logmv,logmv{i});
    disGraph(i,:) = disVec;
    disp(['picMeanShiftMV distance compute ' num2str(i)]);
end
disGraph = reshape(disGraph,size(disGraph,1)*size(disGraph,2),1);
minDis = min(disGraph);
% histogram(disGraph);
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

% [maxval,maxindex] = max(N);
r = (rMax - minDis) * 0.01 + minDis;
% r = 1.10;

% for each case
for i=1:ncases
    innerSet = [];
    mlogmv = logmv{i};
    while 1
        disVec = getVecDistance(logmv,mlogmv);
        
        % find distance within r
        indSet = find(disVec < r);
        if isempty(setxor(innerSet,indSet))
            break;
        end
        innerSet = indSet;
%         for j=1:length(indSet)
            % get mean value
        mlogmv = meanValue(logmv,indSet);
%         end
    end
    label{i}.mlogmv = mlogmv;
    label{i}.nearSet = innerSet;
    disp(i);
    disp(['innerSet: ' num2str(innerSet')]);
end

clusterId = 0;
cluster = zeros(1,ncases);
for i=1:ncases
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

% clusterCenter = cell(clusterId,1);
disp(['clusters ' num2str(clusterId)]);
clusterCenter = zeros(clusterId,16);
for i=1:clusterId
    index = find(cluster == i);
%     clusterCenter{i} = reshape(label{index(1)}.mlogmv,1,16);
    clusterCenter(i,:) = reshape(label{index(1)}.mlogmv,1,16);
end

function disVec = getVecDistance(logmv,mlogmv)
ncases = size(logmv,1);
disVec = zeros(ncases,1);
for i=1:ncases
    disVec(i) = norm(expm(logmv{i} - mlogmv));
end

function logmv = convert2logm(mv)
ncases = size(mv,1);
logmv = cell(ncases,1);
for i=1:ncases
    tmpmv = mv(i,:,:);
    tmpmv = reshape(tmpmv,4,4);
    logmv{i} = logm(tmpmv);
end

function mlogmv = meanValue(logmv,indSet)
ncases = numel(indSet);
mlogmv = zeros(4,4);
for i=1:ncases
    mlogmv = mlogmv + logmv{indSet(i)};
end
mlogmv = mlogmv ./ ncases;
