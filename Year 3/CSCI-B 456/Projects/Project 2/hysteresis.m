function result = hysteresis(input_image, threshold)
    maxImage = ordfilt2(input_image, 8, [1, 1, 1; 1, 0, 1; 1, 1, 1]);
    dim = size(maxImage);
    result = zeros(dim(1), dim(2));
    for i = 1:dim(1)
        for j = 1:dim(2)
            if maxImage(i,j) < threshold
                result(i, j) = 0;
            else
                result(i, j) = maxImage(i, j);
            end
        end
    end
end