subplot(1, 5, 1);
lineImg = imread("line_image.png");
imshow(lineImg);
title('Original');

horizontalK = [-1, -1, -1; 2, 2, 2; -1, -1, -1];
forty_fivePosK = [2, -1, -1; -1, 2, -1; -1, -1, 2];
verticalK = [-1, 2, -1; -1, 2, -1; -1, 2, -1];
forty_fiveNegK = [-1, -1, 2; -1, 2, -1; 2, -1, -1];

subplot(1, 5, 2);
horizontalImg = imfilter(lineImg, horizontalK);
imshow(horizontalImg);
title('Horizontal');

subplot(1, 5, 3);
forty_fivePosImg = imfilter(lineImg, forty_fivePosK);
imshow(forty_fivePosImg);
title('+45 degrees');

subplot(1, 5, 4);
verticalImg = imfilter(lineImg, verticalK);
imshow(verticalImg);
title('Vertical');

subplot(1, 5, 5);
forty_fiveNegImg = imfilter(lineImg, forty_fiveNegK);
imshow(forty_fiveNegImg)
title('-45 degrees')