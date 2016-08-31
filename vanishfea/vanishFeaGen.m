%% this function was craeted to compute vansih line featues given filename list
function fea = vanishFeaGen(filelist)

fea = cell(numel(filelist),1);

for i=1:numel(filelist)
        
    disp(filelist{i})
    fea{i} = vanishFea(filelist{i});
    
end