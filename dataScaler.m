function scaler = dataScale(trainData,method)
% trainData is mfeatures * ncases
% min-max scale
if strcmp(method,'minMax')
    scaler.id = 'dataScaler';
    scaler.method = method;
    scaler.fmin = min(trainData,[],2);
    scaler.fmax = max(trainData,[],2);    
end