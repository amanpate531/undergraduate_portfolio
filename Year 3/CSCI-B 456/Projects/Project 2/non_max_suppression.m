function result = non_max_suppression(gradient_matrix, angle_matrix)

dim = size(gradient_matrix);
result = zeros(dim);
for i = 1:dim(1)
    for j = 1:dim(2)
        if angle_matrix(i, j) > pi/4
            if j == 1
                result(i, j) = gradient_matrix(i, j);
            elseif gradient_matrix(i, j-1) > gradient_matrix(i, j)
                result(i, j) = 0;
            else
                result(i, j) = gradient_matrix(i, j);
            end
        end
        
        if angle_matrix(i, j) < pi/4 && angle_matrix(i, j) > -pi/4
            if i == dim(1)
                result(i, j) = gradient_matrix(i, j);
            elseif gradient_matrix(i+1, j) > gradient_matrix(i, j)
                result(i, j) = 0;
            else
                result(i, j) = gradient_matrix(i, j);
            end
        end
        
        if angle_matrix(i, j) < -pi/4
            if j == dim(2)
                result(i, j) = gradient_matrix(i, j);
            elseif gradient_matrix(i, j+1) > gradient_matrix(i, j)
                result(i, j) = 0;
            else
                result(i, j) = gradient_matrix(i, j);
            end
        end
    end
end
end
