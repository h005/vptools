%% k-medoids cluster imgs metric distance by mv matrix
function [cluster,label,clusterCenter] = picKmedoidsMV(mv)
% mv matrix is a matrix with ncases * 4 * 4
ncases = size(mv,1);
label = cell(ncases,1);
pmv = convertmv(mv);



