%% this script was created to load sift data
function fea = siftLoader(fileList)
% sift mat was created by siftExtracter.m
% what we load is a matrix d mfeaturs * ncases
fea = [];
for i=1:numel(fileList)
    load(fileList{i})                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
%     d = single(d);
    fea = [fea,d];
    if rem(i,1000) == 0
        disp(['load ' num2str(i) ' done']);
    end
end