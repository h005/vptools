%% this script was created for select the photos with high quality
% run this script after run the amtErrorRateBar script
for i = 1 : numel(picName)
    disp([picName{i} ' ' num2str(gt3(i)) ' ' num2str(pl3(i))])
end

model_pl = cell(1,15);
model_gt = cell(1,15);

for i = 1 : numel(picName)
    picNames = strsplit(picName{i},'/');
    
    % get index
    index = 1;
    while index <= numel(modelList)
        if strcmp(modelList{index},picNames{1})
            break;
        end
        index = index + 1;
    end
    
%     [modelList{index}, ' ', picNames{1}]
    
    model_pl{index} = [model_pl{index} pl3(i)];
    model_gt{index} = [model_gt{index} gt3(i)];
    
%     picNames{1}
end

for i = 1:numel(modelList)
%     if i == 13
%         disp('debug')
%     end
    [fpr,fnr,accuracy,recall, precision] = tp_fp_tn_fn(model_pl{i},model_gt{i});
%     [fpr,accuracy,recall, precision] = tp_fp_tn_fn(model_pl{i},model_gt{i});
    fprintf('%s & %.4f & %d\\\\\n',modelList{i},accuracy,numel(model_pl{i}));
%     [modelList{i}, ' ', num2str(recall), ' ', num2str(precision)]
end

