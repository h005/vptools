%% plot classify error rate Group
function plotErrorRateGroup(gt, pl, fN, methodN, titleText)
% ref http://slidewiki.org/slide/24197
%     Classifier Accuracy, or recognition rate: percentage of test set tuples that are correctly classified
%     Accuracy = (TP + TN)/All
%     Error rate: 1 – accuracy, or
%     Error rate = (FP + FN)/All
% gt ground truth
    % nFeatures * mItem
% pl predict label
    % nFeatures * mItem
% fN used for legend
    % nFeatures with names
mMethods = numel(gt);
[nFeatures,mItem] = size(gt{1});
errRate = zeros(mMethods,nFeatures);

for i=1:mMethods
    for j=1:nFeatures
        % compute error rate
        errRate(i,j) = sum(gt{i}(j,:) == pl{i}(j,:));
%         errRate(i) = sum(gt(i,:) == pl(i,:));
    end
    mItem = size(gt{i},2);
    errRate(i,:) = errRate(i,:) / mItem;
    disp(['error rate of : ' methodN{i} ' ' num2str(1 - errRate(i,:))])
end

errRate = 1 - errRate;



% ref http://cn.mathworks.com/matlabcentral/answers/20860-how-to-use-colormap-for-different-bars
fHand = figure;
aHand = axes('parent',fHand);
hold(aHand,'on');
bar(errRate);
% colors = hsv(numel(errRate));
% for i=1:numel(errRate)
%     bar(i,errRate(i),'parent',aHand,'facecolor',colors(i,:));
% end
set(gca, 'XTick', 1:numel(errRate), 'XTickLabel', methodN)
ylabel('Error Rate');
title(titleText,'FontWeight','normal')
axis([0.5,3.5,0,0.5])
legend(fN,'Location','best');