function ind = getPart(index,step,ith)
if ith * step > length(index)
    ind = [];
elseif ith * step + step > length(index)
    ind = index(ith * step - step + 1 : end);
else
    ind = index(int32(ith * step - step + 1) : int32(ith * step));
end

