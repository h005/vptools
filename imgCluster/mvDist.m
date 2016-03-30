clear
clc
matrixFile = '/home/h005/Documents/vpDataSet/notredame/vpFea/notredameSelected.matrix';
fid = fopen(matrixFile,'r');
ind = 0;
while 1
    tline = fgetl(fid);
    if tline == -1
        break;
    end
    ind = ind + 1;
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
ps = ps(1:10,:);
cad = cad(1:10,:);
upd = upd(1:10,:);
[id,cluster,label] = picMeanShift(ps,cad,upd);


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

