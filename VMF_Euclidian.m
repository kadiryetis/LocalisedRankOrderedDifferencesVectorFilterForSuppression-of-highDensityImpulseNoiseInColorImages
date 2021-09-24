function [out] = VMF_Euclidian(in)

OMEGA_x = double(in);
[R, C, spec] = size(OMEGA_x);

distances = zeros(R, C);
for r=1: R
    for c=1: C       
        temp = repmat(OMEGA_x(r,c,:),[5,5]);
        temp2 = abs(OMEGA_x-temp).^2; 
        temp3 = sqrt(sum(temp2, 3));
        distances(r,c) = sum(temp3(:));     
    end    
end

dif_mask = (distances==min(distances(:)));
dif_mask_3 = repmat(dif_mask,[1,1,3]);
out =  OMEGA_x(dif_mask_3);
if length(out)>3
    [r,c] = find(dif_mask==1);
    temp = OMEGA_x(r(1), c(1), :);
    out = temp(:);
end

end
