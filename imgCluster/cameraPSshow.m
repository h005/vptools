%% Camera position shows
function cameraPSshow(ps,cluster,modelName)

clusters = unique(cluster);
% one more color for the building
colors = hsv(numel(clusters)+1);

plotMarker = {'o','+','*','.','x','s','d','^','v','>','<','p','h','o','+','*','.','x','s','d','^','v','>','<','p','h'};

psx = ps(:,1);
psy = ps(:,2);
psz = ps(:,3);

figure
hold on
for i=1:numel(clusters)
    id = cluster == clusters(i);
    plot3(psx(id),psy(id),psz(id),...
    'LineStyle','none',...    
    'Marker',plotMarker{i},...
    'MarkerSize',16,...
    'MarkerFaceColor',colors(i+1,:));
end
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')
plot3(0,0,0,'s','MarkerSize',25,...
    'LineStyle','none',...
    'MarkerFaceColor',colors(1,:));
hold off
% grid on
text(0,0,0,modelName);
