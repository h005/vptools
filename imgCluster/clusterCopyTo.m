%% copy each cluster imgs into one folder named as clusterID
function clusterCopyTo(imgDir,clusterDir,fileName,cluster)
% imgDir contains img files listed in fileName
% clusterDir is the dest folder which will contain clusters named with
% clueterID
num = max(cluster);
for i=1:num
    ind = find(cluster == i);
    if exist([clusterDir '/' num2str(i)]) == 7
        rmdir([clusterDir '/' num2str(i)],'s');        
    end
    mkdir([clusterDir '/' num2str(i)]);
    % copy files into it
    for j=1:length(ind)
        copyfile([imgDir '/' fileName{ind(j)}],[clusterDir '/' num2str(i) '/']);
    end
end