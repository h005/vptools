%% analysis viewpoint preference by numerical
%{
/*
* @Author: h005
* @Date:   2017-01-05 14:59:01
* @Last Modified by:   h005
* @Last Modified time: 2017-01-05 16:37:40
*/
%}

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
% model = {'BrandenburgGate'};
% read in .cluster file
[picInfo, centerInfo] = clusterReaderVpval(clusterFile,model{1});
% load in pos images
% last paramenter in the function of posNegImgsLoadVpval is the filter paramenter
% if it set as the model in the modelList then only the pictures about this model will be return
% otherwise, return all the model
[posImgs, negImgs] = posNegImgsLoadVpval(modelList,rate,model{1});

% 
for i = 1:numel(posImgs)
    disp(posImgs{i})
end

for i=1:numel(negImgs)
    disp(negImgs{i})
end

for i=1:numel(centerInfo)
	[imgList,pImgList,rate,num,total] = showClusterImgsVpval(picInfo, i, posImgs);
	disp([num2str(i) ' ' num2str(rate), ' -num ' num2str(num) ' / ' num2str(total)])
end
