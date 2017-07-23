%% this scripte was created to clear .vnf .2dvnf .2dvnfname files
% clearpath1 '/home/h005/Documents/vpDataSet/tools/vpData/model/vpFea/model.suffix'
% clearpath2 '/home/h005/Documents/vpDataSet/model/vpFea/model.suffix'

function clearFiles(modelList,suffix)

for i=1:numel(modelList)
    for j = 1:numel(suffix)
        clearpath1 = ['../vpData/' modelList{i} '/vpFea/' modelList{i} suffix{j}];
        clearpath2 = ['../../' modelList{i} '/vpFea/' modelList{i} suffix{j}];
        
        if exist(clearpath1,'file') == 2
            delete(clearpath1);
        end
        if exist(clearpath2,'file') == 2
            delete(clearpath2);
        end
        
    end
end




end