%% plot classify error rate
function plotErrorRate(gt, pl, fN, titleText)
% ref http://slidewiki.org/slide/24197
% gt ground truth
    % nFeatures * mItem
% pl predict label
    % nFeatures * mItem
% fN used for legend
    % nFeatures with names
[nFeatures,mItem] = size(gt);
errRate = zeros(nFeatures,1);
for i=1:nFeatures
    % compute error rate
    errRate(i) = sum(gt(i,:) == pl(i,:));
end
errRate = errRate / mItem;
errRate = 1 - errRate;
% ref http://cn.mathworks.com/matlabcentral/answers/20860-how-to-use-colormap-for-different-bars
fHand = figure;
aHand = axes('parent',fHand);
hold(aHand,'on');
colors = hsv(numel(errRate));
for i=1:numel(errRate)
    bar(i,errRate(i),'parent',aHand,'facecolor',colors(i,:));
end
set(gca, 'XTick', 1:numel(errRate), 'XTickLabel', fN)
legend(fN);
ylabel('Error Rate');
title(titleText,'FontWeight','normal')
axis([0.5,3.5,0,0.5])