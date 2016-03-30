function showInfo(titleText,score,predictScore,text,row,col,id)
%% plot
titleText = [titleText ' '];
subplot(row,col,id)
xaxis = 1:size(score,2);
plot(xaxis,score,'r')
hold on
plot(xaxis,predictScore,'g')
mse = (score - predictScore) * (score - predictScore)' / length(score);
title([titleText,text,' mse: ',num2str(mse)])