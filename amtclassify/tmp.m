%% this scripte was created for tmp find nan in fea2d 
for i = 1 : numel(fea2d)
    if sum(isnan(fea2d{i}.fs)) ~= 0
        disp([fea2d{i}.fname ' ' num2str(i)])
    end
end

% freeGodness/img0273.jpg
% tajMahal/img0841.jpg
% cctv3/img0103.jpg
% cctv3/img0103.jpg
