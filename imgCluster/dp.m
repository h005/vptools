%% debug for position

plotMarker = {'o','+','*','.','x','s','d','^','v','>','<','p','h','o','+','*','.','x','s','d','^','v','>','<','p','h','o','+','*','.','x','s','d','^','v','>','<','p','h','o','+','*','.','x','s','d','^','v','>','<','p','h','o','+','*','.','x','s','d','^','v','>','<','p','h','o','+','*','.','x','s','d','^','v','>','<','p','h','o','+','*','.','x','s','d','^','v','>','<','p','h','o','+','*','.','x','s','d','^','v','>','<','p','h'};
figure
hold on

pos = find(strcmp(fileName,'./img0082.jpg') == 1);
psx = ps(:,1);
psy = ps(:,2);
psz = ps(:,3);

plot3(psx(pos),psy(pos),psz(pos),...
    'LineStyle','none',...    
    'Marker',plotMarker{1},...
    'MarkerSize',30);

pos = find(strcmp(fileName,'./img0102.jpg') == 1);
psx = ps(:,1);
psy = ps(:,2);
psz = ps(:,3);

plot3(psx(pos),psy(pos),psz(pos),...
    'LineStyle','none',...    
    'Marker',plotMarker{1},...
    'MarkerSize',30);

pos = find(strcmp(fileName,'./img0260.jpg') == 1);
psx = ps(:,1);
psy = ps(:,2);
psz = ps(:,3);

plot3(psx(pos),psy(pos),psz(pos),...
    'LineStyle','none',...    
    'Marker',plotMarker{1},...
    'MarkerSize',30);

pos = find(strcmp(fileName,'./img0507.jpg') == 1);
psx = ps(:,1);
psy = ps(:,2);
psz = ps(:,3);

plot3(psx(pos),psy(pos),psz(pos),...
    'LineStyle','none',...    
    'Marker',plotMarker{1},...
    'MarkerSize',30);

pos = find(strcmp(fileName,'./img0572.jpg') == 1);
psx = ps(:,1);
psy = ps(:,2);
psz = ps(:,3);

plot3(psx(pos),psy(pos),psz(pos),...
    'LineStyle','none',...    
    'Marker',plotMarker{1},...
    'MarkerSize',30);

pos = find(strcmp(fileName,'./img0587.jpg') == 1);
psx = ps(:,1);
psy = ps(:,2);
psz = ps(:,3);

plot3(psx(pos),psy(pos),psz(pos),...
    'LineStyle','none',...    
    'Marker',plotMarker{1},...
    'MarkerSize',30);

pos = find(strcmp(fileName,'./img0650.jpg') == 1);
psx = ps(:,1);
psy = ps(:,2);
psz = ps(:,3);

plot3(psx(pos),psy(pos),psz(pos),...
    'LineStyle','none',...    
    'Marker',plotMarker{1},...
    'MarkerSize',30);

pos = find(strcmp(fileName,'./img0702.jpg') == 1);
psx = ps(:,1);
psy = ps(:,2);
psz = ps(:,3);

plot3(psx(pos),psy(pos),psz(pos),...
    'LineStyle','none',...    
    'Marker',plotMarker{1},...
    'MarkerSize',30);

plot3(0,0,0,'s','MarkerSize',25,...
    'LineStyle','none');

