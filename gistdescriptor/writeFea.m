%% this script was created to write vanish line features to files
function writeFea(model,fileList,feaList,suffix)
gistFea = ['/home/h005/Documents/vpDataSet/' model '/vpFea/' model suffix];
fid = fopen(gistFea,'a+');
for i=1:numel(fileList)
    fprintf(fid,'%s\n',fileList{i});
    fprintf(fid,'%f ',feaList{i});
    fprintf(fid,'\n');
end
fclose(fid);

gistFea = ['/home/h005/Documents/vpDataSet/tools/vpData/' model '/vpFea/' model suffix];
fid = fopen(gistFea,'a+');
for i=1:numel(fileList)
    fprintf(fid,'%s\n',fileList{i});
    fprintf(fid,'%f ',feaList{i});
    fprintf(fid,'\n');
end
fclose(fid);
