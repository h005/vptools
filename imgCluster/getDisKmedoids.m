function dis = getDisKmedoids(mv1,mv2)
ncases = size(mv2,1);
dis = zeros(ncases,1);
A = reshape(mv1,4,4);
for i=1:ncases
    B = reshape(mv2(i,:),4,4);
    dis(i) = mvDis(A,B);
end