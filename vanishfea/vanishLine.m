%% this function was created to compute vanishing point feature
% points is 3 * 2 array
% angels are array with four elements
% angles(1) the minimum angle between vanishline and horizon
% angles(2:4) are angels between them sorted small to large
function angles = vanishLine(points)

angles = zeros(1,4);
line = zeros(3,2);
line(1,:) = points(2,:) - points(1,:);
line(2,:) = points(3,:) - points(2,:);
line(3,:) = points(1,:) - points(3,:);
horizon = [1,0];
horValue = [getAngle(line(1,:),horizon),...
    getAngle(line(2,:),horizon),...
    getAngle(line(3,:),horizon)];
angles(1) = min(abs(horValue));
angle = [getAngle(-line(1,:),line(2,:)),...
    getAngle(line(1,:),-line(3,:)),...
    getAngle(-line(2,:),line(3,:))];
angle = sort(angle);
angles(2:end) = angle;

% angles = zeros(1,3);
% angles = angle;

% modified by h005 at 20161229
% just reserve the min and max angles between each vanish lines
% and add their entropy value

% angles = [angle(1),angle(3),getVar(angle)];
angles = [angles angle(1) angle(3) getVar(angle)];

end

function angle = getAngle(u,v)
if norm(u) == 0 || norm(v) == 0
    angle = 0;
else 
    CosTheta = dot(u,v)/(norm(u)*norm(v));
    angle = acos(CosTheta);
end
end

function var = getVar(num)
    mean_val = mean(num);
    var = 0;
    for i=1:length(num)
        var = var + (num(i) - mean_val) * (num(i) - mean_val);
    end
    var = var / length(num);
end

