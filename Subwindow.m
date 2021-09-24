function [similarity] = Subwindow(OMEGA_xy, center)

similarity =0;
OMEGA_xy = double(OMEGA_xy);
center_rept = repmat(center, [3,3,1]);

difference = abs(OMEGA_xy-center_rept);
maxDifference = max(difference, [], 3);
sorted = sort(maxDifference(:));
ROD = sum(sorted(2:5));

similarity = 0;
if ROD < 130
    similarity = 1;
end


end
