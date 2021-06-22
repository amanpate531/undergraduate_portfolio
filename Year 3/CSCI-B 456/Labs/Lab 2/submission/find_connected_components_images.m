function resulting_image = find_connected_components_images(connectivity)
    img = imread('iu.png');
    red = img(:, :, 1);
    green = img(:, :, 2);
    blue = img(:, :, 3);
    dim1 = size(red);
    input_matrix = zeros(dim1(1), dim1(2));
    for i = 1:(dim1(1)* dim1(2))
        input_matrix(i) = (red(i) + green(i) + blue(i)) / 3;
    end
    binMatrix = input_matrix > mean(input_matrix);
    dim = size(binMatrix);
    visitedCounter = zeros(dim(1), dim(2));
    resultingMatrix = zeros(dim(1), dim(2));
    
    % keeps track of the current connected component
    currentGroup = 1;
    
    % calculates number of elements in the input array
    elements = dim(1) * dim(2);
    
    % initializes the stack for use in future steps
    stack = zeros(1, elements);
    
    % keeps track of where the top of the stack is
    stackCounter = 0;
    % checks if the given connectivity value implies 4-way neighborhood
    % (direct connections)
    if connectivity == 4
        for i = 1:elements
            
            % checks if the binary value of the element is 0
            if binMatrix(i) == 0
                % adds the current element to the visited matrix, keeps
                % track of which elements have been visited thus far
                visitedCounter(i) = 1;
            elseif visitedCounter(i) == 1
            else
                % adds the current element to the stack and iterates the
                % stack counter
                stack(1) = i;
                stackCounter = stackCounter + 1;
                % the loop continues until all neighbors of the given
                % element have been visited (DFS)
                while stackCounter > 0
                    % effectively 'pops' the top element from the stack and
                    % saves it in a temporary variable
                    temp = stack(stackCounter);
                    stack(stackCounter) = 0;
                    stackCounter = stackCounter - 1;
                    if visitedCounter(temp) == 1
                    else
                        % adds the temporary variable to the visited array
                        visitedCounter(temp) = 1;
                        % associates the temporary variable with a
                        % component for future coloring
                        resultingMatrix(temp) = currentGroup;
                        % initialization of neighbor positions
                        neighbor1 = temp + dim(1);
                        neighbor2 = temp - dim(1);
                        neighbor3 = temp - 1;
                        neighbor4 = temp + 1;
                        % each neighbor is checked to see if it is out of
                        % the bounds of the array, if it has been visited
                        % already, and if its value is 1
                        % If all the conditions are met, the neighbor is
                        % added to the stack and will later be set as
                        % the central element and its neighbors will be
                        % found and processed.
                        if (not (neighbor1 > elements))
                            if visitedCounter(neighbor1) == 0
                                if binMatrix(neighbor1) == 1
                                    stack(stackCounter + 1) = neighbor1;
                                    stackCounter = stackCounter + 1;
                                end
                            end
                        end
                        if (not (neighbor2 <= 0))
                            if visitedCounter(neighbor2) == 0
                                if binMatrix(neighbor2) == 1
                                    stack(stackCounter + 1) = neighbor2;
                                    stackCounter = stackCounter + 1;
                                end
                            end
                        end
                        if (not (neighbor3 <= 0))
                            if visitedCounter(neighbor3) == 0
                                if binMatrix(neighbor3) == 1
                                    stack(stackCounter + 1) = neighbor3;
                                    stackCounter = stackCounter + 1;
                                end
                            end
                        end
                        if (not (neighbor4 > elements))
                            if visitedCounter(neighbor4) == 0
                                if binMatrix(neighbor4) == 1
                                    stack(stackCounter + 1) = neighbor4;
                                    stackCounter = stackCounter + 1;
                                end
                            end
                        end
                    end
                end
                % iterates the component number once all neighbors of the
                % original element have been visited
                currentGroup = currentGroup + 1;
            end
        end
    end
    % checks if the connectivity value given corresponds to an 8-way
    % neighborhood (direct and diagonal)
    if connectivity == 8
        for i = 1:elements
            if binMatrix(i) == 0
                visitedCounter(i) = 1;
            elseif visitedCounter(i) == 1
            else
                stack(1) = i;
                while stackCounter > 0
                    temp = stack(stackCounter);
                    stack(stackCounter) = 0;
                    stackCounter = stackCounter - 1;
                    if visitedCounter(temp) == 1
                    else
                        visitedCounter(temp) = 1;
                        resultingMatrix(temp) = currentGroup;
                        neighbor1 = temp + dim(1);
                        neighbor2 = temp - dim(1);
                        neighbor3 = temp - 1;
                        neighbor4 = temp + 1;
                        neighbor5 = temp + dim(1) - 1;
                        neighbor6 = temp + dim(1) + 1;
                        neighbor7 = temp - dim(1) - 1;
                        neighbor8 = temp - dim(1) + 1;
                        if (not (neighbor1 > elements))
                            if visitedCounter(neighbor1) == 0
                                if binMatrix(neighbor1) == 1
                                    stack(stackCounter + 1) = neighbor1;
                                    stackCounter = stackCounter + 1;
                                end
                            end
                        end
                        if (not (neighbor2 <= 0))
                            if visitedCounter(neighbor2) == 0
                                if binMatrix(neighbor2) == 1
                                    stack(stackCounter + 1) = neighbor2;
                                    stackCounter = stackCounter + 1;
                                end
                            end
                        end
                        if (not (neighbor3 <= 0))
                            if visitedCounter(neighbor3) == 0
                                if binMatrix(neighbor3) == 1
                                    stack(stackCounter + 1) = neighbor3;
                                    stackCounter = stackCounter + 1;
                                end
                            end
                        end
                        if (not (neighbor4 > elements))
                            if visitedCounter(neighbor4) == 0
                                if binMatrix(neighbor4) == 1
                                    stack(stackCounter + 1) = neighbor4;
                                    stackCounter = stackCounter + 1;
                                end
                            end
                        end
                        if (not (neighbor5 > elements))
                            if visitedCounter(neighbor5) == 0
                                if binMatrix(neighbor5) == 1
                                    stack(stackCounter + 1) = neighbor5;
                                    stackCounter = stackCounter + 1;
                                end
                            end
                        end
                        if (not (neighbor6 > elements))
                            if visitedCounter(neighbor6) == 0
                                if binMatrix(neighbor6) == 1
                                    stack(stackCounter + 1) = neighbor6;
                                    stackCounter = stackCounter + 1;
                                end
                            end
                        end
                        if (not (neighbor7 <= 0))
                            if visitedCounter(neighbor7) == 0
                                if binMatrix(neighbor7) == 1
                                    stack(stackCounter + 1) = neighbor7;
                                    stackCounter = stackCounter + 1;
                                end
                            end
                        end
                        if (not (neighbor8 <= 0))
                            if visitedCounter(neighbor8) == 0
                                if binMatrix(neighbor8) == 1
                                    stack(stackCounter + 1) = neighbor8;
                                    stackCounter = stackCounter + 1;
                                end
                            end
                        end
                    end
                end
                currentGroup = currentGroup + 1;
            end
        end
    end
    % checks if the given connectivity value corresponds to a diagonal
    % neighborhood (only diagonals)
    if connectivity == 'D'
        for i = 1:elements
            if binMatrix(i) == 0
                visitedCounter(i) = 1;
            elseif visitedCounter(i) == 1
            else
                stack(1) = i;
                while stackCounter > 0
                    temp = stack(stackCounter);
                    stack(stackCounter) = 0;
                    stackCounter = stackCounter - 1;
                    if visitedCounter(temp) == 1
                    else
                        visitedCounter(temp) = 1;
                        resultingMatrix(temp) = currentGroup;
                        neighbor1 = temp + dim(1) + 1;
                        neighbor2 = temp - dim(1) - 1;
                        neighbor3 = temp - dim(1) + 1;
                        neighbor4 = temp + dim(1) - 1;
                        if (not (neighbor1 > elements))
                            if visitedCounter(neighbor1) == 0
                                if binMatrix(neighbor1) == 1
                                    stack(stackCounter + 1) = neighbor1;
                                    stackCounter = stackCounter + 1;
                                end
                            end
                        end
                        if (not (neighbor2 <= 0))
                            if visitedCounter(neighbor2) == 0
                                if binMatrix(neighbor2) == 1
                                    stack(stackCounter + 1) = neighbor2;
                                    stackCounter = stackCounter + 1;
                                end
                            end
                        end
                        if (not (neighbor3 <= 0))
                            if visitedCounter(neighbor3) == 0
                                if binMatrix(neighbor3) == 1
                                    stack(stackCounter + 1) = neighbor3;
                                    stackCounter = stackCounter + 1;
                                end
                            end
                        end
                        if (not (neighbor4 > elements))
                            if visitedCounter(neighbor4) == 0
                                if binMatrix(neighbor4) == 1
                                    stack(stackCounter + 1) = neighbor4;
                                    stackCounter = stackCounter + 1;
                                end
                            end
                        end
                    end
                end
                currentGroup = currentGroup + 1;
            end
        end
    end
    redChannel = zeros(dim(1), dim(2));
    greenChannel = zeros(dim(1), dim(2));
    blueChannel = zeros(dim(1), dim(2));
    redRandom = randi([0,255], 1, elements);
    redRandom(1) = 0;
    greenRandom = randi([0,255], 1, elements);
    greenRandom(1) = 0;
    blueRandom = randi([0,255], 1, elements);
    greenRandom(1) = 0;
    for i = 1:elements
        index = resultingMatrix(i) + 1;
        redChannel(i) =  redRandom(index) * 0.5;
        greenChannel(i) = greenRandom(index) * 0.5;
        blueChannel(i) = blueRandom(index) * 0.5;
    end
    disp(currentGroup);
end