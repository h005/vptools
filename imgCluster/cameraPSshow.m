%% Camera position shows
clear;
close all;
clc

modelName = 'notredame';

matrixFile = ['/home/h005/Documents/vpDataSet/' modelName '/vpFea/selectedMatrix.matrix'];

fid = fopen(matrixFile,'r');
ind = 0;
%% read in data
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
psx = ps(:,1);
psy = ps(:,2);
psz = ps(:,3);
[X,Y] = meshgrid(psx,psy);
% Z = griddata(psx,psy,psz,X,Y,'cubic');
% mesh(X,Y,Z)
hold on
plot3(psx,psy,psz,'.','MarkerSize',16);
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')
plot3(0,0,0,'.','MarkerSize',25);
hold off
grid on
