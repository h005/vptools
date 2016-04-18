%% show diff between score and predict score
function showErrInfo(titleText,score,predictScore,text,row,col,id)
%% plot
titleText = [titleText ' '];
subplot(row,col,id)
xaxis = 1:size(score,2);

diff = score - predictScore;
plot(xaxis,diff,'r')

axis([0,length(diff),-5,5])

title([titleText,text,' diff'])