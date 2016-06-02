%% show off model
%% this function load a .off model file and return 
% points with color
function [pt, face, color] = showOff(file)

fid = fopen(file,'r');
ind = 0;
% read in head
tline = fgetl(fid);
if strcmp(tline,'COFF')
    tline = fgetl(fid);
    vfinfo = strread(tline);
    pt = zeros(vfinfo(1),3);
    % RGB
    color = zeros(vfinfo(1),3);
    % all are triangle
    face = zeros(vfinfo(2),3);
        
elseif strcmp(tline,'OFF')
    color = [];    
end

while 1
    tline = fgetl(fid);
    if tline == -1
        break;
    elseif ind == vfinfo(1)
        break;
    end
    ind = ind + 1;
    tline = strtrim(tline);
    % vc vertex and color  
    vc = strread(tline);
    pt(ind,:) = vc(1:3);
    color(ind,:) = vc(4:6);
end

ind = 0;
while 1
    tline = fgetl(fid);
    if tline == -1
        break;
    end
    ind = ind + 1;
    tline = strtrim(tline);
    % face
    fa = strread(tline);
    face(ind,:) = fa(2:4) + 1;
end
face = face(1:end-1,:);


