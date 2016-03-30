function data = datascaling(scaler,trainData)
%% trainData is mfeatures * ncases
data = trainData;
if strcmp(scaler.id,'dataScaler')
    if strcmp(scaler.method,'minMax')
        for i=1:size(trainData,1)
            data(i,:) = (data(i,:) - scaler.fmin(i)) / (scaler.fmax(i) - scaler.fmin(i));
        end
    end
else
    disp('scaler error');
    data = [];
end