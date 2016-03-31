function [id,cluster,label,clusterCenter] = picMeanShiftCU(cad,upd)
% cluster by cad and upd with mean shift method

ncases = size(cad,1);
label = cell(ncases,1);
id = 1:ncases;

disGraph = [];
for i=1:ncases
    disVec = getVecDistance(cad,upd,cad(i,:),upd(i,:));
    disGraph(i,:) = disVec;
end

minDis = min(min(disGraph));
maxDis = max(max(disGraph));
r = (maxDis - minDis) * 0.05 + minDis;
clear disGraph;

% for each case
for i=1:ncases
    innerSet = [];
    mcad = cad(i,:);
    mupd = upd(i,:);
    while 1
        disVec = getVecDistance(cad,upd,mcad,mupd);
        
        % find distance within r
        indSet = find(disVec < r);
        if isempty(setxor(innerSet,indSet))
            break;
        end
        innerSet = indSet;
        for j = 1:length(indSet)
            % get mean value
            [mcad,mupd] = meanValue(cad(indSet,:),upd(indSet,:));
        end
    end
    label{i}.mcad = mcad;
    label{i}.mupd = mupd;
    label{i}.nearSet = innerSet;
    disp(['mean shift cad upd ', num2str(i)]);
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

clusterCenter = zeros(clusterId,6);
for i = 1:clusterId
    index = find(cluster == i);
    clusterCenter(i,1:3) = label{index(1)}.mcad;
    clusterCenter(i,4:6) = label{index(1)}.mupd;
end

%% get mean value
function [mcad,mupd] = meanValue(cad,upd)
% get mean value
% s.t. cad * upd == 0
% so s.t. mcad * mupd == 0
% cad and upd are ncases * 3 matrix
mcad = mean(cad,1);
% normalize
mcad = mcad / norm(mcad);
mupd = mean(upd,1);
mupd = mupd / norm(mupd);
tmp = mupd * mcad' / (mcad * mcad') * mcad;
mupd = mupd - tmp;
mupd = mupd / norm(mupd);
%% get VecDistance
function ndis = getVecDistance(cad,upd,mcad,mupd)
% for two plane distance
% metric them by abs(cos(angle)) between them

% normal line vector
ncases = size(cad,1);
pvec = zeros(ncases,3);
ndis = zeros(ncases,1);
for i=1:ncases
    pvec(i,:) = cross(cad(i,:),upd(i,:));
end
mpvec = cross(mcad,mupd);
for i=1:ncases
    ndis(i) = 1 - abs((pvec(i,:) * mpvec') / norm(pvec(i,:)) / norm(mpvec));
end
ndis = ndis';