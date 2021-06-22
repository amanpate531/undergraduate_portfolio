subplot(3, 3, 1);
line_img = imread("line_image.png");
imshow(line_img);
title('Original');

N = [-3, -3, 5; -3, 0, 5; -3, -3, 5];
NW = [-3, 5, 5; -3, 0, 5; -3, -3, -3];
W = [5, 5, 5; -3, 0, -3; -3, -3, -3];
SW = [5, 5, -3; 5, 0, -3; -3, -3, -3];
S = [5, -3, -3; 5, 0, -3; 5, -3, -3];
SE = [-3, -3, -3; 5, 0, -3; 5, 5, -3];
E = [-3, -3, -3; -3, 0, -3; 5, 5, 5];
NE = [-3, -3, -3; -3, 0, 5; -3, 5, 5];

subplot(3, 3, 2);
NImg = imfilter(lineImg, N);
imshow(NImg);
title('N');

subplot(3, 3, 3);
NWImg = imfilter(lineImg, NW);
imshow(NWImg);
title('NW');

subplot(3, 3, 4);
WImg = imfilter(lineImg, W);
imshow(WImg);
title('W');

subplot(3, 3, 5);
SWImg = imfilter(lineImg, SW);
imshow(SWImg);
title('SW');

subplot(3, 3, 6);
SImg = imfilter(lineImg, S);
imshow(SImg);
title('S');

subplot(3, 3, 7);
SEImg = imfilter(lineImg, SE);
imshow(SEImg);
title('SE');

subplot(3, 3, 8);
EImg = imfilter(lineImg, E);
imshow(EImg);
title('E');

subplot(3, 3, 9);
NEImg = imfilter(lineImg, NE);
imshow(NEImg);
title('NE');