function move_boat(input_matrix)
    boatImg = imread("boat.jpg");
%     Conversion to grayscale
    boatImg = rgb2gray(boatImg);
%     Conversion into square image
    boatImg = imresize(boatImg, [820 820]);
%     The following code was adapted from https://stackoverflow.com/questions/28139202/can-we-rotate-an-image-in-matlab-filled-with-background-color-of-original-image
%     Creating general rotation functions
    TU = @(I) imrotate(I, 30, 'crop');
    TD = @(I) imrotate(I, -30, 'crop');
%     Creating masks to have white background after rotation
    maskU = TU(ones(820, 820))==1;
    maskD = TD(ones(820, 820))==1;
    boatUpFin = ones(820, 820);
    boatDownFin = ones(820, 820);
%     Apply general rotation functions to boat image and masks
    boatUp = TU(boatImg);
    boatDown = TD(boatImg);
    boatUpFin(maskU) = boatUp(maskU);
    boatDownFin(maskD) = boatDown(maskD);
%     Resizing the three resulting images using the method that produces the highest detail
    boatImg = imresize(boatImg, [40 40], 'nearest');
    boatUpFin = imresize(boatUpFin, [40 40], 'nearest');
    boatDownFin = imresize(boatDownFin, [40 40], 'nearest');    
    imwrite(boatUpFin, "boatUp.png");
    imwrite(boatDownFin, "boatDown.png");
%     Randomly generated position of wooden block
    block_y = floor(35 + 320*rand(1))-35;
    
    dim = size(input_matrix);
    block_x = dim(2) - 15;
%     Creating full scene matrix
    img_matrix = ones(dim(1), dim(2));
    boat_top_left_y = dim(1)/2 - 20;
%     Superimposing boat image and wooden block on scene
    img_matrix((1:size(boatImg,1))+ boat_top_left_y, (1:size(boatImg,2)), :) = boatImg;
    img_matrix(((1:70)+ block_y), ((1:15) + block_x)) = 0;
    subplot(7, 6, 1);
    imshow(img_matrix);
    title("Original");
    verticalImg = img_matrix;
%     Removing boat to isolate wooden block for edge detection
    verticalImg((1:dim(1)), (1:size(boatImg,2))) = 1;
%     Detecting edges using Roberts filter (produced sharpest results)
    verticalEdgeImage = edge(verticalImg, 'Roberts');
%     Finding the connected components in the edge-detected image
    CC = bwconncomp(verticalEdgeImage);
    block_pixels = CC.PixelIdxList{1};
    top_left = block_pixels(1);
    block_x = ceil(top_left/500);
    block_y = mod(top_left, 500);
    counter = 1;
    while block_x > 0
        counter = counter + 1;
        
        if (boat_top_left_y <= 0 || boat_top_left_y > dim(1))
            disp("Your boat has sunk!");
            break;
        end
        if (boat_top_left_y  < block_y - 40 || boat_top_left_y > block_y + 70)
            subplot(7, 6, counter);
            tic
            verticalImg = img_matrix;
        %     Removing boat to isolate wooden block for edge detection
            verticalImg((1:dim(1)), (1:size(boatImg,2))) = 1;
        %     Detecting edges using Roberts filter (produced sharpest results)
            verticalEdgeImage = edge(verticalImg, 'Roberts');
        %     Finding the connected components in the edge-detected image
            CC = bwconncomp(verticalEdgeImage);
            block_pixels = CC.PixelIdxList{1};
            top_left = block_pixels(1);
            block_x = ceil(top_left/500);
            block_y = mod(top_left, 500);
            img_matrix((1:dim(1)), (1:40)) = 1;
            img_matrix((1:size(boatImg,1))+ boat_top_left_y, (1:size(boatImg,2)), :) = boatImg;
            img_matrix(((1:70) + block_y), ((1:15) + block_x)) = 1;
%             Move block left by 30 pixels
            block_x = block_x - 30;
            img_matrix(((1:70) + block_y), ((1:15) + block_x)) = 0;
            str = sprintf("None, Time Taken: %fs", toc);
            imshow(img_matrix);
            title(str);
            imwrite(img_matrix, "boatStraightEx.png");
        end
        if (boat_top_left_y >= block_y - 40 && boat_top_left_y <= block_y + 70 && boat_top_left_y + 20 <= block_y + 35)
            subplot(7, 6, counter);
            tic
            verticalImg = img_matrix;
        %     Removing boat to isolate wooden block for edge detection
            verticalImg((1:dim(1)), (1:size(boatImg,2))) = 1;
        %     Detecting edges using Roberts filter (produced sharpest results)
            verticalEdgeImage = edge(verticalImg, 'Roberts');
        %     Finding the connected components in the edge-detected image
            CC = bwconncomp(verticalEdgeImage);
            block_pixels = CC.PixelIdxList{1};
            top_left = block_pixels(1);
            block_x = ceil(top_left/500);
            block_y = mod(top_left, 500);
            img_matrix((1:dim(1)), (1:40)) = 1;
%             Move boat up by 10 pixels
            boat_top_left_y = boat_top_left_y - 10;
%             Superimpose the upward-facing boat image
            img_matrix((1:size(boatImg,1))+ boat_top_left_y, (1:size(boatImg,2)), :) = boatUpFin;
            img_matrix(((1:70) + block_y), ((1:15) + block_x)) = 1;
%             Move block left by 30 pixels
            block_x = block_x - 30;
            img_matrix(((1:70) + block_y), ((1:15) + block_x)) = 0;
            str = sprintf("Up, Time Taken: %fs", toc);
            imshow(img_matrix);
            title(str);
            imwrite(img_matrix, "boatUpEx.png");
        end
        if (boat_top_left_y >= block_y - 40 && boat_top_left_y <= block_y + 70 && boat_top_left_y + 20 > block_y + 35)
            subplot(7, 6, counter);
            tic
            verticalImg = img_matrix;
        %     Removing boat to isolate wooden block for edge detection
            verticalImg((1:dim(1)), (1:size(boatImg,2))) = 1;
        %     Detecting edges using Roberts filter (produced sharpest results)
            verticalEdgeImage = edge(verticalImg, 'Roberts');
        %     Finding the connected components in the edge-detected image
            CC = bwconncomp(verticalEdgeImage);
            block_pixels = CC.PixelIdxList{1};
            top_left = block_pixels(1);
            block_x = ceil(top_left/500);
            block_y = mod(top_left, 500);
            img_matrix((1:dim(1)), (1:40)) = 1;
%             Move the boat down by 10 pixels
            boat_top_left_y = boat_top_left_y + 10;
%             Superimpose the downward-facing boat image
            img_matrix((1:size(boatImg,1))+ boat_top_left_y, (1:size(boatImg,2)), :) = boatDownFin;
            img_matrix(((1:70) + block_y), ((1:15) + block_x)) = 1;
%             Move block left by 30 pixels
            block_x = block_x - 30;
            img_matrix(((1:70) + block_y), ((1:15) + block_x)) = 0;
            str = sprintf("Down, Time Taken: %fs", toc);
            imshow(img_matrix);  
            title(str);
            imwrite(img_matrix, "boatDownEx.png");
        end
    end
end