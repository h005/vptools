%% this file was created to load the posImages and negImages
%{
/*
* @Author: h005
* @Date:   2017-01-05 15:35:27
* @Last Modified by:   h005
* @Last Modified time: 2017-01-05 16:09:42
*/
%}

function [posList,negList] = posNegImgsLoadVpval(modelList,rate,model)
% load in feature and score
[sc,scr,fea2d,fea3d] = dataLoad(modelList);
% combine feature and score stored in fs
[fs2d, myFname] = combine(fea2d,scr);

score = fs2d(:,end);

[scored,index] = sort(score);

ncases = numel(score);

num = round(ncases * rate);

negIdx = index(1:num);
posIdx = index(end - num + 1 : end);

flag = inModelList(modelList, model);
if flag == 0
	% allocate space for posList and negLilst
	posList = cell(1,num);
	negList = cell(1,num);
	for i=1:num
        posList{i} = myFname{posIdx(i)};
        negList{i} = myFname{negIdx(i)};
	end
else
	pInc = 0;
	nInc = 0;
	for i=1:num
        % read model name of each pos image
        [pathstr, name, ext] = fileparts(myFname{posIdx(i)});
        % pathstr is the model name
		if strcmp(model, pathstr)
			pInc = pInc + 1;
			posList{pInc} = myFname{posIdx(i)};
		end
		% read model naem of each neg image
		[pathstr, name, ext] = fileparts(myFname{negIdx(i)});
		% pathstr is the model name
		if strcmp(model,pathstr)
			nInc = nInc + 1;
			negList{nInc} = myFname{negIdx(i)};
		end
	end
end



end

function flag = inModelList(modelList, model)
	% flag == 0 means does not included
	% flag == 1 means exists
	flag = 0;
	for i=1:numel(modelList)
		if strcmp(modelList{i}, model)
			flag = 1;
			return;
		end
	end
end