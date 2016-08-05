%% this script contains feature name with it's ID
% load in visualFea and geometricFea
% each of them contains name and index field
% read file to get them
function [visualFea, geometricFea, validVisualIndex, validGeoIndex] = feaNameLoad()
path = ['/home/h005/Documents/vpDataSet/kxm/vpFea/', 'kxm','.2dfname'];
fid = fopen(path,'r');
ind = 0;
index = 0;
while 1
    tline = fgetl(fid);
    if tline == -1
        break;
    end
    ind = ind + 1;
    index = index + 1;
    tline = strtrim(tline);
    if strcmp(tline, '')
        break;
    end
    if ind == 1
        visualFea{ind}.name = tline;
        visualFea{ind}.index = index;
    else
        if strcmp(tline,visualFea{ind-1}.name)
            ind = ind -1;
            visualFea{ind}.index = [visualFea{ind}.index index];
        else
            visualFea{ind}.name = tline;
            visualFea{ind}.index = index;
        end
    end
end

path = ['/home/h005/Documents/vpDataSet/kxm/vpFea/', 'kxm','.3dfname'];
fid = fopen(path,'r');
ind = 0;
index = 0;
while 1
    tline = fgetl(fid);
    if tline == -1
        break;
    end
    ind = ind + 1;
    index = index + 1;
    tline = strtrim(tline);
    if strcmp(tline, '')
        break;
    end
    if ind == 1
        geometricFea{ind}.name = tline;
        geometricFea{ind}.index = index;
    else
        if strcmp(tline,geometricFea{ind-1}.name)
            ind = ind -1;
            geometricFea{ind}.index = [geometricFea{ind}.index index];
        else
            geometricFea{ind}.name = tline;
            geometricFea{ind}.index = index;
        end
    end
end

validVisualFea = {'hogHist','EntropyVariance','HueCount','ruleOfThird'};
% ,'contrast','brightness'
validGeoFea = {'projectArea',...
    'visSurfaceArea',...
    'viewPointEntropy',...
    'silhouetteLength',...
    'silhouetteCurvature',...
    'maxDepth',...
    'depthDistribute',...
    'meanCurvature',...
    'gaussianCurvature',...
    'outlierCount',...
    'boundingBox',...
    'ballCoord'};

%     'abovePreference',...

for i=1:length(visualFea)
    visualName{i} = visualFea{i}.name;
end

for i=1:length(geometricFea)
    geometricName{i} = geometricFea{i}.name;
end

[fname,Ivis,IvalidVis] = intersect(visualName,validVisualFea);

validVisualIndex = [];
for i=1:length(Ivis)
    validVisualIndex = [validVisualIndex, visualFea{Ivis(i)}.index];
end

[fname,Igeo,IvalidGeo] = intersect(geometricName,validGeoFea);

validGeoIndex = [];
for i=1:length(Igeo)
    validGeoIndex = [validGeoIndex, geometricFea{Igeo(i)}.index];
end
