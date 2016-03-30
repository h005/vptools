%% extract camera position, center direction and up direction
function [ps,cad,upd] = extractCameraInfo(mv)
% mv is ncases * 4 * 4 matrix
% ps position ncases * 3
% cad center direction ncases * 3
% upd up direction ncases * 3

ncases = size(mv,1);
ps = zeros(ncases,3);
cad = zeros(ncases,3);
upd = zeros(ncases,3);

for i=1:ncases
    rotate = mv(i,1:3,1:3);
    rotate = reshape(rotate,3,3);
    trans = mv(i,1:3,4);
    trans = reshape(trans,3,1);
    % camera towards inverse z axis so [0,0,-1]
    zvec = [0,0,-1];
    yvec = [0,1,0];
    ps(i,:) = - trans' * rotate;
    cad(i,:) = zvec * rotate;
    % center dircetion was a line pass the camera position point
    % cad(i,:) = cad(i,:) / norm(cad(i,:)) + ps(i,:);
    cad(i,:) = cad(i,:) / norm(cad(i,:));
    upd(i,:) = yvec * rotate;
    upd(i,:) = upd(i,:) / norm(upd(i,:));
end
