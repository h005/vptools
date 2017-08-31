%% compare without some features
%{
% errRate = [0.3270    0.2990    0.2980
%     0.2580    0.2090    0.1980
%     0.2060    0.1840    0.1550];
% methodN = {'Bayes','Ens','SVM-2K'};
svm2kErrorRate = [0.2595,0.1866,0.1687];
svm2kErrorRate_Contrast = [0.267,0.193,0.185];
svm2kErrorRate_Hue = [0.262,0.194,0.185];
svm2kErrorRate_Color = [0.261,0.19, 0.175];
svm2kErrorRate_Blur = [0.263,0.206,0.17];

errRate = [svm2kErrorRate;
    svm2kErrorRate_Contrast;
    svm2kErrorRate_Hue;
    svm2kErrorRate_Color;
    svm2kErrorRate_Blur];

methodN = {'Original','Original - Contrast','Original - Saturation','Original - Color','Original - Blur'};
fN = {'2D','3D','2D&3D'};
fHand = figure(1);
aHand = axes('parent',fHand);
hold(aHand,'on');
bar(errRate);
% colors = hsv(numel(errRate));
% for i=1:numel(errRate)
%     bar(i,errRate(i),'parent',aHand,'facecolor',colors(i,:));
% end
set(gca, 'XTick', 1:numel(errRate), 'XTickLabel', methodN,'FontSize',20,'FontName','Arial')
ylabel('Error Rate');
% titleText = 'Comparison performance with the removing features of SVM-2K';
% title(titleText,'FontWeight','normal')
axis([0.5,5.5,0,0.4])
legend(fN,'Location','best');
%}

svm2kErrorRate = [0.2595,0.1866,0.1687];
svm2kErrorRate_Contrast = [0.267,0.193,0.185];
svm2kErrorRate_Contrast_Hue = [0.27       0.193       0.185];
% svm2kErrorRate_Contrast_Hue_Color = [0.327       0.191       0.219];
svm2kErrorRate_Contrast_Hue_Blur = [0.321       0.189       0.207];
svm2kErrorRate_Contrast_Hue_Blur_Color = [0.324       0.196       0.211];
svm2kErrorRateNew = [0.198 0.191 0.160];
errRate = [svm2kErrorRate;
    svm2kErrorRate_Contrast;
    svm2kErrorRate_Contrast_Hue;
    svm2kErrorRate_Contrast_Hue_Blur;
    svm2kErrorRate_Contrast_Hue_Blur_Color;
    svm2kErrorRateNew];

methodN = {'F1=Original','F2=F1-Contrast','F3=F2-Saturation','F4=F3-Blur','F5=F4-Color','F6=F5+new'};
fN = {'2D','3D','2D&3D'};
fHand = figure(1);
aHand = axes('parent',fHand);
hold(aHand,'on');
bar(errRate);
% colors = hsv(numel(errRate));
% for i=1:numel(errRate)
%     bar(i,errRate(i),'parent',aHand,'facecolor',colors(i,:));
% end
set(gca, 'XTick', 1:numel(errRate), 'XTickLabel', methodN,'FontSize',20,'FontName','Arial')
ylabel('Error Rate');
% titleText = 'Comparison performance with the removing features of SVM-2K';
% title(titleText,'FontWeight','normal')
axis([0.5,6.5,0,0.4])
legend(fN,'Location','best');
%}

for i = 1 : size(errRate,1)
    for j = 1:size(errRate,2)
        text(i-0.45+ j* 0.225,errRate(i,j),num2str(errRate(i,j),'%.3f'),...
        'HorizontalAlignment','center',...
        'VerticalAlignment','bottom','FontSize',15,'FontName','Arial');
    end
end