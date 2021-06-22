A = [-1 0; 1 2];                                  % Initializes matrix A
B = [1 2; 3 4];                                   % Initializes matrix B
prompt = "Enter an integer between 1 and 3: ";    % Instructions for what the user should input when prompted
x = input(prompt);                                % Prompts the user to input a value

if x == 1                                         % Checks if the input is 1
    display(A * B);                               % Displays the matrix product of A and B
elseif x == 2                                     % Checks if the input is 2
    display((dot(A,B)));                          % Displays the dot product of A and B
elseif x == 3                                     % Checks if the input is 3
    display((dot(A,B,2)));                        % Displays the dot product of A and B, treating rows as vectors
else                                              
    disp("Invalid option");                       % Displays "Invalid option" if the user does not enter 1, 2, or 3
end                                               % Ends the if statement