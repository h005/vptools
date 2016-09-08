%% this script was created to write vanish line features to files
function writeFea(model,fileList,feaList)
vnfFea = ['/home/h005/Documents/vpDataSet/' model '/vpFea/' model '.vnf'];
fid = fopen(vnfFea,'a+');
for i=1:numel(fileList)
    fprintf(fid,'%s\n',fileList{i});
    fprintf(fid,'%f ',feaList{i});
    fprintf(fid,'\n');
end
fclose(fid);

vnfFea = ['/home/h005/Documents/vpDataSet/tools/vpData/' model '/vpFea/' model '.vnf'];
fid = fopen(vnfFea,'a+');
for i=1:numel(fileList)
    fprintf(fid,'%s\n',fileList{i});
    fprintf(fid,'%f ',feaList{i});
    fprintf(fid,'\n');
end
fclose(fid);
