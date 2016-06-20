%% used for gmm

function [idx] = gmmClassify(data,k)
% data is naces * nfeatures
% k is the number of cluster
gmmModel = fitgmdist(data,k,'Start','plus');
 
idx = cluster(data,gmmModel);
