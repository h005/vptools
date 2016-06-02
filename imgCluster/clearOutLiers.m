%% this function was created to clear outliers
function validIndex = clearOutLiers(ps)
validIndex = [];
dis = zeros(size(ps,1),1);
for i=1:size(ps,1)
    dis(i) = norm(ps(i,:));
end
[N,edges] = histcounts(dis);
rMax = edges(end);
total = sum(N);
acc = 0;

for i = 1 : N
    if acc / total > 0.8
        rMax = edges(i);
        break;
    end
    acc = N(i) + acc;  
end

for i=1:size(ps,1)
    if dis(i) < rMax 
        validIndex = [validIndex, i];
    end
end
