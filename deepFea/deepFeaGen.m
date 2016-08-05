%% this script was created to generate deep features
function deepFeaGen(model,fileList,feaList)
deepFea = ['/home/h005/Documents/vpDataSet/' model '/vpFea/' model '.dpf'];
fid = fopen(deepFea,'a+');
for i=1:numel(fileList)
    fprintf(fid,'%s\n',fileList{i});
    fprintf(fid,'%f ',feaList{i});
    fprintf(fid,'\n');
end