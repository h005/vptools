clear
clc
matrixFile = '/home/h005/Documents/vpDataSet/notredame/vpFea/notredame.matrix';
imgSource = '/home/h005/Documents/vpDataSet/notredame/imgs';
clusterDest = '/home/h005/Documents/vpDataSet/notredame/cluster';
fid = fopen(matrixFile,'r');
ind = 0;
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
ps = ps(1:num,:);
cad = cad(1:num,:);
upd = upd(1:num,:);
[id,cluster,label,clusterCenter] = picMeanShift(ps,cad,upd);

histogram(cluster,max(cluster));
title('cluster distribution');

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

% copy images to folder with name as clusterId
% clusterCopyTo(imgSource,clusterDest,fileName,cluster);
disp('copy done');
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

