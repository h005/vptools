%% this script was created to test gps coordinate
path = '/media/h005/h005_D/viewpoint/nju2';
% path = '.';
imgFile = [path '/IMG_0' '917' '.JPG'];

imInfo1 = imfinfo(imgFile);
imgFile = [path '/IMG_0' '918' '.JPG'];
imInfo2 = imfinfo(imgFile);
imInfo1.GPSInfo
imInfo2.GPSInfo
lat1 = imInfo1.GPSInfo.GPSLatitude;
lat2 = imInfo2.GPSInfo.GPSLatitude;
lon1 = imInfo1.GPSInfo.GPSLongitude;
lon2 = imInfo2.GPSInfo.GPSLongitude;

latval1 = lat1(1)+lat1(2)/60+lat1(3)/3600;
latval2 = lat2(1)+lat2(2)/60+lat2(3)/3600;

lonval1 = lon1(1)+lon1(2)/60+lon1(3)/3600;
lonval2 = lon2(1)+lon2(2)/60+lon2(3)/3600;

getDistanceGPS(latval1,lonval1,latval2,lonval2)
