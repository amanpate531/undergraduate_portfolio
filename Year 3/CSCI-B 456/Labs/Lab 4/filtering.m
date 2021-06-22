% The following code was written by Aman Patel
% February 11, 2020
% CSCI-B 456

% fspecial creates the filtering matrix that is specified
% 'average' creates a matrix that is used to calculate the average of a
% certain number of squares neighboring a pixel.
average3 = fspecial('average', 3);
average5 = fspecial('average', 5);
average7 = fspecial('average', 7);

% 'gaussian' creates a Gaussian matrix, used to blur images without making
% them indistinguishable from the original
gauss3 = fspecial('gaussian', 3, 1);
gauss5 = fspecial('gaussian', 5, 1);
gauss7 = fspecial('gaussian', 7, 1);

% Laplacian matrices are used to highlight rapid changes in intensity,
% typically used for edge detection, all matrices provided by Canvas
% Announcement
laplace3 = [-1,-1,-1;-1,8,-1;-1,-1,-1];
laplace5 = [-1,-3,-4,-3,-1;-3,0,6,0,-3;-4,6,20,6,-4;-3,0,6,0,-3;-1,-3,-4,-3,-1];
laplace7 = [-2,-3,-4,-6,-4,-3,-2;-3,-5,-4,-3,-4,-5,-3;-4,-4,9,20,9,-4,-4;-6,-3,20,36,20,-3,-6;-4,-4,9,20,9,-4,-4;-3,-5,-4,-3,-4,-5,-3;-2,-3,-4,-6,-4,-3,-2];
img = imread('drone.jpg');
subplot(3, 3, 1);

% tic starts Matlab's built in timer
tic
average3IMG = imfilter(img, average3);
imshow(average3IMG);
str = sprintf('Average 3x3 (%fs)', toc);

% sets the title of the current subplot to str, which shows the type of
% filter and the filtering time.
title(str);
subplot(3, 3, 2);
tic
average5IMG = imfilter(img, average5);
imshow(average5IMG);
str = sprintf('Average 5x5 (%fs)', toc);
title(str);
subplot(3, 3, 3);
tic
average7IMG = imfilter(img, average7);
imshow(average7IMG);
str = sprintf('Average 7x7 (%fs)', toc);
title(str);
subplot(3, 3, 4);
tic
gauss3IMG = imfilter(img, gauss3);
imshow(gauss3IMG);
str = sprintf('Gaussian 3x3 (%fs)', toc);
title(str);
subplot(3, 3, 5);
tic
gauss5IMG = imfilter(img, gauss5);
imshow(gauss5IMG);
str = sprintf('Gaussian 5x5 (%fs)', toc);
title(str);
subplot(3, 3, 6);
tic
gauss7IMG = imfilter(img, gauss7);
imshow(gauss7IMG);
str = sprintf('Gaussian 7x7 (%fs)', toc);
title(str);
subplot(3, 3, 7);
tic
laplace3IMG = imfilter(img, laplace3);
imshow(laplace3IMG);
str = sprintf('Laplacian 3x3 (%fs)', toc);
title(str);
subplot(3, 3, 8);
tic
laplace5IMG = imfilter(img, laplace5);
imshow(laplace5IMG);
str = sprintf('Laplacian 5x5 (%fs)', toc);
title(str);
subplot(3, 3, 9);
tic
laplace7IMG = imfilter(img, laplace7);
imshow(laplace7IMG);
str = sprintf('Laplacian 7x7 (%fs)', toc);
title(str);

% The average filters gradually blur the image, increasing the blur as the
% size of the filter is increased. The Gaussian filters produced a more
% controlled blur, no significant changes as the size of the filter
% increased. The Laplacian filters turned most of the image black with the
% major details in white. As the size of the filters increased, the
% detailing lines got thicker and more colors began to appear.

% new figure for testing boundary control methods
figure(2);
subplot(6, 3, 1);
tic
average3IMG = imfilter(img, average3);
imshow(average3IMG);
str = sprintf('Average 3x3 (%fs)', toc);
title(str);
subplot(6, 3, 2);
tic
average5IMG = imfilter(img, average5);
imshow(average5IMG);
str = sprintf('Average 5x5 (%fs)', toc);
title(str);
subplot(6, 3, 3);
tic
average7IMG = imfilter(img, average7);
imshow(average7IMG);
str = sprintf('Average 7x7 (%fs)', toc);
title(str);
subplot(6, 3, 4);

% 'replicate' takes the outermost rows and columns of the filtered image 
% and copies them to the empty spaces
tic
average3RIMG = imfilter(img, average3, 'replicate');
imshow(average3RIMG);
str = sprintf('Average 3x3 w/ Replicate (%fs)', toc);
title(str);
subplot(6, 3, 5);
tic
average5RIMG = imfilter(img, average5, 'replicate');
imshow(average5RIMG);
str = sprintf('Average 5x5 w/ Replicate (%fs)', toc);
title(str);
subplot(6, 3, 6);
tic
average7RIMG = imfilter(img, average7, 'replicate');
imshow(average7RIMG);
str = sprintf('Average 7x7 w/ Replicate (%fs)', toc);
title(str);
subplot(6, 3, 7);
tic
gauss3IMG = imfilter(img, gauss3);
imshow(gauss3IMG);
str = sprintf('Gaussian 3x3 (%fs)', toc);
title(str);
subplot(6, 3, 8);
tic
gauss5IMG = imfilter(img, gauss5);
imshow(gauss5IMG);
str = sprintf('Gaussian 5x5 (%fs)', toc);
title(str);
subplot(6, 3, 9);
tic
gauss7IMG = imfilter(img, gauss7);
imshow(gauss7IMG);
str = sprintf('Gaussian 7x7 (%fs)', toc);
title(str);
subplot(6, 3, 10);
tic
gauss3RIMG = imfilter(img, gauss3, 'replicate');
imshow(gauss3RIMG);
str = sprintf('Gaussian 3x3 w/ Replicate (%fs)', toc);
title(str);
subplot(6, 3, 11);
tic
gauss5RIMG = imfilter(img, gauss5, 'replicate');
imshow(gauss5RIMG);
str = sprintf('Gaussian 5x5 w/ Replicate (%fs)', toc);
title(str);
subplot(6, 3, 12);
tic
gauss7RIMG = imfilter(img, gauss7, 'replicate');
imshow(gauss7RIMG);
str = sprintf('Gaussian 7x7 w/ Replicate (%fs)', toc);
title(str);
subplot(6, 3, 13);
tic
laplace3IMG = imfilter(img, laplace3);
imshow(laplace3IMG);
str = sprintf('Laplacian 3x3 (%fs)', toc);
title(str);
subplot(6, 3, 14);
tic
laplace5IMG = imfilter(img, laplace5);
imshow(laplace5IMG);
str = sprintf('Laplacian 5x5 (%fs)', toc);
title(str);
subplot(6, 3, 15);
tic
laplace7IMG = imfilter(img, laplace7);
imshow(laplace7IMG);
str = sprintf('Laplacian 7x7 (%fs)', toc);
title(str);
subplot(6, 3, 16);
tic
laplace3RIMG = imfilter(img, laplace3, 'replicate');
imshow(laplace3RIMG);
str = sprintf('Laplacian 3x3 w/ Replicate (%fs)', toc);
title(str);
subplot(6, 3, 17);
tic
laplace5RIMG = imfilter(img, laplace5, 'replicate');
imshow(laplace5RIMG);
str = sprintf('Laplacian 5x5 w/ Replicate (%fs)', toc);
title(str);
subplot(6, 3, 18);
tic
laplace7RIMG = imfilter(img, laplace7, 'replicate');
imshow(laplace7RIMG);
str = sprintf('Laplacian 7x7 w/ Replicate (%fs)', toc);
title(str);

% The default setting for boundary control is zero, meaning Matlab uses a
% layer of zeros around the image to average with the edge pixels. This
% leaves a nearly black border, especially with larger filters. Using the
% 'replicate' tag copies a near-border row of pixels onto the boundary.
% This makes the image look more natural, especially for the Laplacian
% filters.

indoorIMG = imread('indoor.jpg');
prewittHorizontal = fspecial('prewitt');
prewittVertical = prewittHorizontal.';
sobelHorizontal = fspecial('sobel');
sobelVertical = sobelHorizontal.';
robertHorizontal = [-1, 0; 0, 1];
robertVertical = [0, -1; 1, 0];

% new figure and subplot for outdoor image
figure(3);
subplot(2, 3, 1);
tic

% applies predefined filter to given image
prewittHIMG = imfilter(img, prewittHorizontal);
imshow(prewittHIMG);
str = sprintf('Prewitt Horizontal (%fs)', toc);
title(str);
subplot(2, 3, 2);
tic
sobelHIMG = imfilter(img, sobelHorizontal);
imshow(sobelHIMG);
str = sprintf('Sobel Horizontal (%fs)', toc);
title(str);
subplot(2, 3, 3);
tic
robertHIMG = imfilter(img, robertHorizontal);
imshow(robertHIMG);
str = sprintf('Robert Horizontal (%fs)', toc);
title(str);
subplot(2, 3, 4);
tic
prewittVIMG = imfilter(img, prewittVertical);
imshow(prewittVIMG);
str = sprintf('Prewitt Vertical (%fs)', toc);
title(str);
subplot(2, 3, 5);
tic
sobelVIMG = imfilter(img, sobelVertical);
imshow(sobelVIMG);
str = sprintf('Sobel Vertical (%fs)', toc);
title(str);
subplot(2, 3, 6);
tic
robertVIMG = imfilter(img, robertVertical);
imshow(robertVIMG);
str = sprintf('Robert Vertical (%fs)', toc);
title(str);

% new figure and subplot for indoor image
figure(4);
subplot(2, 3, 1);
tic
prewittHIMG = imfilter(indoorIMG, prewittHorizontal);
imshow(prewittHIMG);
str = sprintf('Prewitt Horizontal (%fs)', toc);
title(str);
subplot(2, 3, 2);
tic
sobelHIMG = imfilter(indoorIMG, sobelHorizontal);
imshow(sobelHIMG);
str = sprintf('Sobel Horizontal (%fs)', toc);
title(str);
subplot(2, 3, 3);
tic
robertHIMG = imfilter(indoorIMG, robertHorizontal);
imshow(robertHIMG);
str = sprintf('Robert Horizontal (%fs)', toc);
title(str);
subplot(2, 3, 4);
tic
prewittVIMG = imfilter(indoorIMG, prewittVertical);
imshow(prewittVIMG);
str = sprintf('Prewitt Vertical (%fs)', toc);
title(str);
subplot(2, 3, 5);
tic
sobelVIMG = imfilter(indoorIMG, sobelVertical);
imshow(sobelVIMG);
str = sprintf('Sobel Vertical (%fs)', toc);
title(str);
subplot(2, 3, 6);
tic
robertVIMG = imfilter(indoorIMG, robertVertical);
imshow(robertVIMG);
str = sprintf('Robert Vertical (%fs)', toc);
title(str);

% new figure and subplot for detailed image
detailIMG = imread('detail.jpg');
figure(5);
subplot(2, 3, 1);
tic
prewittHIMG = imfilter(detailIMG, prewittHorizontal);
imshow(prewittHIMG);
str = sprintf('Prewitt Horizontal (%fs)', toc);
title(str);
subplot(2, 3, 2);
tic
sobelHIMG = imfilter(detailIMG, sobelHorizontal);
imshow(sobelHIMG);
str = sprintf('Sobel Horizontal (%fs)', toc);
title(str);
subplot(2, 3, 3);
tic
robertHIMG = imfilter(detailIMG, robertHorizontal);
imshow(robertHIMG);
str = sprintf('Robert Horizontal (%fs)', toc);
title(str);
subplot(2, 3, 4);
tic
prewittVIMG = imfilter(detailIMG, prewittVertical);
imshow(prewittVIMG);
str = sprintf('Prewitt Vertical (%fs)', toc);
title(str);
subplot(2, 3, 5);
tic
sobelVIMG = imfilter(detailIMG, sobelVertical);
imshow(sobelVIMG);
str = sprintf('Sobel Vertical (%fs)', toc);
title(str);
subplot(2, 3, 6);
tic
robertVIMG = imfilter(detailIMG, robertVertical);
imshow(robertVIMG);
str = sprintf('Robert Vertical (%fs)', toc);
title(str);

% The Prewitt, Sobel, and Robert filters are used for edge detection. The
% Prewitt and Sobel filters are used for detecting horizontal and vertical
% edges, while the Robert filter is better for detecting 45 degree angles
% in an image. The vertical and horizontal lines are very defined in the
% Sobel and Prewitt images while the Robert image has much fainter lines
% following a 45 degree angle.