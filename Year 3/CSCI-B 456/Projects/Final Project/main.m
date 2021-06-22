tic
fileName = "./TestData/210503/P1010005.jpg";
save_loc = append("./TestData/chars/", extractBetween(fileName, 11, 27, 'Boundaries', 'exclusive'));
mkdir(save_loc);
img1 = imread(fileName);

dim = size(img1);

figure(1);
subplot(2, 2, 1);
imshow(img1);
title('Original');

gray = rgb2gray(img1);
subplot(2, 2, 2);
imshow(gray);
title('Grayscale');

gray_eq = histeq(gray);
subplot(2, 2, 3);
imshow(gray_eq);
title('Equalized');

% imwrite(gray_eq, './equalized.jpg');

filtered = edge(gray_eq, 'roberts');
subplot(2, 2, 4);
imshow(filtered);
title('Roberts Edges');

% imwrite(filtered, './roberts.jpg');

rect = strel('line', 15, 90);
eroded = imerode(filtered, rect, 'same');

% imwrite(eroded, './eroded.jpeg');

closed = imclose(eroded, strel('rect', [100, 200]));
figure(2);
subplot(2, 1, 1);
imshow(eroded);
title('Vertical Line Eroded');
subplot(2, 1, 2);
imshow(closed);
title('Rectangular Morphological Closing');

% imwrite(closed, './closed.jpeg');
CC = bwconncomp(closed);
numRegions = CC.NumObjects;
acceptableRegions = [];
for i = 1:numRegions
    xMin = 1000000;
    xMax = -1;
    yMin = 1000000;
    yMax = -1;
    region = CC.PixelIdxList{1, i};
    for j = 1:length(region)
        x = ceil(region(j)/dim(1));
        y = region(j) - (x-1) * (dim(1));
        if x < xMin
            xMin = x;
        elseif x > xMax
            xMax = x;
        end
        if y < yMin
            yMin = y;
        elseif y > yMax
            yMax = y;
        end
    end
    if (xMax - xMin)/(yMax - yMin) > 3
        acceptableRegions = [acceptableRegions [[xMin xMax yMin yMax]]];
    end
end

xMin = acceptableRegions(1);
xMax = acceptableRegions(2);
yMin = acceptableRegions(3);
yMax = acceptableRegions(4);

ocrT = ocr(img1, [xMin yMin-15 xMax-xMin yMax-yMin+15], 'TextLayout', 'Line');
toc

mask = zeros(dim(1), dim(2));
for i = yMin:yMax
    for j = xMin:xMax
        mask(i, j) = 1;
    end 
end
% imwrite(mask, './mask.jpeg');

masked = uint8(mask) .* gray_eq;
% imwrite(masked, './plate_location.jpeg');
plate = zeros(acceptableRegions(4)-acceptableRegions(3) + 30, acceptableRegions(2)-acceptableRegions(1));

for i = yMin-15:yMax+15
    for j = xMin:xMax
        plate(i - yMin + 16, j - xMin + 1) = gray_eq(i, j);
    end 
end

figure(3);
subplot(4, 2, 1);
plate_eq = histeq(uint8(plate));
imshow(plate_eq);
title('Equalized Plate');

% imwrite(uint8(plate_eq), './plate_eq.jpeg');

numbers = imcomplement(imbinarize(imcomplement(plate_eq), 0.6));
subplot(4, 2, 2);
imshow(numbers);
title('Binarized');

% imwrite(numbers, './numbers.jpeg');

fullyBlack = [];
dim = size(numbers);

for i = 1:dim(2)
    blackCounter = 0;
    for j = 1:dim(1)
        if numbers(j, i) == 0
            blackCounter = blackCounter + 1;
        end
    end
    if blackCounter > 0.9 * dim(1)
        fullyBlack = [fullyBlack i];
    end
end

numbers(:, fullyBlack) = [];
subplot(4, 2, 3);
imshow(numbers);
title('Noise Removal 1');

dim = size(numbers);
someBlack = [];
for i = 1:15
    blackCounter = 0;
    for j = 1:dim(1)
        if numbers(j, i) == 0
            blackCounter = blackCounter + 1;
        end
    end
    if blackCounter > 0.6 * dim(1) || blackCounter < 0.1 * dim(1)
        someBlack = [someBlack i];
    end
end

for i = (dim(2)-15):dim(2)
    sum_cols = sum(numbers, 1);
    if sum_cols(i) < 0.4 * dim(1) || sum_cols(i) > 0.9 * dim(1)
        someBlack = [someBlack i];
    end
end

numbers(:, someBlack) = [];
subplot(4, 2, 4);
imshow(numbers);
title('Noise Removal 2');

dim = size(numbers);
mostlyBlack = [];
for i = 1:dim(1)
    sum_rows = sum(numbers, 2);
    if sum_rows(i) < 0.5 * dim(2)
        mostlyBlack = [mostlyBlack i];
    end
end

numbers(mostlyBlack, :) = [];
subplot(4, 2, 5);
imshow(numbers);
title('Noise Removal 3');

dim = size(numbers);

numbers = imcomplement(bwareaopen(imcomplement(numbers), 100));

someBlack = [];
for i = 1:15
    blackCounter = 0;
    for j = 1:dim(1)
        if numbers(j, i) == 0
            blackCounter = blackCounter + 1;
        end
    end
    if blackCounter > 0.6 * dim(1) || blackCounter < 0.05 * dim(1)
        someBlack = [someBlack i];
    end
end

numbers(:, someBlack) = [];
subplot(4, 2, 6);
imshow(numbers);
title('Noise Removal 4');

dim = size(numbers);

mostlyWhite = [];
for i = 1:dim(1)
    sum_rows = sum(numbers, 2);
    if sum_rows(i) > 0.95 * dim(2)
        mostlyWhite = [mostlyWhite i];
    end
end

numbers(mostlyWhite, :) = [];
subplot(4, 2, 7);
imshow(numbers);
title('Noise Removal 5');

ocrT = ocr(numbers, 'TextLayout', 'Line');

kernel = ones(3) / 3 ^ 2;
blurryImage = conv2(single(numbers), kernel, 'same');
newNumbers = blurryImage > 0.65;
newNumbers = imcomplement(bwareaopen(imcomplement(newNumbers), 100));

ocrT = ocr(newNumbers, 'TextLayout', 'Line');

% imwrite(numbers, 'plateText.jpeg');
CC = bwconncomp(imcomplement(numbers));

dim = size(numbers);
figure(4);
for i = 1:CC.NumObjects
    subplot(1, CC.NumObjects, i);
    region = CC.PixelIdxList{1, i};
    first = region(1);
    last = region(length(region));
    firstX = ceil(first/dim(1));
    lastX = ceil(last/dim(1));
    h = dim(1);
    A = numbers(:, firstX:lastX);
    redFact = 28 / h;
    A = imresize(A, redFact);
    w = (lastX-firstX) * redFact;
    pad = ceil((28 - w) / 2);
    if pad < 0
        imshow(A);
    else
        A = padarray(A,[0 pad],1,'pre');
        A = padarray(A,[0 pad],1,'post');
%         imwrite(A, append(save_loc, sprintf('/char%d.jpeg', i)));
        imshow(A);
    end
end
