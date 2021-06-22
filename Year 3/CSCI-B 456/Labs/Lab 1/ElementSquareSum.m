M = [1 2 3; 4 5 6; 7 8 9];     % Initial Array
MSquared = M.^2;               % Applies square function to each element in array, creates new array
display(sum(sum(MSquared)));   % Finds the sum of all columns, then finds sum of elements in 1x3 array