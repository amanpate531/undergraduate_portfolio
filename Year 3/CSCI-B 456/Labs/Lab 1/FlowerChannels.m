img = imread('flower.png');                      % Creates 3D matrix from given image
red = img(:,:,1);                                % Red, green, and blue 2D matrices are layers 1, 2, and 3 of the image matrix, respectively.
green = img(:,:,2);                              % The colons allow us to extract the entire layer, rather than specific rows or columns.
blue = img(:,:,3);
dim = size(img);                                 % Dimensions of image are needed to create the black matrix to be used later
width = dim(2);                                  % Width of image extracted from dimension array
height = dim(1);                                 % Height of image extracted from dimension array
black = zeros(height, width);                    % Creates the black matrix for use in the next step
redChannel = cat(3, red, black, black);          % Each of the extracted color matrices needs to be reformed into an image matrix.
greenChannel = cat(3, black, green, black);      % This is done by filling in the other two color components with black.
blueChannel = cat(3, black, black, blue);
imwrite(redChannel, './flower-red.png');         % Writes and saves the images in the desired location
imwrite(greenChannel, './flower-green.png');
imwrite(blueChannel, './flower-blue.png');