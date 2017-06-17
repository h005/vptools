%% this script was created to show the imgs list of each cluster as well as the posImgs in this cluster 

%{
/*
* @Author: h005
* @Date:   2017-01-05 16:20:58
* @Last Modified by:   h005
* @Last Modified time: 2017-01-05 16:34:49
*/
%}


% rate = numel(pImgList) / numel(imgList)
function [imgList,pImgList,rate,num0,total] = showClusterImgsVpval(pic, id, posImgs)

index = 0;
imgList = {};
pImgList = {};
rate = 0;
for i = 1 : numel(pic)
	if(pic{i}.cId == id)
		index = index + 1;
		imgList{index} = pic{i}.fn;
	end
end

pImgList = intersect(imgList,posImgs);
rate = numel(pImgList) / numel(imgList);
num0 = numel(pImgList);
total = numel(imgList);
