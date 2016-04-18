%% 3DfeatureCheck debug
clear
clc
% indices = load('../kxm/vpFea/indices.txt');
% 
% cases = size(indices,1);
% for i=1:cases
%     for j=i+1:cases
%         c = setxor(indices(i,:),indices(j,:));
%         if isempty(c)
%             disp([num2str(i) ' ' num2str(j)]);
%         end
%     end
% end

% fea2d = load('../kxm/imgs/model/kxmmodel.2df');
% fea2d_ = load('../kxm/vpFea/kxmmodel.2df');

% rev = load('/home/h005/Documents/vpDataSet/kxm/vpFea/indices.rev');
% uf = load('/home/h005/Documents/vpDataSet/kxm/vpFea/indices.uf');
% res = rev - uf;
% len = size(rev,1) * size(rev,2);
% tmpres = reshape(res',len,1);
% diff = find(tmpres~=0)

ufid = load('/home/h005/Documents/vpDataSet/kxm/vpFea/uf.id');
revid = load('/home/h005/Documents/vpDataSet/kxm/vpFea/reverse.id');

res = ufid - revid;
diff = find(res~=0)
