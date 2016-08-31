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
angles(1) = min(horValue);
angle = [getAngle(-line(1,:),line(2,:)),...
    getAngle(line(1,:),-line(3,:)),...
    getAngle(-line(2,:),line(3,:))];
angle = sort(angle);
angles(2:end) = angle;

angles = zeros(1,3);
angles = angle;
end

function angle = getAngle(u,v)
CosTheta = dot(u,v)/(norm(u)*norm(v));
angle = acos(CosTheta);
end


