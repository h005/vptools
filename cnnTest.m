%% cnn test
svmRegress;
net = fitnet(30);
net.performFcn = 'mse';
net.performParam.regularization = 0.01;
net.trainFcn = 'trainscg';
net = train(net,trainData,score);
% view(net)
t = net(trainData);
perf = perform(net,score,t);

%% plot
xaxis = 1:size(score,2);
figure
plot(xaxis,score,'r');
hold on
plot(xaxis,t,'g');
title(['cnn mse:',num2str(perf)])
