%% this script was created to valid feature's symmetry
% load features first

virtualModel = {'njuSample'};
    
[vfea2d,vfea3d] = vdataLoad(virtualModel);

[vf,vfname] = combine(vfea2d,vfea3d);

vf = vf';

% read in feature list
feaNamefile = ['/home/h005/Documents/vpDataSet/' virtualModel{1} '/vpFea/' virtualModel{1} '.fname'];
fid = fopen(feaNamefile,'r');
ind = 0;
while 1
    tline = fgetl(fid);
    if tline == -1
        break;
    end
    ind = ind + 1;
    tline = strtrim(tline);
    feaList{ind} = tline;
end

fig = figure(1);
for i=1:size(vf,1)
    sizet = [64,16];
    vfImg = vf(i,:);
    psImg = reshape(vfImg,sizet(1),sizet(2));
    % this was created for debug
    figure(1)
    image(psImg,'CDataMapping','scaled')
    title(feaList{i});
    savePath = ['/home/h005/Documents/vpDataSet/' virtualModel{1} '/vpFea/feaMap/' feaList{i} num2str(i) '.jpg'];
    disp(savePath)
    % save and read to get color information
    saveas(fig,savePath);
end
