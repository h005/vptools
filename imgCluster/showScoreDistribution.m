%% show score distribution info
function showScoreDistribution(scoreData,cluster,plotNum)
% scoreData, all entities score
% cluster, for all entities cluster belongs
% plotNum, a set for all clusters that will show
%% all figures output was 2*3 grid used by subplot
num = numel(plotNum);
% nf is the number of figures
nf = 0;
% fc is a counter in one figure
fc = 0;
for i=1:num
    % cset means clusterSet
    cset = find(cluster == plotNum(i));
    if numel(cset) == 1
        continue;
    else
        if rem(fc,6) == 0
            nf = nf + 1;
            figure(nf)
            fc = 0;
        end
        fc = fc + 1;
        subplot(2,3,fc);
        histogram(scoreData(cset),'Normalization','count');
        title(['cluster ' num2str(plotNum(i))])
    end
end

