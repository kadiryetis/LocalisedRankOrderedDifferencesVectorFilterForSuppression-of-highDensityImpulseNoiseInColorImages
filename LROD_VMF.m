clear all; close all; clc
tic
I = imread('Lenna.png');

p = 0.5;
Inoised = double(imnoise(I, 'salt & pepper', p));

figure;
subplot(121); imshow(I); title('Original image');
subplot(122); imshow(uint8(Inoised));
title(['Corrupted image with p= ', num2str(p)]);

[R, C, spec]= size(Inoised);

fs = 5;
h = floor(fs/2);
start = ceil(fs/2);

LROD_OUT = zeros(R,C);
LROD_VMF_OUT = zeros(R,C,spec);

corruptPixels = 0;
for r= start: 1: R-h
    for c= start: 1: C-h
        OMEGA_x = Inoised(r-h:r+h, c-h:c+h, :);
        center = OMEGA_x(3,3,:);
        iscorrupt = Window(OMEGA_x,center);
        
        if iscorrupt == 1
            LROD_OUT(r,c) = 1;
            corruptPixels = corruptPixels + 1; 
            LROD_VMF_OUT(r,c,:) = VMF_CityBlock(OMEGA_x);
            %LROD_VMF_OUT(r,c,:) = VMF_Euclidian(OMEGA_x);
            %LROD_VMF_OUT(r,c,:) = VMF_Euclidian_Loop(OMEGA_x);
        else
            LROD_VMF_OUT(r,c,:) = Inoised(r,c,:);
        end        
            
    end
end
figure; imshow(LROD_OUT);
title(['LROD_o_u_t, p= ',num2str(p), ', Number of Corrupted '...
    'pixel: ' num2str(corruptPixels), '/', num2str(R*C)]);

figure; imshow(uint8(LROD_VMF_OUT));
title(['LROD-VMF_o_u_t, p= ',num2str(p)]);


VMF_OUT_CityBlock = zeros(R,C,spec);
for r= start: 1: R-h
    for c= start: 1: C-h
        OMEGA_x = Inoised(r-h:r+h, c-h:c+h, :);
        VMF_OUT_CityBlock(r,c,:) = VMF_CityBlock(OMEGA_x);
        %VMF_OUT_Euclidian(r,c,:) = VMF_Euclidian(OMEGA_x);
        %VMF_OUT_Euclidian_Loop(r,c,:) = VMF_Euclidian_Loop(OMEGA_x);
    end
end

figure; imshow(uint8(VMF_OUT_CityBlock));
title(['VMF_o_u_t L_1- City Block, p= ',num2str(p)]);

toc