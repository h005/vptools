%% this file was the clustering start file
clear
clc
modelList = {
    %     'bigben',... % 1
    %     'kxm',... % 2
%     'notredame',... % 3
%     'freeGodness',... % 4
%     'BrandenburgGate',... % 7
%     'BuckinghamPalace'    % 15
    %     'BritishMuseum',... % 8
    %     'potalaPalace',... % 9
    %     'capitol',... % 10
    %     'Sacre',... % 11
    %     'TengwangPavilion',... % 12
    %     'mont',... % 13
    %     'HelsinkiCathedral',... % 14
    %     'tajMahal',... % 5
    %     'cctv3',... % 6
    
    };

% for i = 1:numel(modelList)
%     mvDist(modelList{i})
% end
model = {'kxm'};
mvDist(model{1});