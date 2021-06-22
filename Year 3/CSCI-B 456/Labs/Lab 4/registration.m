img = imread('drone2.jpg');
translatedIMG = imtranslate(img, [50, -40]);
rotatedIMG = imrotate(translatedIMG, 3);
rectangle = [75, 60, 530, 350];
rotateCrop = imcrop(rotatedIMG, rectangle);
imgCrop = imcrop(img, rectangle);
cpselect(rotateCrop, imgCrop);
tform = fitgeotrans(movingPoints,fixedPoints,'NonreflectiveSimilarity');
registered = imwarp(rotateCrop, tform);
registerTranslate = imtranslate(registered, [-70, 2]);
combination = imfuse(registerTranslate, imgCrop);

subplot(1, 4, 1);
imshow(img);
title('Original');

subplot(1, 4, 2);
imshow(rotatedIMG);
title('Rotation + Translation');

subplot(1, 4, 3);
imshow(registered);
title('Registered');

subplot(1, 4, 4);
imshow(combination);
title('Combination');
