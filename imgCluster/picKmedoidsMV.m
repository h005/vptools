%% k-medoids cluster imgs metric distance by mv matrix
function [idx,C] = picKmedoidsMV(mv)
% mv matrix is a matrix with ncases * 4 * 4
% pmv matrix is a matrix with ncases * 16;
pmv = convertmv(mv);
% kmedoids
% row of Data correspond to obervations
% col of Data correspond to variables
nClusters = 15;
[idx,C] = kmedoids(pmv,nClusters,'Distance',@getDisKmedoids);


function pmv = convertmv(mv)
%% convert ncases * 4 * 4 to ncases * 16
ncases = size(mv,1);
pmv = zeros(ncases,16);
for i=1:ncases
    tmp = reshape(mv(i,:,:),16,1);
    pmv(i,:) = tmp;
end
