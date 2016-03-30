function [id,cluster,label,clusterCenter] = picMeanShift(ps,cad,upd)
% function [id,cluster] = picMeanShift(ps,cad,upd,mv)
% ps cad upd is ncases * 3 matrix
% mv is ncases * 4 * 4 matrix

ncases = size(ps,1);
label = cell(ncases,1);
cluster = [];
id = 1:ncases;
%% case 1:
% get mean vlaue by ps cad upd
% get distance by mv matrix
    % minDis = min(min(disGraph));
    % maxDis = max(max(disGraph));
    % r = (maxDis - minDis) * 0.1 + minDis;

% compute r
disGraph = [];
for i=1:ncases
    disVec = getVecDistance(ps,cad,upd,ps(i,:),cad(i,:),upd(i,:));
    disGraph(i,:) = disVec;
end
minDis = min(min(disGraph));
maxDis = max(max(disGraph));
r = (maxDis - minDis) * 0.05 + minDis;
clear disGraph;


% for each case
for i = 1:ncases
    innerSet = [];
    mps = ps(i,:);
    mcad = cad(i,:);
    mupd = upd(i,:);
    while 1
        disVec = getVecDistance(ps,cad,upd,mps,mcad,mupd);
        
        % find distance within r
        indSet = find(disVec < r);
        if isempty(setxor(innerSet,indSet))
            break;
        end
        innerSet = indSet;
        for j = 1:length(indSet)
            % get mean value
            [mps,mcad,mupd] = meanValue(ps(indSet,:),cad(indSet,:),upd(indSet,:));
            
        end
    end
    label{i}.mps = mps;
    label{i}.mcad = mcad;
    label{i}.mupd = mupd;
    label{i}.nearSet = innerSet;
    disp(i)
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
    for j=i+1:ncases
        if cluster(j) ~= 0
            continue;
        else
            if isempty(setxor(label{i}.nearSet,label{j}.nearSet))
                cluster(j) = cluster(i);
            end
        end
    end
end

clusterCenter = zeros(clusterId,9);
for i=1:clusterId
    index = find(cluster == i);
    clusterCenter(i,1:3) = label{index(1)}.mps;
    clusterCenter(i,4:6) = label{index(1)}.mcad;
    clusterCenter(i,7:9) = label{index(1)}.mupd;
end



function [mps,mcad,mupd] = meanValue(ps,cad,upd)
% get mean vlaue
% but cad * upd  == 0
% so mcad * mupd == 0
% ps cas and upd are ncases * 3 matrix
mps = mean(ps,1);
mcad = mean(cad,1);
% normalize
mcad = mcad / norm(mcad);
mupd = mean(upd,1);
mupd = mupd / norm(mupd);
tmp = mupd * mcad' / (mcad * mcad') * mcad;
mupd = mupd - tmp;
mupd = mupd / norm(mupd);

%% vecDistance function
function disVec = getVecDistance(ps,cad,upd,mps,mcad,mupd)
% Euclidean distance is more meaningful
% comput Euclidean distance and then scale to [0,1]
% edis = ps * mps';
ncases = size(cad,1);
edis = zeros(ncases,1);
tmpEdis = ps - repmat(mps,ncases,1);
for i=1:ncases
    edis(i) = norm(tmpEdis(i,:));
end
edis = mapminmax(edis',0,1)';
% for two plane distace
% metric then by abs(cos(angle)) between them

% normal line vector
pvec = zeros(ncases,3);
ndis = zeros(ncases,1);
for i=1:ncases
    pvec(i,:) = cross(cad(i,:),upd(i,:));
end
mpvec = cross(mcad,mupd);
for i=1:ncases
    ndis(i) = abs((pvec(i,:) * mpvec') / norm(pvec(i,:)) / norm(mpvec));
end

disVec = edis + 1 - ndis;
disVec = disVec';



