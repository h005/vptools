%% feature Compare

virtualModel = {'njuSample','njuSample3'};

feaCom = {};

for i = 1:numel(virtualModel)
    [vfea2d,vfea3d] = vdataLoad({virtualModel{i}});
    
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
    feaCom{i} = vf3d;
end

[feaCom{1}(1:10),feaCom{2}(1:10)]

