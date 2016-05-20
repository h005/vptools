%% this function was built to plot roc curve
% method is one of {'ROC','PR','ROC PR'}
% groundTruth is the groundTruth label of each case
% score is the score to a given label.
% scoreLabel is the label that score descripted by classifer
% fN is the legend name on your curve

function classifyPlotHelper(groundTruth,score,scoreLabel,fN,method,titleLabel)

plotMarker = {'o','+','*','.','x','s','d','^','v','>','<','p','h','o','+','*','.','x','s','d','^','v','>','<','p','h'};

if strcmp(method,'ROC')
    rocPlotHelper(groundTruth,score,scoreLabel,fN,titleLabel,plotMarker);
elseif strcmp(method,'PR')
    prPlotHelper(groundTruth,score,scoreLabel,fN,titleLabel,plotMarker);
elseif strcmp(method,'ROC PR')
    rocPlotHelper(groundTruth,score,scoreLabel,fN,titleLabel,plotMarker);
    prPlotHelper(groundTruth,score,scoreLabel,fN,titleLabel,plotMarker);
end
end
function rocPlotHelper(groundTruth,score,scoreLabel,fN,titleLabel,plotMarker)
X = cell(numel(fN),1);
Y = cell(numel(fN),1);
for i=1:numel(fN)
    [tmpx,tmpy,tmpt,tmpauc] = ...
        perfcurve(groundTruth(i,:),score(i,:),scoreLabel);
    X{i} = tmpx;
    Y{i} = tmpy;
end
figure
plot(X{1},Y{1},'Marker',plotMarker{1});
hold on
for i=2:length(fN)
    plot(X{i},Y{i},'Marker',plotMarker{i});
end
legend(fN,'Location','best');
xlabel('False positive rate');
ylabel('True positive rate');
title(titleLabel,'FontWeight','normal');
hold off
end

function prPlotHelper(groundTruth,score,scoreLabel,fN,titleLabel,plotMarker)
X = cell(numel(fN),1);
Y = cell(numel(fN),1);

for i=1:numel(fN)
    [prec, tpr, fpr, thresh] = ...
        prec_rec(score(i,:), groundTruth(i,:), 'plotROC',0,'plotPR',0);
    X{i} = tpr;
    Y{i} = prec;
end
figure
plot(X{1},Y{1},'Marker',plotMarker{1});
hold on;
for i=2:numel(fN)
    plot(X{i},Y{i},'Marker',plotMarker{i});
end
legend(fN,'Location','best');
xlabel('recall');
ylabel('precision');
title(titleLabel,'FontWeight','normal');
hold off
end