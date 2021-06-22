img = imread('sample-gates.jpg');     % Creates an image matrix from the given image
dim = size(img);                      % Creates a 1D array with the height, width, and depth of the given array
width = dim(2);                       % Extracts the width from the dimension array
height = dim(1);                      % Extracts the height from the dimension array
pixels = width * height;              % The total number of pixels can be found by multiplying the width and height of the image
megapixels = pixels / 1000000;        % 1 megapixel = 1000000 pixels, dividing the total number of pixels by 1 million yields the number of megapixels
disp(width);                          % Displays the width of the image (in pixels)
disp(height);                         % Displays the height of the image (in pixels)
disp(pixels);                         % Displays the number of pixels in the image
disp(megapixels);                     % Displays the number of megapixels in the image
