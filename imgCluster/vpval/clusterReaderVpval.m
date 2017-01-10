%% read in .cluster file

%{
/*
* @Author: h005
* @Date:   2017-01-05 15:06:48
* @Last Modified by:   h005
* @Last Modified time: 2017-01-05 15:27:37
*/	
%}

% file is the .cluster file name
% sceneName was used to as the tag information
function [pic, centerId] = clusterReaderVpval(file,sceneName)

% read in head file
fid = fopen(file,'r');
tline = fgetl(fid);
tline = strtrim(tline);
tmp = strread(tline);
nCluster = tmp(1);
nCases = tmp(2);
index = 0;
% allocate space for pics
pic = cell(1,nCases);
centerId = cell(1,nCluster);
% read in position and cluster info of each image
for i=1:nCases

	% split filename
	tline = fgetl(fid);
	tline = strtrim(tline);
	spaceId = find(tline == ' ');
	fileName = tline(1:spaceId(1));
	[pathstr, name, ext] = fileparts(fileName);
	fileName = [sceneName '/' name ext];
	fileName = strtrim(fileName);
	cId = tline(spaceId(end)+1:end);
	cId = strread(cId);
	tline = tline(spaceId(1)+1:spaceId(end));
	tline = strtrim(tline);
	posInfo = strread(tline);
	index = index+1;
	pic{index}.fn = fileName;
	pic{index}.cId = cId;
	pic{index}.pos = posInfo;
end

index = 0;
for i=1:nCluster
	tline = fgetl(fid);
	tline = strtrim(tline);
	posInfo = strread(tline);
	index = index + 1;
	centerId{index}.pos = posInfo;
end

