%%
% fs: fea + sc; ncases * mfea
% feaName: feature's name with its index in s
% rate: top rate will be labeled as positve
%       last rate will be labeled as negative
% fname: file name, ie image's names

function calssifyEach(fs,feaName,rate,fname,method)
sc = fs(:,end);
% sort sc asscend
[sortedSc,index] = sort(sc);
[ncases, mfeatures] = size(fs,1);
num = round(ncases*rate);
negIdx = index(1:num);
posIdx = index(end - num + 1 : end);

% construct new calssify data
for i=1:length(feaName)
    ind = feaName{i}.ind;
    % single fea score
    sfs = zeros(2*num,length(ind)+1);
    sfs(1:num,1:length(ind)) = fs(negIdx,ind);
    sfs(1:num,end) = -1;
    sfs(num+1:2*num,1:length(ind)) = fs(posIdx,ind);
    sfs(num+1:2*num,end) = 1;
end

if strcmp(method,'bayes classify')

elseif strcmp(method,'svm classify')
    
end


