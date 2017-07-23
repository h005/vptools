%% filename load
% this function was created to load photos' filename of each model
% model is a string
% fileList is a cell array contains filename
function fileList = fileLoad(sceneName)
% just analysis fea2D file is ok
fea2Dfile = ['../vpData/' sceneName '/vpFea/' sceneName '.2df'];
fileList = feaload(fea2Dfile,sceneName);

end
function fileList = feaload(fname,sceneName)
fid = fopen(fname,'r');
ind = 0;
while 1
    tline = fgetl(fid);
    if tline == -1;
        break;
    end
    tline = strtrim(tline);
    if strcmp(tline,'')
        continue;
    end
    ind = ind + 1;
    % load basename
    [pathstr,name,ext] = fileparts(tline);
    % add this as prefix
    prefix = '/home/hejw005/Documents/vpDataSet/';
    fileList{ind} = [prefix sceneName '/imgs/' name ext];
    tline = fgetl(fid);
end
end
