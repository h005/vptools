%% this script was created to get visual features wtih caffe

function fea = visFea(filelist)

fea = cell(numel(filelist,1));

addpath('/home/h005/Documents/caffe/matlab');
model_dir = '/home/h005/Documents/caffe/models/bvlc_reference_caffenet/';
net_weights = [model_dir 'bvlc_reference_caffenet.caffemodel'];
net_model = [model_dir 'deploy.prototxt'];
phase = 'test';

caffe.set_mode_gpu();
caffe.set_device(0);

net = caffe.Net(net_model, net_weights, phase);

d = load('/home/h005/Documents/caffe/matlab/+caffe/imagenet/ilsvrc_2012_mean.mat');
mean_data = d.mean_data;
IMAGE_DIM = 256;
CROPPED_DIM = 227;

for index = 1:numel(filelist)
    im = imread(filelist{index});
    disp([num2str(index) '/' num2str(numel(filelist)) filelist{index}]);
    if size(im,3) == 1 % gray image
       im =  repmat(im,1,1,3);
    end   
    % Convert an image returned by Matlab's imread to im_data in caffe's data
    % format: W x H x C with BGR channels
    im_data = im(:, :, [3, 2, 1]);  % permute channels from RGB to BGR
    im_data = permute(im_data, [2, 1, 3]);  % flip width and height
    im_data = single(im_data);  % convert from uint8 to single
    im_data = imresize(im_data, [IMAGE_DIM IMAGE_DIM], 'bilinear');  % resize im_data
    im_data = im_data - mean_data;  % subtract mean_data (already in W x H x C, BGR)

    % oversample (4 corners, center, and their x-axis flips)
    crops_data = zeros(CROPPED_DIM, CROPPED_DIM, 3, 10, 'single');
    indices = [0 IMAGE_DIM-CROPPED_DIM] + 1;
    n = 1;
    for i = indices
      for j = indices
        crops_data(:, :, :, n) = im_data(i:i+CROPPED_DIM-1, j:j+CROPPED_DIM-1, :);
        crops_data(:, :, :, n+5) = crops_data(end:-1:1, :, :, n);
        n = n + 1;
      end
    end
    center = floor(indices(2) / 2) + 1;
    crops_data(:,:,:,5) = ...
      im_data(center:center+CROPPED_DIM-1,center:center+CROPPED_DIM-1,:);
    crops_data(:,:,:,10) = crops_data(end:-1:1, :, :, 5);
    
    net.blobs('data').set_data(crops_data);
    net.forward_prefilled();

    fc7=net.blobs('fc7').get_data();
    fea{index}=fc7(:,5);
    
end
