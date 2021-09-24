clear all; close all; clc;

I = imread('Lenna.png');

p = 0.1;
Inoised = double(imnoise(I, 'salt & pepper', p));

figure;
subplot(121); imshow(I); title('Original image');
subplot(122); imshow(uint8(Inoised));
title(['Corrupted image with p= ', num2str(p)]);

[R, C, spec]= size(Inoised);
fs = 5;
h = floor(fs/2);
start = ceil(fs/2);

VMF_OUT_CityBlock = zeros(R,C,spec);
for r= start: 1: R-h
    for c= start: 1: C-h
        OMEGAx = Inoised(r-h:r+h, c-h:c+h, :);
        VMF_OUT_CityBlock(r,c,:) = VMF_CityBlock(OMEGAx);            
    end
end
figure; imshow(uint8(VMF_OUT_CityBlock));
title(['VMF_o_u_t L_1-City Block, p= ', num2str(p)]);

VMF_OUT_Euclidian = zeros(R,C,spec);
for r= start: 1: R-h
    for c= start: 1: C-h
        OMEGAx = Inoised(r-h:r+h, c-h:c+h, :);
        VMF_OUT_Euclidian(r,c,:) = VMF_Euclidian(OMEGAx);            
    end
end
figure; imshow(uint8(VMF_OUT_Euclidian));
title(['VMF_o_u_t L_2-Euclidian, p= ', num2str(p)]);

VMF_OUT_Euclidian_Loop = zeros(R,C,spec);
for r= start: 1: R-h
    for c= start: 1: C-h
        OMEGAx = Inoised(r-h:r+h, c-h:c+h, :);
        VMF_OUT_Euclidian_Loop(r,c,:) = VMF_Euclidian_Loop(OMEGAx);            
    end
end
figure; imshow(uint8(VMF_OUT_Euclidian_Loop));
title(['VMF_o_u_t L_2-Euclidian with Loop, p= ',num2str(p)]);