gray1 = imread("./cannytest1.bmp");
gray2 = imread("./cannytest2.bmp");
gray3 = imread("./cannytest3.bmp");
gray4 = imread("./cannytest4.bmp");

% Creation of Gaussian filters
gauss1 = fspecial('gaussian', 3, 0.1);
gauss3 = fspecial('gaussian', 3, 0.3);
gauss5 = fspecial('gaussian', 3, 0.5);
gauss7 = fspecial('gaussian', 3, 0.7);
gauss9 = fspecial('gaussian', 3, 0.9);

% Conversion to double from uint8 for future calculations
gray1 = im2double(gray1);
gray2 = im2double(gray2);
gray3 = im2double(gray3);
gray4 = im2double(gray4);

% Convolution of grayscale image with Gaussian filters
g1g1 = imfilter(gray1, gauss1, 'conv');
g1g3 = imfilter(gray1, gauss3, 'conv');
g1g5 = imfilter(gray1, gauss5, 'conv');
g1g7 = imfilter(gray1, gauss7, 'conv');
g1g9 = imfilter(gray1, gauss9, 'conv');

g2g1 = imfilter(gray2, gauss1, 'conv');
g2g3 = imfilter(gray2, gauss3, 'conv');
g2g5 = imfilter(gray2, gauss5, 'conv');
g2g7 = imfilter(gray2, gauss7, 'conv');
g2g9 = imfilter(gray2, gauss9, 'conv');

g3g1 = imfilter(gray3, gauss1, 'conv');
g3g3 = imfilter(gray3, gauss3, 'conv');
g3g5 = imfilter(gray3, gauss5, 'conv');
g3g7 = imfilter(gray3, gauss7, 'conv');
g3g9 = imfilter(gray3, gauss9, 'conv');

g4g1 = imfilter(gray4, gauss1, 'conv');
g4g3 = imfilter(gray4, gauss3, 'conv');
g4g5 = imfilter(gray4, gauss5, 'conv');
g4g7 = imfilter(gray4, gauss7, 'conv');
g4g9 = imfilter(gray4, gauss9, 'conv');

% Creation of Sobel filters
sobelX = fspecial('sobel');
sobelY = sobelX';

% Separating image into X and Y components by convoluting with corrresponding Sobel filter
g1g1X = imfilter(g1g1, sobelX, 'conv');
g1g1Y = imfilter(g1g1, sobelY, 'conv');
g1g3X = imfilter(g1g3, sobelX, 'conv');
g1g3Y = imfilter(g1g3, sobelY, 'conv');
g1g5X = imfilter(g1g5, sobelX, 'conv');
g1g5Y = imfilter(g1g5, sobelY, 'conv');
g1g7X = imfilter(g1g7, sobelX, 'conv');
g1g7Y = imfilter(g1g7, sobelY, 'conv');
g1g9X = imfilter(g1g9, sobelX, 'conv');
g1g9Y = imfilter(g1g9, sobelY, 'conv');

g2g1X = imfilter(g2g1, sobelX, 'conv');
g2g1Y = imfilter(g2g1, sobelY, 'conv');
g2g3X = imfilter(g2g3, sobelX, 'conv');
g2g3Y = imfilter(g2g3, sobelY, 'conv');
g2g5X = imfilter(g2g5, sobelX, 'conv');
g2g5Y = imfilter(g2g5, sobelY, 'conv');
g2g7X = imfilter(g2g7, sobelX, 'conv');
g2g7Y = imfilter(g2g7, sobelY, 'conv');
g2g9X = imfilter(g2g9, sobelX, 'conv');
g2g9Y = imfilter(g2g9, sobelY, 'conv');

g3g1X = imfilter(g3g1, sobelX, 'conv');
g3g1Y = imfilter(g3g1, sobelY, 'conv');
g3g3X = imfilter(g3g3, sobelX, 'conv');
g3g3Y = imfilter(g3g3, sobelY, 'conv');
g3g5X = imfilter(g3g5, sobelX, 'conv');
g3g5Y = imfilter(g3g5, sobelY, 'conv');
g3g7X = imfilter(g3g7, sobelX, 'conv');
g3g7Y = imfilter(g3g7, sobelY, 'conv');
g3g9X = imfilter(g3g9, sobelX, 'conv');
g3g9Y = imfilter(g3g9, sobelY, 'conv');

g4g1X = imfilter(g4g1, sobelX, 'conv');
g4g1Y = imfilter(g4g1, sobelY, 'conv');
g4g3X = imfilter(g4g3, sobelX, 'conv');
g4g3Y = imfilter(g4g3, sobelY, 'conv');
g4g5X = imfilter(g4g5, sobelX, 'conv');
g4g5Y = imfilter(g4g5, sobelY, 'conv');
g4g7X = imfilter(g4g7, sobelX, 'conv');
g4g7Y = imfilter(g4g7, sobelY, 'conv');
g4g9X = imfilter(g4g9, sobelX, 'conv');
g4g9Y = imfilter(g4g9, sobelY, 'conv');

% Calculation of gradient image
g1g1Grad = (g1g1X.^2 + g1g1Y.^2).^0.5;
g1g3Grad = (g1g3X.^2 + g1g3Y.^2).^0.5;
g1g5Grad = (g1g5X.^2 + g1g5Y.^2).^0.5;
g1g7Grad = (g1g7X.^2 + g1g7Y.^2).^0.5;
g1g9Grad = (g1g9X.^2 + g1g9Y.^2).^0.5;

g2g1Grad = (g2g1X.^2 + g2g1Y.^2).^0.5;
g2g3Grad = (g2g3X.^2 + g2g3Y.^2).^0.5;
g2g5Grad = (g2g5X.^2 + g2g5Y.^2).^0.5;
g2g7Grad = (g2g7X.^2 + g2g7Y.^2).^0.5;
g2g9Grad = (g2g9X.^2 + g2g9Y.^2).^0.5;

g3g1Grad = (g3g1X.^2 + g3g1Y.^2).^0.5;
g3g3Grad = (g3g3X.^2 + g3g3Y.^2).^0.5;
g3g5Grad = (g3g5X.^2 + g3g5Y.^2).^0.5;
g3g7Grad = (g3g7X.^2 + g3g7Y.^2).^0.5;
g3g9Grad = (g3g9X.^2 + g3g9Y.^2).^0.5;

g4g1Grad = (g4g1X.^2 + g4g1Y.^2).^0.5;
g4g3Grad = (g4g3X.^2 + g4g3Y.^2).^0.5;
g4g5Grad = (g4g5X.^2 + g4g5Y.^2).^0.5;
g4g7Grad = (g4g7X.^2 + g4g7Y.^2).^0.5;
g4g9Grad = (g4g9X.^2 + g4g9Y.^2).^0.5;

% Calculation of Angle image
g1g1Ang = atan(g1g1Y./g1g1X);
g1g3Ang = atan(g1g3Y./g1g3X);
g1g5Ang = atan(g1g5Y./g1g5X);
g1g7Ang = atan(g1g7Y./g1g7X);
g1g9Ang = atan(g1g9Y./g1g9X);

g2g1Ang = atan(g2g1Y./g2g1X);
g2g3Ang = atan(g2g3Y./g2g3X);
g2g5Ang = atan(g2g5Y./g2g5X);
g2g7Ang = atan(g2g7Y./g2g7X);
g2g9Ang = atan(g2g9Y./g2g9X);

g3g1Ang = atan(g3g1Y./g3g1X);
g3g3Ang = atan(g3g3Y./g3g3X);
g3g5Ang = atan(g3g5Y./g3g5X);
g3g7Ang = atan(g3g7Y./g3g7X);
g3g9Ang = atan(g3g9Y./g3g9X);

g4g1Ang = atan(g4g1Y./g4g1X);
g4g3Ang = atan(g4g3Y./g4g3X);
g4g5Ang = atan(g4g5Y./g4g5X);
g4g7Ang = atan(g4g7Y./g4g7X);
g4g9Ang = atan(g4g9Y./g4g9X);

% Performing non-maximum suppression on each image
g1g1NM = non_max_suppression(g1g1Grad, g1g1Ang);
g1g3NM = non_max_suppression(g1g3Grad, g1g3Ang);
g1g5NM = non_max_suppression(g1g5Grad, g1g5Ang);
g1g7NM = non_max_suppression(g1g7Grad, g1g7Ang);
g1g9NM = non_max_suppression(g1g9Grad, g1g9Ang);

g2g1NM = non_max_suppression(g2g1Grad, g2g1Ang);
g2g3NM = non_max_suppression(g2g3Grad, g2g3Ang);
g2g5NM = non_max_suppression(g2g5Grad, g2g5Ang);
g2g7NM = non_max_suppression(g2g7Grad, g2g7Ang);
g2g9NM = non_max_suppression(g2g9Grad, g2g9Ang);

g3g1NM = non_max_suppression(g3g1Grad, g3g1Ang);
g3g3NM = non_max_suppression(g3g3Grad, g3g3Ang);
g3g5NM = non_max_suppression(g3g5Grad, g3g5Ang);
g3g7NM = non_max_suppression(g3g7Grad, g3g7Ang);
g3g9NM = non_max_suppression(g3g9Grad, g3g9Ang);

g4g1NM = non_max_suppression(g4g1Grad, g4g1Ang);
g4g3NM = non_max_suppression(g4g3Grad, g4g3Ang);
g4g5NM = non_max_suppression(g4g5Grad, g4g5Ang);
g4g7NM = non_max_suppression(g4g7Grad, g4g7Ang);
g4g9NM = non_max_suppression(g4g9Grad, g4g9Ang);

% Hysteresis - finding maximum of 8 neighboring pixels and removing pixels
% under 0.01
g1g1Res1 = hysteresis(g1g1NM, 0.01);
g1g3Res1 = hysteresis(g1g3NM, 0.01);
g1g5Res1 = hysteresis(g1g5NM, 0.01);
g1g7Res1 = hysteresis(g1g7NM, 0.01);
g1g9Res1 = hysteresis(g1g9NM, 0.01);

g2g1Res1 = hysteresis(g2g1NM, 0.01);
g2g3Res1 = hysteresis(g2g3NM, 0.01);
g2g5Res1 = hysteresis(g2g5NM, 0.01);
g2g7Res1 = hysteresis(g2g7NM, 0.01);
g2g9Res1 = hysteresis(g2g9NM, 0.01);

g3g1Res1 = hysteresis(g3g1NM, 0.01);
g3g3Res1 = hysteresis(g3g3NM, 0.01);
g3g5Res1 = hysteresis(g3g5NM, 0.01);
g3g7Res1 = hysteresis(g3g7NM, 0.01);
g3g9Res1 = hysteresis(g3g9NM, 0.01);

g4g1Res1 = hysteresis(g4g1NM, 0.01);
g4g3Res1 = hysteresis(g4g3NM, 0.01);
g4g5Res1 = hysteresis(g4g5NM, 0.01);
g4g7Res1 = hysteresis(g4g7NM, 0.01);
g4g9Res1 = hysteresis(g4g9NM, 0.01);

% Hysteresis with threshold 0.05
g1g1Res3 = hysteresis(g1g1NM, 0.05);
g1g3Res3 = hysteresis(g1g3NM, 0.05);
g1g5Res3 = hysteresis(g1g5NM, 0.05);
g1g7Res3 = hysteresis(g1g7NM, 0.05);
g1g9Res3 = hysteresis(g1g9NM, 0.05);

g2g1Res3 = hysteresis(g2g1NM, 0.05);
g2g3Res3 = hysteresis(g2g3NM, 0.05);
g2g5Res3 = hysteresis(g2g5NM, 0.05);
g2g7Res3 = hysteresis(g2g7NM, 0.05);
g2g9Res3 = hysteresis(g2g9NM, 0.05);

g3g1Res3 = hysteresis(g3g1NM, 0.05);
g3g3Res3 = hysteresis(g3g3NM, 0.05);
g3g5Res3 = hysteresis(g3g5NM, 0.05);
g3g7Res3 = hysteresis(g3g7NM, 0.05);
g3g9Res3 = hysteresis(g3g9NM, 0.05);

g4g1Res3 = hysteresis(g4g1NM, 0.05);
g4g3Res3 = hysteresis(g4g3NM, 0.05);
g4g5Res3 = hysteresis(g4g5NM, 0.05);
g4g7Res3 = hysteresis(g4g7NM, 0.05);
g4g9Res3 = hysteresis(g4g9NM, 0.05);

% Hysteresis with threshold 0.1
g1g1Res5 = hysteresis(g1g1NM, 0.1);
g1g3Res5 = hysteresis(g1g3NM, 0.1);
g1g5Res5 = hysteresis(g1g5NM, 0.1);
g1g7Res5 = hysteresis(g1g7NM, 0.1);
g1g9Res5 = hysteresis(g1g9NM, 0.1);

g2g1Res5 = hysteresis(g2g1NM, 0.1);
g2g3Res5 = hysteresis(g2g3NM, 0.1);
g2g5Res5 = hysteresis(g2g5NM, 0.1);
g2g7Res5 = hysteresis(g2g7NM, 0.1);
g2g9Res5 = hysteresis(g2g9NM, 0.1);

g3g1Res5 = hysteresis(g3g1NM, 0.1);
g3g3Res5 = hysteresis(g3g3NM, 0.1);
g3g5Res5 = hysteresis(g3g5NM, 0.1);
g3g7Res5 = hysteresis(g3g7NM, 0.1);
g3g9Res5 = hysteresis(g3g9NM, 0.1);

g4g1Res5 = hysteresis(g4g1NM, 0.1);
g4g3Res5 = hysteresis(g4g3NM, 0.1);
g4g5Res5 = hysteresis(g4g5NM, 0.1);
g4g7Res5 = hysteresis(g4g7NM, 0.1);
g4g9Res5 = hysteresis(g4g9NM, 0.1);

% Displaying images

subplot(3, 6, 1);
imshow(gray1);
title('Original');

subplot(3, 6, 2);
imshow(g1g1Res1);
title('Gauss 0.1 with 0.01 Threshold');

subplot(3, 6, 3);
imshow(g1g3Res1);
title('Gauss 0.3 with 0.01 Threshold');

subplot(3, 6, 4);
imshow(g1g5Res1);
title('Gauss 0.5 with 0.01 Threshold');

subplot(3, 6, 5);
imshow(g1g7Res1);
title('Gauss 0.7 with 0.01 Threshold');

subplot(3, 6, 6);
imshow(g1g9Res1);
title('Gauss 0.9 with 0.01 Threshold');

subplot(3, 6, 7);
imshow(gray1);
title('Original');

subplot(3, 6, 8);
imshow(g1g1Res3);
title('Gauss 0.1 with 0.05 Threshold');

subplot(3, 6, 9);
imshow(g1g3Res3);
title('Gauss 0.3 with 0.05 Threshold');

subplot(3, 6, 10);
imshow(g1g5Res3);
title('Gauss 0.5 with 0.05 Threshold');

subplot(3, 6, 11);
imshow(g1g7Res3);
title('Gauss 0.7 with 0.05 Threshold');

subplot(3, 6, 12);
imshow(g1g9Res3);
title('Gauss 0.9 with 0.05 Threshold');

subplot(3, 6, 13);
imshow(gray1);
title('Original');

subplot(3, 6, 14);
imshow(g1g1Res5);
title('Gauss 0.1 with 0.1 Threshold');

subplot(3, 6, 15);
imshow(g1g3Res5);
title('Gauss 0.3 with 0.1 Threshold');

subplot(3, 6, 16);
imshow(g1g5Res5);
title('Gauss 0.5 with 0.1 Threshold');

subplot(3, 6, 17);
imshow(g1g7Res5);
title('Gauss 0.7 with 0.1 Threshold');

subplot(3, 6, 18);
imshow(g1g9Res5);
title('Gauss 0.9 with 0.1 Threshold');

figure(2);

subplot(3, 6, 1);
imshow(gray2);
title('Original');

subplot(3, 6, 2);
imshow(g2g1Res1);
title('Gauss 0.1 with 0.01 Threshold');

subplot(3, 6, 3);
imshow(g2g3Res1);
title('Gauss 0.3 with 0.01 Threshold');

subplot(3, 6, 4);
imshow(g2g5Res1);
title('Gauss 0.5 with 0.01 Threshold')

subplot(3, 6, 5);
imshow(g2g7Res1);
title('Gauss 0.7 with 0.01 Threshold');

subplot(3, 6, 6);
imshow(g2g9Res1);
title('Gauss 0.9 with 0.01 Threshold');

subplot(3, 6, 7);
imshow(gray2);
title('Original');

subplot(3, 6, 8);
imshow(g2g1Res3);
title('Gauss 0.1 with 0.05 Threshold');

subplot(3, 6, 9);
imshow(g2g3Res3);
title('Gauss 0.3 with 0.05 Threshold');

subplot(3, 6, 10);
imshow(g2g5Res3);
title('Gauss 0.5 with 0.05 Threshold');

subplot(3, 6, 11);
imshow(g2g7Res3);
title('Gauss 0.7 with 0.05 Threshold');

subplot(3, 6, 12);
imshow(g2g9Res3);
title('Gauss 0.9 with 0.05 Threshold');

subplot(3, 6, 13);
imshow(gray2);
title('Original');

subplot(3, 6, 14);
imshow(g2g1Res5);
title('Gauss 0.1 with 0.1 Threshold');

subplot(3, 6, 15);
imshow(g2g3Res5);
title('Gauss 0.3 with 0.1 Threshold');

subplot(3, 6, 16);
imshow(g2g5Res5);
title('Gauss 0.5 with 0.1 Threshold');

subplot(3, 6, 17);
imshow(g2g7Res5);
title('Gauss 0.7 with 0.1 Threshold');

subplot(3, 6, 18);
imshow(g2g9Res5);
title('Gauss 0.9 with 0.1 Threshold');

figure(3);

subplot(3, 6, 1);
imshow(gray3);
title('Original');

subplot(3, 6, 2);
imshow(g3g1Res1);
title('Gauss 0.1 with 0.01 Threshold');

subplot(3, 6, 3);
imshow(g3g3Res1);
title('Gauss 0.3 with 0.01 Threshold');

subplot(3, 6, 4);
imshow(g3g5Res1);
title('Gauss 0.5 with 0.01 Threshold')

subplot(3, 6, 5);
imshow(g3g7Res1);
title('Gauss 0.7 with 0.01 Threshold');

subplot(3, 6, 6);
imshow(g3g9Res1);
title('Gauss 0.9 with 0.01 Threshold');

subplot(3, 6, 7);
imshow(gray3);
title('Original');

subplot(3, 6, 8);
imshow(g3g1Res3);
title('Gauss 0.1 with 0.05 Threshold');

subplot(3, 6, 9);
imshow(g3g3Res3);
title('Gauss 0.3 with 0.05 Threshold');

subplot(3, 6, 10);
imshow(g3g5Res3);
title('Gauss 0.5 with 0.05 Threshold');

subplot(3, 6, 11);
imshow(g3g7Res3);
title('Gauss 0.7 with 0.05 Threshold');

subplot(3, 6, 12);
imshow(g3g9Res3);
title('Gauss 0.9 with 0.05 Threshold');

subplot(3, 6, 13);
imshow(gray3);
title('Original');

subplot(3, 6, 14);
imshow(g3g1Res5);
title('Gauss 0.1 with 0.1 Threshold');

subplot(3, 6, 15);
imshow(g3g3Res5);
title('Gauss 0.3 with 0.1 Threshold');

subplot(3, 6, 16);
imshow(g3g5Res5);
title('Gauss 0.5 with 0.1 Threshold');

subplot(3, 6, 17);
imshow(g3g7Res5);
title('Gauss 0.7 with 0.1 Threshold');

subplot(3, 6, 18);
imshow(g3g9Res5);
title('Gauss 0.9 with 0.1 Threshold');

figure(4);

subplot(3, 6, 1);
imshow(gray4);
title('Original');

subplot(3, 6, 2);
imshow(g4g1Res1);
title('Gauss 0.1 with 0.01 Threshold');

subplot(3, 6, 3);
imshow(g4g3Res1);
title('Gauss 0.3 with 0.01 Threshold');

subplot(3, 6, 4);
imshow(g4g5Res1);
title('Gauss 0.5 with 0.01 Threshold')

subplot(3, 6, 5);
imshow(g4g7Res1);
title('Gauss 0.7 with 0.01 Threshold');

subplot(3, 6, 6);
imshow(g4g9Res1);
title('Gauss 0.9 with 0.01 Threshold');

subplot(3, 6, 7);
imshow(gray4);
title('Original');

subplot(3, 6, 8);
imshow(g4g1Res3);
title('Gauss 0.1 with 0.05 Threshold');

subplot(3, 6, 9);
imshow(g4g3Res3);
title('Gauss 0.3 with 0.05 Threshold');

subplot(3, 6, 10);
imshow(g4g5Res3);
title('Gauss 0.5 with 0.05 Threshold');

subplot(3, 6, 11);
imshow(g4g7Res3);
title('Gauss 0.7 with 0.05 Threshold');

subplot(3, 6, 12);
imshow(g4g9Res3);
title('Gauss 0.9 with 0.05 Threshold');

subplot(3, 6, 13);
imshow(gray4);
title('Original');

subplot(3, 6, 14);
imshow(g4g1Res5);
title('Gauss 0.1 with 0.1 Threshold');

subplot(3, 6, 15);
imshow(g4g3Res5);
title('Gauss 0.3 with 0.1 Threshold');

subplot(3, 6, 16);
imshow(g4g5Res5);
title('Gauss 0.5 with 0.1 Threshold');

subplot(3, 6, 17);
imshow(g4g7Res5);
title('Gauss 0.7 with 0.1 Threshold');

subplot(3, 6, 18);
imshow(g4g9Res5);
title('Gauss 0.9 with 0.1 Threshold');