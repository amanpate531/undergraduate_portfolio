subplot(1, 4, 1);
pepperImg = imread("peppers.tiff");
imshow(pepperImg);
title('Original');

level = [1, 4, 6, 4, 1];
edges = [-1, -2, 0, 2, 1];
spot = [-1, 0, 2, 0, -1];
ripple = [1, -4, 6, -4, 1];

redChannel = pepperImg(:, :, 1);
greenChannel = pepperImg(:, :, 2);
blueChannel = pepperImg(:, :, 3);
subplot(1, 4, 2);
tic
pepperRed = conv2(conv2(redChannel, level), edges);
pepperGreen = conv2(conv2(greenChannel, level), edges);
pepperBlue = conv2(conv2(blueChannel, level), edges);
peppers1 = cat(3, pepperRed, pepperGreen, pepperBlue);
str = sprintf('Average then Edge (%fs)', toc);
imshow(peppers1);
title(str);
imwrite(peppers1, "C:\Users\ahuertas\Desktop\peppers1.tiff");

TwoDMatrix = level' * edges;
TwoDMatrix2 = edges' * level;

subplot(1, 4, 3);
tic
crossImg = imfilter(pepperImg, TwoDMatrix);
str = sprintf('Average * Edge (%fs)', toc);
imshow(crossImg);
title(str);
imwrite(crossImg, "C:\Users\ahuertas\Desktop\peppers2.tiff")

subplot(1, 4, 4);
tic
crossImg2 = imfilter(pepperImg, TwoDMatrix2);
str = sprintf('Edge * Average (%fs)', toc);
imshow(crossImg2);
title(str);

% The images are not the same, applying the filters one by one produced an
% image with many white pixels, while the other image had colored pixels in
% those areas.

% The cross product method is faster by a factor of ~7