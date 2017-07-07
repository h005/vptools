%% this script contains feature name with it's ID
% load in visualFea and geometricFea
% each of them contains name and index field
% read file to get them
function [visualFea, geometricFea, validVisualIndex, validGeoIndex] = feaNameLoad()
path = ['../vpData/kxm/vpFea/', 'kxm','.2dvnfname'];
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

path = ['../vpData/kxm/vpFea/', 'kxm','.3dfname'];
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

% validVisualFea = {'hogHist','EntropyVariance','HueCount','ruleOfThird'};
% ,'contrast','brightness'

% validVisualFea = {
%     'HueCount',...
%     'contrast',...
%     'brightness',...
%     'ruleOfThird',...
%     'hogHist',...
%     '2DTheta',...
%     'EntropyVariance',...
%     'color blue mean',...   
%     'color green mean',...
%     'color red mean',...
%     'HueHist',...
%     'HueEntropy',...
%     'SaturationHist',...
%     'SaturationEntropy',...
%     'ContrastBrightness',...
%     'blur',...
%     'LineSegment',...
%     'vanish Line',...
%     'gist'
% };

validVisualFea = {};
% validVisualFea = {validVisualFea{:},'contrast'};
% validVisualFea = {validVisualFea{:},'brightness'};
validVisualFea = {validVisualFea{:},'SaturationHist'};
validVisualFea = {validVisualFea{:},'SaturationEntropy'};
validVisualFea = {validVisualFea{:},'ContrastBrightness'};
% validVisualFea = {validVisualFea{:},'blur'};
% validVisualFea = {validVisualFea{:},'2DTheta'};
validVisualFea = {validVisualFea{:},'HueCount'};
validVisualFea = {validVisualFea{:},'EntropyVariance'};
validVisualFea = {validVisualFea{:},'color blue mean'};
validVisualFea = {validVisualFea{:},'color green mean'};
validVisualFea = {validVisualFea{:},'color red mean'};
validVisualFea = {validVisualFea{:},'HueHist'};
validVisualFea = {validVisualFea{:},'HueEntropy'};
validVisualFea = {validVisualFea{:},'ruleOfThird'};
validVisualFea = {validVisualFea{:},'hogHist'};
validVisualFea = {validVisualFea{:},'vanish Line'};
validVisualFea = {validVisualFea{:},'gist'};
validVisualFea = {validVisualFea{:},'LineSegment'};


validGeoFea = {};
% validGeoFea = {validGeoFea{:},'maxDepth'};
validGeoFea = {validGeoFea{:},'visSurfaceArea'};
% validGeoFea = {validGeoFea{:},'depthDistribute'};
validGeoFea = {validGeoFea{:},'projectArea'};
validGeoFea = {validGeoFea{:},'viewPointEntropy'};
validGeoFea = {validGeoFea{:},'silhouetteLength'};
validGeoFea = {validGeoFea{:},'silhouetteCurvature'};
validGeoFea = {validGeoFea{:},'silhouetteCurvatureExtrema'};
validGeoFea = {validGeoFea{:},'meanCurvature'};
validGeoFea = {validGeoFea{:},'gaussianCurvature'};
validGeoFea = {validGeoFea{:},'boundingBox'};
validGeoFea = {validGeoFea{:},'outlierCount'};
validGeoFea = {validGeoFea{:},'abovePreference'};
validGeoFea = {validGeoFea{:},'ztitleAngle'};
validGeoFea = {validGeoFea{:},'ballCoord'};


% validGeoFea = {
%     'maxDepth',...
%     'visSurfaceArea',...
%     'depthDistribute',...
%     'projectArea',...
%     'viewPointEntropy',...
%     'silhouetteLength',...
%     'silhouetteCurvature',...
%     'silhouetteCurvatureExtrema',...
%     'meanCurvature',...
%     'gaussianCurvature',...
%     'boundingBox',...    
%     'outlierCount',...
%     'abovePreference',...
%     'ztitleAngle',...
%     'ballCoord'
%     };


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
