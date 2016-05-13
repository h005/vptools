function feaName = loadFeaName(file)
fid = fopen(file,'r');
ind = 0;
ord = 0;
feaName = {};
name = {};
while 1
    tline = fgetl(fid);
    if tline == -1
        break;
    end
    
    tline = strtrim(tline);
    ind = ind + 1;
    exist = strcmp(name,tline);
    if sum(exist)
        index = find(exist == 1);
        feaName{index}.ind = [feaName{index}.ind ind];
    else
        ord = ord + 1;
        feaName{ord}.name = tline;
        feaName{ord}.ind = ind;
        name{ord} = tline;
    end
end
