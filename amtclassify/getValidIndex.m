%% this script was created for select the valid feature
% index for amtErrorRateBar.m file

% validFea is a cell array contains the features' name
% fileFname is the .vnfname file or the .3dfname

function validIndex = getValidIndex(validFea,fileFname)

% read in the fileFname
fid = fopen(fileFname,'r');
index = 1;
while 1
    tline = fgetl(fid);
    if tline == -1
        break;
    end
    tline = strtrim(tline);
    feaName{index} = tline;
    index = index + 1;
end

validIndex = [];
index = 0;
for i = 1:numel(validFea)
    for j=1:numel(feaName)
        if strcmp(feaName{j},validFea{i})
           index = index + 1;
           validIndex(index) = j;
        end
    end
end