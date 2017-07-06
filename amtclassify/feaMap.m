%% this script was created to valid feature's symmetry
% load features first
clear;
clc;

virtualModel = {'njuSample','njuSample2'};
    

[vfea2d,vfea3d] = vdataLoad({virtualModel{1}});

len2d = numel(vfea2d{1}.fs);
[vf, vfname] = combine(vfea2d,vfea3d);
vf2d1 = vf(:,1:len2d);
vf3d1 = vf(:,len2d+1:end);

% load the second model
[vfea2d,vfea3d] = vdataLoad({virtualModel{2}});

len2d = numel(vfea2d{1}.fs);
[vf, vfname] = combine(vfea2d,vfea3d);
vf2d2 = vf(:,1:len2d);
vf3d2 = vf(:,len2d+1:end);


% this code was created for some selected features
[visualFea, geometricFea,validVisIndex, validGeoIndex] = feaNameLoad();
validVisIndex = sort(validVisIndex);
validGeoIndex = sort(validGeoIndex);

% vf2d = vf2d(:,validVisIndex);
% vf3d = vf3d(:,validGeoIndex);

fig = figure(1);
% for i = 1:numel(visualFea)
%     arrIndex = visualFea{i}.index;
%     sizet = [64, 16];
%     for j=1:numel(arrIndex)
%         vfImg = vf2d(:,arrIndex(j));
%         psImg = reshape(vfImg,sizet(1),sizet(2));
%         % this was created for debug
%         figure(1)
%         image(psImg,'CDataMapping','scaled')
%         title(feaList{i});
%     end
% end

for i = 1:numel(geometricFea)
    arrIndex = geometricFea{i}.index;
    sizet = [64, 16];
    for j=1:numel(arrIndex)
        vfImg = vf3d1(:,arrIndex(j));
        psImg = reshape(vfImg,sizet(1),sizet(2));
        % this was created for debug
        figure(1)
        subplot(1,2,1)
        image(psImg,'CDataMapping','scaled')
        title([geometricFea{i}.name ' ' num2str(j)]);
        % plot the second model
        
        vfImg = vf3d2(:,arrIndex(j));
        psImg = reshape(vfImg,sizet(1),sizet(2));
        % this was created for debug
        figure(1)
        subplot(1,2,2)
        image(psImg,'CDataMapping','scaled')
        title([geometricFea{i}.name ' ' num2str(j)]);
        
    end
end

%%
%{
[vfea2d,vfea3d] = vdataLoad(virtualModel);

[vf,vfname] = combine(vfea2d,vfea3d);

vf = vf';


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
%     saveas(fig,savePath);
end

%}