%% svm2kRegressCombine
close all
% set Method
methodText = {'SVM-2K regress'};
%     virtualModel = {'castle','circle'};
% virtualModel = {'castle','circle'};
    virtualModel = {'njuSample3','0circle'};
%     virtualModel = {'njuActivity2','halfCircle'};

[vfea2d,vfea3d] = vdataLoad({virtualModel{1}});

len2d = numel(vfea2d{1}.fs);
[vf, vfname] = combine(vfea2d,vfea3d);
vf2d = vf(:,1:len2d);
vf3d = vf(:,len2d+1:end);

% this code was created for some selected features
[visualFea, geometricFea,validVisIndex, validGeoIndex] = feaNameLoad();
validVisIndex = sort(validVisIndex);
validGeoIndex = sort(validGeoIndex);
fs2d = fs2dAll(:,[validVisIndex,size(fs2dAll,2)]);
fs3d = fs3dAll(:,[validGeoIndex,size(fs3dAll,2)]);
%     fs = fs(:,[validVisIndex,visualFea{end}.index(end)+validGeoIndex, size(fs,2)]);

vf2d = vf2d(:,validVisIndex);
vf3d = vf3d(:,validGeoIndex);

mode = {'2D','3D','2D3D'};
method = 3;

ps = svm2kRegressStart(fs2d,fs3d,rate,vf2d,vf3d,mode{method});

for i = 1:numel(ps)
    disp([num2str(ps(i)) ' ' vfname{i}])
end

showColorMap;

