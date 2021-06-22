N = [10 0 10 0; 0 10 20 10; 21 0 10 20; 0 10 20 10];  % Initial Array
dim = size(N);                                        % Creates a 1D array with the width and height of N
elementCount = dim(1) * dim(2);                       % Calculates the number of elements in N, saves as elementCount

for i = 1:elementCount                                % Iterates i from 1 to elementCount, adding 1 to i between iterations
    if N(i) == 20                                     % Checks if current element is 20
        N(i) = 1;                                     % Sets the value of the current element to 1
    elseif N(i) == 10                                 % Checks if current element is 10
        N(i) = 0;                                     % Sets the value of the current element to 0
    elseif N(i) == 0                                  % Checks if current element is 0
        N(i) = -1;                                    % Sets the value of the current element to -1
    end                                               % Ends the if statement, all other elements are unchanged
end                                                   % Ends the for loop when elementCount is reached
disp(N);                                              % Displays the final matrix