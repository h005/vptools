%% combine fea and score
% fea2D, sc
% fea3D, sc
% fea2D, fea3D, sc
function [fs,fname] = combine(varargin)

% get intersection
fea1 = varargin{1};
sc = varargin{end};

feaName = cell(size(fea1));
for i=1:length(fea1)
    feaName{i} = fea1{i}.fname;
end

scName = cell(size(sc));
for i=1:length(sc)
    scName{i} = sc{i}.fname;
end

[fname,Ifea,Isc] = intersect(feaName,scName);
ncases = length(fname);

if nargin == 2
    % initial
    len = length(fea1{1}.fs);
    lenSc = length(sc{1}.fs);
    fs = zeros(ncases,len + lenSc);
    % fill in data
    for i=1:ncases
        fs(i,1:len) = fea1{Ifea(i)}.fs;
        fs(i,len+1:end) = sc{Isc(i)}.fs;
    end
elseif nargin == 3
    % initial
    fea2 = varargin{2};
    len1 = length(fea1{1}.fs);
    len2 = length(fea2{2}.fs);
    lenSc = length(sc{1}.fs);
    fs = zeros(ncases,len1 + len2 + lenSc);
    % fill in data
    for i=1:ncases
        fs(i,1:len1) = fea1{Ifea(i)}.fs;
        fs(i,len1+1:len1+len2) = fea2{Ifea(i)}.fs;
        fs(i,len1+len2+1:end) = sc{Isc(i)}.fs;
    end
end
