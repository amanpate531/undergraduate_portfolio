pepperImg = imread("peppers.tiff");
cameraImg = imread("cameraman.png");
coinImg = imread("coins.png");

subplot(3, 6, 1);
imshow(pepperImg);
title('Original');

pepperImg2 = rgb2gray(pepperImg);

subplot(3, 6, 2);
tic
pepper1 = edge(pepperImg2, 'Canny', 0.1);
str = sprintf('Peppers 0.1 Canny (%fs)', toc);
imshow(pepper1);
title(str);

subplot(3, 6, 3);
tic
pepper2 = edge(pepperImg2, 'Canny', 0.25);
str = sprintf('Peppers 0.25 Canny (%fs)', toc);
imshow(pepper2);
title(str);

subplot(3, 6, 4);
tic
pepper3 = edge(pepperImg2, 'Canny', 0.3);
str = sprintf('Peppers 0.3 Canny (%fs)', toc);
imshow(pepper3);
title(str);

subplot(3, 6, 5);
tic
pepper4 = edge(pepperImg2, 'Canny', 0.5);
str = sprintf('Peppers 0.5 Canny (%fs)', toc);
imshow(pepper4);
title(str);

subplot(3, 6, 6);
tic
pepper5 = edge(pepperImg2, 'Canny', 0.8);
str = sprintf('Peppers 0.8 Canny (%fs)', toc);
imshow(pepper5);
title(str);

subplot(3, 6, 7);
imshow(cameraImg);
title('Original');

subplot(3, 6, 8);
tic
camera1 = edge(cameraImg, 'Canny', 0.1);
str = sprintf('Cameraman 0.1 Canny (%fs)', toc);
imshow(camera1);
title(str);

subplot(3, 6, 9);
tic
camera2 = edge(cameraImg, 'Canny', 0.25);
str = sprintf('Cameraman 0.25 Canny (%fs)', toc);
imshow(camera2);
title(str);

subplot(3, 6, 10);
tic
camera3 = edge(cameraImg, 'Canny', 0.3);
str = sprintf('Cameraman 0.3 Canny (%fs)', toc);
imshow(camera3);
title(str);

subplot(3, 6, 11);
tic
camera4 = edge(cameraImg, 'Canny', 0.5);
str = sprintf('Cameraman 0.5 Canny (%fs)', toc);
imshow(camera4);
title(str);

subplot(3, 6, 12);
tic
camera5 = edge(cameraImg, 'Canny', 0.8);
str = sprintf('Cameraman 0.8 Canny (%fs)', toc);
imshow(camera5);
title(str);

subplot(3, 6, 13);
imshow(coinImg);
title('Original');

subplot(3, 6, 14);
tic
coin1 = edge(coinImg, 'Canny', 0.1);
str = sprintf('Coins 0.1 Canny (%fs)', toc);
imshow(coin1);
title(str);

subplot(3, 6, 15);
tic
coin2 = edge(coinImg, 'Canny', 0.25);
str = sprintf('Coins 0.25 Canny (%fs)', toc);
imshow(coin2);
title(str);

subplot(3, 6, 16);
tic
coin3 = edge(coinImg, 'Canny', 0.3);
str = sprintf('Coins 0.3 Canny (%fs)', toc);
imshow(coin3);
title(str);

subplot(3, 6, 17);
tic
coin4 = edge(coinImg, 'Canny', 0.5);
str = sprintf('Coins 0.5 Canny (%fs)', toc);
imshow(coin4);
title(str);

subplot(3, 6, 18);
tic
coin5 = edge(coinImg, 'Canny', 0.8);
str = sprintf('Coins 0.8 Canny (%fs)', toc);
imshow(coin5);
title(str);


figure(2);

subplot(3, 6, 1);
imshow(pepperImg);
title('Original');

pepperImg2 = rgb2gray(pepperImg);

subplot(3, 6, 2);
tic
pepper1 = edge(pepperImg2, 'log', 0.005);
str = sprintf('Peppers 0.005 LoG (%fs)', toc);
imshow(pepper1);
title(str);

subplot(3, 6, 3);
tic
pepper2 = edge(pepperImg2, 'log', 0.01);
str = sprintf('Peppers 0.01 LoG (%fs)', toc);
imshow(pepper2);
title(str);

subplot(3, 6, 4);
tic
pepper3 = edge(pepperImg2, 'log', 0.02);
str = sprintf('Peppers 0.02 LoG (%fs)', toc);
imshow(pepper3);
title(str);

subplot(3, 6, 5);
tic
pepper4 = edge(pepperImg2, 'log', 0.05);
str = sprintf('Peppers 0.05 LoG (%fs)', toc);
imshow(pepper4);
title(str);

subplot(3, 6, 6);
tic
pepper5 = edge(pepperImg2, 'log', 0.07);
str = sprintf('Peppers 0.07 LoG (%fs)', toc);
imshow(pepper5);
title(str);

subplot(3, 6, 7);
imshow(cameraImg);
title('Original');

subplot(3, 6, 8);
tic
camera1 = edge(cameraImg, 'log', 0.005);
str = sprintf('Cameraman 0.005 LoG (%fs)', toc);
imshow(camera1);
title(str);

subplot(3, 6, 9);
tic
camera2 = edge(cameraImg, 'log', 0.01);
str = sprintf('Cameraman 0.01 LoG (%fs)', toc);
imshow(camera2);
title(str);

subplot(3, 6, 10);
tic
camera3 = edge(cameraImg, 'log', 0.02);
str = sprintf('Cameraman 0.02 LoG (%fs)', toc);
imshow(camera3);
title(str);

subplot(3, 6, 11);
tic
camera4 = edge(cameraImg, 'log', 0.05);
str = sprintf('Cameraman 0.05 LoG (%fs)', toc);
imshow(camera4);
title(str);

subplot(3, 6, 12);
tic
camera5 = edge(cameraImg, 'log', 0.07);
str = sprintf('Cameraman 0.07 LoG (%fs)', toc);
imshow(camera5);
title(str);

subplot(3, 6, 13);
imshow(coinImg);
title('Original');

subplot(3, 6, 14);
tic
coin1 = edge(coinImg, 'log', 0.005);
str = sprintf('Coins 0.005 LoG (%fs)', toc);
imshow(coin1);
title(str);

subplot(3, 6, 15);
tic
coin2 = edge(coinImg, 'log', 0.01);
str = sprintf('Coins 0.01 LoG (%fs)', toc);
imshow(coin2);
title(str);

subplot(3, 6, 16);
tic
coin3 = edge(coinImg, 'log', 0.02);
str = sprintf('Coins 0.02 LoG (%fs)', toc);
imshow(coin3);
title(str);

subplot(3, 6, 17);
tic
coin4 = edge(coinImg, 'log', 0.05);
str = sprintf('Coins 0.05 LoG (%fs)', toc);
imshow(coin4);
title(str);

subplot(3, 6, 18);
tic
coin5 = edge(coinImg, 'log', 0.07);
str = sprintf('Coins 0.07 LoG (%fs)', toc);
imshow(coin5);
title(str);

