%% this function was built to make regress with 2dfeature,3dfeature,2d+3dfeature

function generalRegress(fs,fs2d,fs3d,method)
[score,predictScore] = amtRegress(fs,method);
showInfo(method,score,predictScore,'2d+3d',2,3,1);
showErrInfo(method,score,predictScore,'2d+3d',2,3,4);
[score,predictScore] = amtRegress(fs2d,method);
showInfo(method,score,predictScore,'2d',2,3,2);
showErrInfo(method,score,predictScore,'2d+3d',2,3,5);
[score,predictScore] = amtRegress(fs3d,method);
showInfo(method,score,predictScore,'3d',2,3,3);
showErrInfo(method,score,predictScore,'2d+3d',2,3,6);
