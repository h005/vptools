%% load in
%{
sample input format:

kxm/img0500.jpg
2 3 5 4 2 3 2 1 3 3 1 5 2 4 2 2 4 1 3 4
kxm/img0111.jpg
5 5 3 4 5 4 5 4 5 4 2 4 4 5 3 3 4 2 3 1
kxm/img0439.jpg
5 3 5 5 4 5 4 4 5 4 4 4 5 5 3 3 4 4 5 5
kxm/img0814.jpg
3 4 4 3 4 3 4 5 3 5 3 4 4 4 4 4 4

%}
function sc = scload(fname,sceneName)
fid = fopen(fname,'r');
ind = 0;
while 1
    tline = fgetl(fid);
    if tline == -1
        break;
    end
    ind = ind + 1;
    % just load base name
    [pathstr,name,ext] = fileparts(tline);
    % add this as prefix
    sc{ind}.fname = [sceneName '/' name ext];
    tline = fgetl(fid);
    tline = strtrim(tline);
    score = strread(tline);
    sc{ind}.fs = score;
end
