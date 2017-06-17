%% this file was created to valid viewpoint preference
%{
1. analysis viewpoint preference by numerical
2. analysis viewpoint preference by cluster graph
%}

addpath ./vpval/
addpath ../amtclassify/

close all
clear
clc
rate = 0.3;

% mode list
%     'bigben',...
%     'kxm',...
%     'notredame',...
%     'freeGodness',...
%     'tajMahal',...
%     'cctv3',...
%     'capitol',...
%     'Sacre',...
%     'TengwangPavilion',...
%     'mont',...
%     'HelsinkiCathedral',...
%     'BuckinghamPalace',...
%     'BritishMuseum',...
%     'BrandenburgGate',...
%     'potalaPalace'



model = {'kxm'};



numericalVpval;


% 1 0.6
% 2 0.63636
% 3 0.44444
% 4 0.38462
% 5 0.61111
% 6 0.77778

% 1 0.73913 -num 17 / 23
% 2 0.44444 -num 4 / 9
% 3 0.69231 -num 9 / 13
% 4 0.63636 -num 14 / 22
% 5 0.25 -num 2 / 8
% 6 0.66667 -num 4 / 6
% 7 0.71429 -num 5 / 7
% 8 0.55556 -num 10 / 18
% 9 0.38462 -num 5 / 13
