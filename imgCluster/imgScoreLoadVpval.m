%% this file was created to load image scores
% imgScore is a cell array
% and imgScore{i} has score and fn two fileds
function imgScore = imgScoreLoadVpval(modelList,model)
% load in feature and score
[sc,scr,fea2d,fea3d] = dataLoad(modelList);
% combine feature and score stored in fs
[fs2d, myFname] = combine(fea2d,scr);

score = fs2d(:,end);

flag = inModelList(modelList,model);

if flag == 0
    imgScore = cell(1,numel(score));
    for i=1:numel(score)
        imgScore{i}.score = score(i);
        imgScore{i}.fn = myFname{i};
    end
else
    pInc = 0;
    for i=1:numel(score)
        % read model name of each pos image
        [pathstr, name, ext] = fileparts(myFname{i});
        % pathstr is the model name
        if strcmp(model, pathstr)
            pInc = pInc + 1;
            imgScore{pInc}.score = score(i);
            imgScore{pInc}.fn = myFname{i};
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