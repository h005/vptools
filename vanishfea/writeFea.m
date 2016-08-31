%% this script was created to write vanish line features to files
function deepFeaGen(model,fileList,feaList)
deepFea = ['/home/h005/Documents/vpDataSet/' model '/vpFea/' model '.vnf'];
fid = fopen(deepFea,'a+');
for i=1:numel(fileList)
    fprintf(fid,'%s\n',fileList{i});
    fprintf(fid,'%f ',feaList{i});
    fprintf(fid,'\n');
end