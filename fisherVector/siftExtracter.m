%% this script was created to extract sift features
% test code
% imagePath = '/media/h005/659fdcc2-512a-4aa8-b47e-82111d85a019/h005/vpDataSet/bigben/imgs/img0001.jpg';
% image = imread(imagePath);
% image = single(rgb2gray(image));
% [f,d] = vl_sift(image);

% 读取某个路径下的所有文件
% files = dir(strcat('/media/h005/659fdcc2-512a-4aa8-b47e-82111d85a019/h005/vpDataSet/bigben/imgs/','*.jpg'));

% 从.3df文件中读取要提取sift特征的图片
modelList = {'bigben',...
    'cctv3',...
    'freeGodness',...
    'kxm',...
    'notredame',...
    'tajMahal'};

fea3d = {};
dataPath = '/media/h005/659fdcc2-512a-4aa8-b47e-82111d85a019/h005/vpDataSet';
savePath = '../vpData';
for index = 1:numel(modelList)
    fea3Dfile = ['../vpData/' modelList{index} '/vpFea/' modelList{index} '.3df'];
%     pathImg = [];
    fea3dtmp = scload_fv(fea3Dfile,modelList{index});
    fea3d = {fea3d{:},fea3dtmp{:}};
end

% read image and extract features
for index = 1:numel(fea3d)  
    % read in image
    image = imread([dataPath '/' fea3d{index}.fname]);
    % extract features
    if size(image,3) == 3
        image = single(rgb2gray(image));
    else
        image = single(image);
    end
    [f,d] = vl_sift(image);  
    % store features
    save([savePath '/' fea3d{index}.model '/sift/' fea3d{index}.baseName], 'd');
    disp(['save ' fea3d{index}.fname ' done'])
end


