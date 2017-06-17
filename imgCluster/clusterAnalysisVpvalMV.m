%% analysis cluster result by photo's mv matrix
clear
clc
clusterStart
addpath ./vpval/
model = {'kxm'};
modelName = model{1};

% read in .cluster file
clusterFile = '../../kxm/model/kxmPt.cluster';

% read in .cluster file
[picInfo, centerInfo] = clusterReaderVpval(clusterFile,model{1});

matrixFile = ['/home/h005/Documents/vpDataSet/' modelName '/model/' modelName 'Pt.matrix'];
% read in matrix file
fid = fopen(matrixFile,'r');
ind = 0;

while 1
    tline = fgetl(fid);
    if tline == -1
        break;
    end
    tline = strtrim(tline);
    if isempty(tline)
        break;
    end
    ind = ind + 1;
%     disp(num2str(ind))
%     if ind == 125
%         disp('debug')
%     end
    fileName{ind} = tline;
    tline = fgetl(fid);
    arr0 = strread(tline);
    tline = fgetl(fid);
    arr1 = strread(tline);
    tline = fgetl(fid);
    arr2 = strread(tline);
    tline = fgetl(fid);
    arr3 = strread(tline);
    mv(ind,:,:) = [arr0(1:4);arr1(1:4);arr2(1:4);arr3(1:4)];
    tline = fgetl(fid);
    tline = fgetl(fid);
    tline = fgetl(fid);
    tline = fgetl(fid);
end
fclose(fid);

%% merge
for i=1:numel(picInfo)
    [pathstr, name, ext] = fileparts(picInfo{i}.fn);
    % pathstr is the model name
    for j=1:numel(fileName)
        [pathstr, name1, ext] = fileparts(fileName{j});
        if strcmp(name1,name)
%             pmv = convertmv2(mv(j,:,:));
%             picInfo{i}.mv = pmv;
            picInfo{i}.mv = mv(j,:,:);
            break;
        end
    end
end

clusterId = cell(numel(centerInfo),1);
clusterCenterId = zeros(numel(centerInfo),1);
for j=1:numel(centerInfo)
    for i=1:numel(picInfo)
        if picInfo{i}.cId == j
            clusterId{j} = [clusterId{j},i];
        end
    end
end

for j=1:numel(centerInfo)
    
    cmv = zeros(numel(clusterId{j}),4,4);
    for i=1:numel(clusterId{j})
        cmv(i,:,:) = picInfo{clusterId{j}(i)}.mv;
    end
    
    [cluster, clusterCenter] = picKmedoidsMV2(cmv);
    
    for i=1:numel(clusterId{j})
        tmpmv = reshape(cmv(i,:,:),1,16);
        res = tmpmv == clusterCenter;
        if sum(res) == 16
            clusterCenterId(j) = clusterId{j}(i);
            break;
        end
    end
    
end

%% compute distance in each cluster
clusterDis = cell(numel(centerInfo),1);
for i=1:numel(centerInfo)
    for j=1:numel(clusterId{i})
        centerMV = picInfo{clusterCenterId(i)}.mv;
        centerMV = reshape(centerMV,4,4);
        tmpMV = picInfo{clusterId{i}(j)}.mv;
        tmpMV = reshape(tmpMV,4,4);
        dis = mvDis(tmpMV,centerMV);
        clusterDis{i} = [clusterDis{i} dis];
    end
end

%% compute variance
varVal = zeros(numel(centerInfo),1);
numClusterVal = zeros(numel(centerInfo),1);
for i=1:numel(centerInfo)
    varVal(i) = var(clusterDis{i}) * (numel(clusterDis{i})-1) / numel(clusterDis{i});
    numClusterVal(i) = numel(clusterDis{i});
end

%% compute all the distance of in one cluster
clusterDisAll = cell(numel(centerInfo),1);
maxClusterDis = zeros(numel(centerInfo),1);
for i=1:numel(centerInfo)
    clusterDisAll{i} = zeros(numel(clusterId{i}),numel(clusterId{i}));
    for j=1:numel(clusterId{i})
        for k=1:numel(clusterId{i})
            tmpMV1 = picInfo{clusterId{i}(j)}.mv;
            tmpMV2 = picInfo{clusterId{i}(k)}.mv;
            tmpMV1 = reshape(tmpMV1,4,4);
            tmpMV2 = reshape(tmpMV2,4,4);
            dis = mvDis(tmpMV1,tmpMV2);
            clusterDisAll{i}(j,k) = dis;
        end
    end
    maxClusterDis(i) = max(max(clusterDisAll{i}));
end


[varVal,numClusterVal,maxClusterDis]




