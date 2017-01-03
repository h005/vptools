%% this function was created to compute F1 score of the binary classification
% gt is ground truth
% pl is predict label
% ln is name of each attribtue
% cl is class names
function [f1,ln] = f1Score(gt,pl,ln,cl)

f1 = zeros(size(gt,1),1);

for i=1:size(gt,1)
    gtTmp = gt(i,:);
    plTmp = pl(i,:);
    p = plTmp == cl;
    n = ~p;
    
    gTrue = gtTmp == cl;
    gFalse = ~gTrue;
    
    tp = p & gTrue;
    fn = gTrue & n;
    fp = gFalse & p;
    tn = gFalse & n;
    
    f1(i) = 2 * tp / (2 * tp + fp + fn);
    disp(['standard '  ln{i} '&' num2str(round(f1(i),3))])
end

[fsorted,index] = sort(f1,'descend');

for i=1:numel(f1)
    disp([ln{index(i)} '&' num2str(round(f1(index(i)),3))])
end

