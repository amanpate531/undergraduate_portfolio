img = imread('iu.png');
prompt = "What type of transformation would you like to perform? (Translation, Scale, Shear, or Rotation)\n";
x = input(prompt);
lowercase = lower(x);
dim = size(img);
red = img(:, :, 1);
green = img(:, :, 2);
blue = img(:, :, 3);
deletedRed = zeros(dim(1), dim(2), 'uint8');
deletedGreen = zeros(dim(1), dim(2), 'uint8');
deletedBlue = zeros(dim(1), dim(2), 'uint8');
subplot(1, 3, 1);
imshow(img);
title('Original');
newRed = ones(dim(1), dim(2), 'uint8') + cast(255, 'uint8');
newGreen = ones(dim(1), dim(2), 'uint8') + cast(255, 'uint8');
newBlue = ones(dim(1), dim(2), 'uint8')  + cast(255, 'uint8');
reverseRed = zeros(dim(1), dim(2), 'uint8');
reverseGreen = zeros(dim(1), dim(2), 'uint8');
reverseBlue = zeros(dim(1), dim(2), 'uint8');
if strcmp(lowercase, "translation")
    promptTranslationX = "\nDisplacement along the x axis: ";
    xTranslate = input(promptTranslationX);
    promptTranslationY = "\nDisplacement along the y axis: ";
    yTranslate = input(promptTranslationY);
    translationMatrix = [1, 0, xTranslate; 0, 1, yTranslate; 0, 0, 1];
    for i = 1:(dim(1))
        for j = 1: (dim(2))
            newPosition = translationMatrix * [i; j; 1];
            if (newPosition(1) <= 0 || newPosition(1) > (dim(1)) || newPosition(2) <= 0 || newPosition(2) > (dim(2)))
                deletedRed(i, j) = red(i, j);
                deletedGreen(i, j) = green(i, j);
                deletedBlue(i, j) = blue(i, j);
            else
                newRed(newPosition(1), newPosition(2)) = red(i, j);
                newBlue(newPosition(1), newPosition(2)) = blue(i, j);
                newGreen(newPosition(1), newPosition(2)) = green(i, j);
            end
        end
    end
    subplot(1, 3, 2);
    translatedImg = cat(3, newRed, newGreen, newBlue);
    imshow(translatedImg);
    title('Translated');
    translationMatrix = [1, 0, (-1 * xTranslate); 0, 1, (-1 * yTranslate); 0, 0, 1];
    for i = 1:(dim(1))
        for j = 1: (dim(2))
            newPosition = translationMatrix * [i; j; 1];
            if (newPosition(1) <= 0 || newPosition(1) > (dim(1)) || newPosition(2) <= 0 || newPosition(2) > (dim(2)))
                continue;
            end
            reverseRed(newPosition(1), newPosition(2)) = newRed(i, j);
            reverseBlue(newPosition(1), newPosition(2)) = newBlue(i, j);
            reverseGreen(newPosition(1), newPosition(2)) = newGreen(i, j);
        end
    end
    subplot(1, 3, 3);
    totalRed = red - (deletedRed + reverseRed);
    totalGreen = green - (deletedGreen + reverseGreen);
    totalBlue = blue - (deletedBlue + reverseBlue);
    comparison = cat(3, totalRed, totalGreen, totalBlue);
    imshow(comparison);
    title('Original - Reversed');
elseif strcmp(lowercase, "scale")
    promptScaleX = "\nScale factor along x axis: ";
    scaleX = input(promptScaleX);
    promptScaleY = "\nScale factor along y axis: ";
    scaleY = input(promptScaleY);
    translationMatrix = [scaleY, 0, 0; 0, scaleX, 0; 0, 0, 1];
    for i = 1:(dim(1))
        for j = 1: (dim(2))
            newPosition = translationMatrix * [i; j; 1];
            if (newPosition(1) <= 0 || newPosition(1) > (dim(1)) || newPosition(2) <= 0 || newPosition(2) > (dim(2)))
                deletedRed(i, j) = red(i, j);
                deletedGreen(i, j) = green(i, j);
                deletedBlue(i, j) = blue(i, j);
            else
                newRed(int64(newPosition(1)), cast(newPosition(2), 'double')) = red(i, j);
                newGreen(int64(newPosition(1)), cast(newPosition(2), 'double')) = green(i, j);
                newBlue(int64(newPosition(1)), cast(newPosition(2), 'double')) = blue(i, j);
            end
        end
    end
    subplot(1, 3, 2);
    translatedImg = cat(3, newRed, newGreen, newBlue);
    imshow(translatedImg);
    title('Scaled');
    translationMatrix = [1/scaleY, 0, 0; 0, cast((1 / scaleX), 'double'), 0; 0, 0, 1];
    for i = 1:(dim(1))
        for j = 1: (dim(2))
            newPosition = translationMatrix * [i; j; 1];
            if (newPosition(1) <= 0 || newPosition(1) > (dim(1)) || newPosition(2) <= 0 || newPosition(2) > (dim(2)))
                continue;
            end
            if (int64(newPosition(1)) == 0)
                newPosition(1) = 1;
            end
            if (int64(newPosition(2)) == 0)
                newPosition(1) = 1;
            end
            reverseRed(int64(newPosition(1)), cast(newPosition(2), 'int64')) = newRed(i, j);
            reverseBlue(int64(newPosition(1)), cast(newPosition(2), 'int64')) = newBlue(i, j);
            reverseGreen(int64(newPosition(1)), cast(newPosition(2), 'int64')) = newGreen(i, j);
        end
    end
    subplot(1, 3, 3);
    totalRed = red - (deletedRed + reverseRed);
    totalGreen = green - (deletedGreen + reverseGreen);
    totalBlue = blue - (deletedBlue + reverseBlue);
    comparison = cat(3, totalRed, totalGreen, totalBlue);
    imshow(comparison);
    title('Original - Reversed');
elseif strcmp(lowercase, "shear")
    promptShearX = "\nShear factor along the x axis: ";
    xShear = input(promptShearX);
    promptShearY = "\nShear factor along the y axis: ";
    yShear = input(promptShearY);
    translationMatrix = [1, xShear, 0; yShear, 1, 0; 0, 0, 1];
    for i = 1:(dim(1))
        for j = 1: (dim(2))
            newPosition = translationMatrix * [i; j; 1];
            if (newPosition(1) <= 0 || newPosition(1) > (dim(1)) || newPosition(2) <= 0 || newPosition(2) > (dim(2)))
                deletedRed(i, j) = red(i, j);
                deletedGreen(i, j) = green(i, j);
                deletedBlue(i, j) = blue(i, j);
            else
                newRed(newPosition(1), newPosition(2)) = red(i, j);
                newBlue(newPosition(1), newPosition(2)) = blue(i, j);
                newGreen(newPosition(1), newPosition(2)) = green(i, j);
            end
        end
    end
    subplot(1, 3, 2);
    translatedImg = cat(3, newRed, newGreen, newBlue);
    imshow(translatedImg);
    title('Sheared');
    denom = (1 - xShear * yShear);
    translationMatrix = [1/denom, -1 * xShear / denom, 0; (-1 * yShear / denom), 1/denom, 0; 0, 0, 1];
    for i = 1:(dim(1))
        for j = 1: (dim(2))
            newPosition = translationMatrix * [i; j; 1];
            if (newPosition(1) <= 0 || newPosition(1) > (dim(1)) || newPosition(2) <= 0 || newPosition(2) > (dim(2)))
                continue;
            end
            reverseRed(newPosition(1), newPosition(2)) = newRed(i, j);
            reverseBlue(newPosition(1), newPosition(2)) = newBlue(i, j);
            reverseGreen(newPosition(1), newPosition(2)) = newGreen(i, j);
        end
    end
    subplot(1, 3, 3);
    totalRed = red - (deletedRed + reverseRed);
    totalGreen = green - (deletedGreen + reverseGreen);
    totalBlue = blue - (deletedBlue + reverseBlue);
    comparison = cat(3, totalRed, totalGreen, totalBlue);
    imshow(comparison);
    title('Original - Reversed');
elseif strcmp(lowercase, "rotation")
    promptAngle = "\nAngle of rotation in radians: ";
    q = input(promptAngle);
    translationMatrix = [cos(q), -sin(q), 0; sin(q), cos(q), 0; 0, 0, 1];
    for i = 1:(dim(1))
        for j = 1: (dim(2))
            newPosition = translationMatrix * [i; j; 1];
            if (newPosition(1) <= 0 || newPosition(1) > (dim(1)) || newPosition(2) <= 0 || newPosition(2) > (dim(2)))
                deletedRed(i, j) = red(i, j);
                deletedGreen(i, j) = green(i, j);
                deletedBlue(i, j) = blue(i, j);
            else
                if (int64(newPosition(1)) == 0)
                    newPosition(1) = 1;
                end
                if (int64(newPosition(2)) == 0)
                    newPosition(2) = 1;
                end
                newRed(int64(newPosition(1)), cast(newPosition(2), 'int64')) = red(i, j);
                newBlue(int64(newPosition(1)), cast(newPosition(2), 'int64')) = blue(i, j);
                newGreen(int64(newPosition(1)), cast(newPosition(2), 'int64')) = green(i, j);
            end
        end
    end
    subplot(1, 3, 2);
    translatedImg = cat(3, newRed, newGreen, newBlue);
    imshow(translatedImg);
    title('Rotated');
    denom = (cos(q) * cos(q)) + (sin(q) * sin(q));
    translationMatrix = [cos(q)/denom, sin(q)/denom, 0; (-1 * sin(q) / denom), cos(q) / denom, 0; 0, 0, 1];
    for i = 1:(dim(1))
        for j = 1: (dim(2))
            newPosition = translationMatrix * [i; j; 1];
            if (newPosition(1) <= 0 || newPosition(1) > (dim(1)) || newPosition(2) <= 0 || newPosition(2) > (dim(2)))
                continue;
            end
            if (int64(newPosition(1)) == 0)
                newPosition(1) = 1;
            end
            if (int64(newPosition(2)) == 0)
                newPosition(2) = 1;
            end
            reverseRed(int64(newPosition(1)), (int64(newPosition(2)))) = newRed(i, j);
            reverseBlue(int64(newPosition(1)), (int64(newPosition(2)))) = newBlue(i, j);
            reverseGreen(int64(newPosition(1)), (int64(newPosition(2)))) = newGreen(i, j);
        end
    end
    subplot(1, 3, 3);
    totalRed = red - (deletedRed + reverseRed);
    totalGreen = green - (deletedGreen + reverseGreen);
    totalBlue = blue - (deletedBlue + reverseBlue);
    comparison = cat(3, totalRed, totalGreen, totalBlue);
    imshow(comparison);
    title('Original - Reversed');
end