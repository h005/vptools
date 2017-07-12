%% k-medoids cluster imgs metric distance by camera position
function [idx,C] = picKmedoidsP(ps)
% ps matrix is a matrix with ncases * 3, with the x, y, and z
% kmedoids
% row of Data correspond to obervations
% col of Data correspond to variables
nClusters = 9;
[idx,C] = kmedoids(ps,nClusters,'Start','sample');
