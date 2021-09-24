function [corruption] = Window(OMEGA_x, center)

corruption = 0;
[R, C, spec]= size(OMEGA_x);
fs = 3;
h = floor(fs/2);
start = ceil(fs/2);

sum_similarity = 0;
for r= start: 1: R-h
    for c= start: 1: C-h
        OMEGA_xj = OMEGA_x(r-h:r+h, c-h:c+h, :);
        similarity = Subwindow(OMEGA_xj, center);
        sum_similarity = sum_similarity+similarity;
    end
end

if sum_similarity >= 3
    %disp('Not Corrupt')
    corruption = 0;
else
    %disp('Corrupt');
    corruption = 1;
end


end