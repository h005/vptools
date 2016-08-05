%% this function was created to compute gps distance between two points
%   input : two gps positions lat1,lon1,lat2,lon2
%   output: distance in meters
%   ref https://github.com/janantala/GPS-distance/blob/master/c/distance.c

function meter = getDistanceGPS(lat1,lon1,lat2,lon2)

meter = 0;
a = 6378137;
b = 6356752.314245;
f = 1 / 298.257223563;

L = toRadians(lon2 - lon1);

U1 = atan((1 - f) * tan(toRadians(lat1)));
U2 = atan((1 - f) * tan(toRadians(lat2)));
sinU1 = sin(U1);
cosU1 = cos(U1);
sinU2 = sin(U2);
cosU2 = cos(U2);

lambda = L;
iterLimit = 100;

while(1)
    sinLambda = sin(lambda);
    cosLambda = cos(lambda);
    sinSigma = sqrt(...
    (cosU2 * sinLambda) * (cosU2 * sinLambda)...
    + (cosU1 * sinU2 - sinU1 * cosU2 * cosLambda) ...
    * (cosU1 * sinU2 - sinU1 * cosU2 * cosLambda) ...
    );
    if(sinSigma == 0)
        iterLimit = 0;
        break;
    end
    
    cosSigma = sinU1 * sinU2 + cosU1 * cosU2 * cosLambda;
	sigma = atan2(sinSigma, cosSigma);
	sinAlpha = cosU1 * cosU2 * sinLambda / sinSigma;
	cosSqAlpha = 1 - sinAlpha * sinAlpha;
	cos2SigmaM = cosSigma - 2 * sinU1 * sinU2 / cosSqAlpha;

	C = f / 16 * cosSqAlpha * (4 + f * (4 - 3 * cosSqAlpha));
	lambdaP = lambda;
	lambda = L + (1 - C) * f * sinAlpha	...
			* 	(sigma + C * sinSigma ...	
			* 	(cos2SigmaM + C * cosSigma ...
			* 	(-1 + 2 * cos2SigmaM * cos2SigmaM)));
    disp([iterLimit, lambda, lambdaP]);
    iterLimit = iterLimit - 1;
    if(abs(lambda - lambdaP) <= 1e-12 || iterLimit <=0)
        break;
    end
end

if(iterLimit == 0)
    meter = 0;
else
    uSq = cosSqAlpha * (a * a - b * b) / (b * b);
    A = 1 + uSq / 16384 ...
                * (4096 + uSq * (-768 + uSq * (320 - 175 * uSq)));
    B = uSq / 1024 * (256 + uSq * (-128 + uSq * (74 - 47 * uSq)));
    deltaSigma = B * sinSigma * (cos2SigmaM + B / 4 ...
                * (cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM) - B / 6 * cos2SigmaM ...
                * (-3 + 4 * sinSigma * sinSigma) * (-3 + 4 * cos2SigmaM * cos2SigmaM)));

    meter = b * A * (sigma - deltaSigma);
end





function rad = toRadians(degree)
rad = degree * 3.14159265358979323846 /180.0;