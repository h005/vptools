%% this script was created to write vanish line features to files
function writeFea(model,fileList,feaList,suffix)
gistFea = ['../../' model '/vpFea/' model suffix];
fid = fopen(gistFea,'a+');
for i=1:numel(fileList)
    fprintf(fid,'%s\n',fileList{i});
    fprintf(fid,'%f ',feaList{i});
    fprintf(fid,'\n');
end
fclose(fid);

gistFea = ['../vpData/' model '/vpFea/' model suffix];
fid = fopen(gistFea,'a+');
for i=1:numel(fileList)
    fprintf(fid,'%s\n',fileList{i});
    fprintf(fid,'%f ',feaList{i});
    fprintf(fid,'\n');
end
fclose(fid);
