clear
clc
%{
matrixFile = '/home/h005/Documents/vpDataSet/notredame/vpFea/notredame.matrix';
imgSource = '/home/h005/Documents/vpDataSet/notredame/imgs';
clusterDest = '/home/h005/Documents/vpDataSet/notredame/cluster';
feaFile = '/home/h005/Documents/vpDataSet/notredame/vpFea/notredame.fs';
%}
modelName = 'videoCut1';
% matrixFile = '/home/h005/Documents/vpDataSet/kxm/vpFea/kxm.matrix';
matrixFile = ['/home/h005/Documents/vpDataSet/' modelName '/vpFea/selectedMatrix.matrix'];
% imgSource = '/home/h005/Documents/vpDataSet/kxm/imgs';
imgSource = ['/home/h005/Documents/vpDataSet/' modelName '/imgs'];
% clusterDest = '/home/h005/Documents/vpDataSet/kxm/cluster';
clusterDest = ['/home/h005/Documents/vpDataSet/' modelName '/cluster'];
% feaFile = '/home/h005/Documents/vpDataSet/kxm/vpFea/kxm.fs';
fid = fopen(matrixFile,'r');
ind = 0;
% ps cad upd meanshift
% method = 1;
% ps first cad upd next
%%
%{
method = 'meanshiftPCU'
        'meanshiftPcu'
        'meanshiftMV'
        'kmedoidsMV'
        'meanshiftP'
        'meanshiftCUp'
%}
% method = 'kmedoidsMV';
method = 'kmedoidsMV';
%%
copyFlag = 1;
output = 1;
showDistribution = 0;

while 1
    tline = fgetl(fid);
    if tline == -1
        break;
    end
    ind = ind + 1;
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

[ps,cad,upd] = extractCameraInfo(mv);
num = size(ps,1);
% num = 100;
ps = ps(1:num,:);
cad = cad(1:num,:);
upd = upd(1:num,:);


validIndex = clearOutLiers(ps);
% do not clear outliers
validIndex = 1:num;
ps = ps(validIndex,:);
cad = cad(validIndex,:);
upd = upd(validIndex,:);
% copy fileName
for i=1:numel(validIndex)
    fileList{i} = fileName{validIndex(i)};
end
fileName = fileList;
mv = mv(validIndex,:,:);
ind = numel(validIndex);
% mv = mv(1:100,:,:);

switch method
    case 'kmedoidsMV'
        [cluster,clusterCenter] = picKmedoidsMV(mv);
%         cameraPSshow(ps,cluster,modelName);
%         plotModel;
%         cameraPSshow(ps,cluster,modelName);
    case 'meanshiftMV'
        [cluster,label,clusterCenter] = picMeanShiftMV(mv);
    case 'meanshiftPCU'
        [id,cluster,label,clusterCenter] = picMeanShift(ps,cad,upd);
    case 'meanshiftP'
        [id,cluster,label,clusterCenter] = picMeanShiftPS(ps);
        clusterCenter = [clusterCenter,clusterCenter,clusterCenter];
        cameraPSshow(ps,cluster,modelName);
    case 'meanshiftPcu'
        
        ncases = size(ps,1);
        id = zeros(ncases,1);
        cluster = zeros(ncases,1);
        label = cell(ncases,1);
        
    %     clusterCenter = zeros(ncases,9);
        [idPS,clusterPS,labelPS,clusterCenterPS] = picMeanShiftPS(ps);
        numClusterPS = size(clusterCenterPS,1);
        cameraPSshow(ps,clusterPS,modelName);
        % num of cluster
        ncl = 0;
        pcCluster = zeros(2,numClusterPS);
        for i = 1:numClusterPS
            clSet = find(clusterPS == i);
            [idcu,clustercu,labelcu,clusterCentercu] = picMeanShiftCU(cad(clSet,:),upd(clSet,:));
            pcCluster(1,i) = ncl+1;
            % sub clusters
            for j = 1:size(clusterCentercu,1)
                ncl = ncl + 1;
                % cluseter set by cad and upd
                cuSet = find(clustercu ==  j);
                cluster(clSet(cuSet)) = ncl;
                clusterCenter(ncl,:) = [clusterCenterPS(i,:),clusterCentercu(j,:)];
            end
            pcCluster(2,i) = ncl;
        end
    case 'meanshiftCUp'
        ncases = size(ps,1);
        id = zeros(ncases,1);
        cluster = zeros(ncases,1);
        label = cell(ncases,1);

        [idcu,clustercu,labelcu,clusterCentercu] = picMeanShiftCU(cad,upd);
        numClustercu = size(clusterCentercu,1);
        ncl = 0;
        pcCluster = zeros(2,numClustercu);

        for i=1:numClustercu
            clSet = find(clustercu == i);
            [idPS,clusterPS,labelPS,clusterCenterPS] = picMeanShiftPS(ps(clSet,:));
            pcCluster(1,i) = ncl+1;
            % sub clusters
            for j=1:size(clusterCenterPS,1)
                ncl = ncl + 1;
                cuSet = find(clusterPS == j);
                cluster(clSet(cuSet)) = ncl;
                clusterCenter(ncl,:) = [clusterCenterPS(j,:),clusterCentercu(i,:)];
            end
            pcCluster(2,i) = ncl;
        end
        
end
%% plot the result
% histogram(cluster,max(cluster));
% title('cluster distribution');
%% output to .cluster file
if output
    %% print out clustering info
    dot = find(matrixFile == '.');
    clusterFile = [matrixFile(1:dot) 'cluster'];
    fid = fopen(clusterFile,'w');
    fprintf(fid,'%d %d\n',size(clusterCenter,1),ind);
    for i=1:ind
        fprintf(fid,'%s %f %f %f %f %f %f %f %f %f %d\n',...
            fileName{i},...
            ps(i,1),...
            ps(i,2),...
            ps(i,3),...
            cad(i,1),...
            cad(i,2),...
            cad(i,3),...
            upd(i,1),...
            upd(i,2),...
            upd(i,3),...
            cluster(i));
    end

    for i=1:size(clusterCenter,1)

        fprintf(fid,'%f %f %f %f %f %f %f %f %f\n',clusterCenter(i,1),...
            clusterCenter(i,2),...
            clusterCenter(i,3),...
            clusterCenter(i,4),...
            clusterCenter(i,5),...
            clusterCenter(i,6),...
            clusterCenter(i,7),...
            clusterCenter(i,8),...
            clusterCenter(i,9));

    end

    fclose(fid);
    disp('write done');
end
%% copy images to folder with name as clusterId
if copyFlag
    % WARNNING: this function is dangerous!
    % make sure your clusterDest don't have another other important files
    clusterCopyTo(imgSource,clusterDest,fileName,cluster);
    disp('copy done');
end

if showDistribution
    % the last two column is score of the imgs
    feaData = load(feaFile);
    sc = feaData(:,end-1 : end);
    clear feaData;
    sc(find(sc(:,2)==0),2) = 1;
    sc = sc(:,1) ./ sc(:,2);
    clusterSet = 1:size(clusterCenter,1);
    showScoreDistribution(sc,cluster,clusterSet);
end

%% compute dist
%{
dot = find(matrixFile == '.');
distFile = [matrixFile(1:dot) 'dist'];
fid = fopen(distFile,'w');
for i=1:ind
    for j=1:ind
        A = reshape(mv(i,:,:),4,4);
        B = reshape(mv(j,:,:),4,4);
        dis = mvDis(A,B);
        fprintf(fid,'%d %d %f\n',i-1,j-1,dis);
    end
    disp(i)
end
fclose(fid);
%}

