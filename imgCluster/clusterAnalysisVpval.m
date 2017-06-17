%% analysis cluster result by score
clear
clc
% addpath ./vpval/
addpath ../amtclassify/

model = {'kxm'};

% read in .cluster file
clusterFile = '../../kxm/model/kxmPt.cluster';
% read in score of each picture of one model
modelList = {
    'bigben',...
    'kxm',...
    'notredame',...
    'freeGodness',...
    'tajMahal',...
    'cctv3',...
    'capitol',...
    'Sacre',...
    'TengwangPavilion',...
    'mont',...
    'HelsinkiCathedral',...
    'BuckinghamPalace',...
    'BritishMuseum',...
    'BrandenburgGate',...
    'potalaPalace'
    };

% read in .cluster file
[picInfo, centerInfo] = clusterReaderVpval(clusterFile,model{1});

imgScore = imgScoreLoadVpval(modelList,model{1});

%% generate image cluster list here
inc = 0;
for j=1:numel(picInfo)
    for i=1:numel(imgScore)
%         if inc == 380
%             debug = 1;
%         end
        if strcmp(imgScore{i}.fn,picInfo{j}.fn)
            inc = inc+1;
            imgList{inc}.fn = imgScore{i}.fn;
            imgList{inc}.score = imgScore{i}.score;
            imgList{inc}.cId = picInfo{j}.cId;
            break;
        end
    end
end

%% variance and num(cluster)
numCluster = cell(numel(centerInfo),1);
scoreCluster = cell(numel(centerInfo),1);
% for i=1:numel(centerInfo)
%     numCluster{i} = [];
% end
% varCluster = zeros(numel(centerInfo),1);
for j=1:numel(centerInfo)
    for i=1:numel(imgList)
        if imgList{i}.cId == j
            numCluster{j} = [numCluster{j},i];
            scoreCluster{j} = [scoreCluster{j}, imgList{i}.score];
        end
    end
end

meanVal = zeros(numel(scoreCluster),1);
varVal = zeros(numel(scoreCluster),1);
varNum = zeros(numel(scoreCluster),1);
for i=1:numel(scoreCluster)
    meanVal(i) = mean(scoreCluster{i});
    varNum(i) = numel(scoreCluster{i});
    varVal(i) = var(scoreCluster{i}) * (numel(scoreCluster{i})-1) / numel(scoreCluster{i});    
end