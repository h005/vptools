function pmv = convertmv2(mv)
%% convert ncases * 4 * 4 to ncases * 16
ncases = size(mv,1);
pmv = zeros(ncases,16);
for i=1:ncases
    tmp = reshape(mv(i,:,:),16,1);
    pmv(i,:) = tmp;
end