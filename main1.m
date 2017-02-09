%% Image Colorisation First Steps

% This is supposed to be able to read in an Image, convert it to back and
% white, and to put some color back in.

%% Read in Image

A = imread('Images/borad2.jpg'); % Load a picture and store it
imshow(A); % Shows the picture

%% Convert to Greyscale

G(:, :, 1) = A(:, :, 1) * 0.3 + A(:, :, 2) * 0.59 + A(:, :, 3)*  0.11; % Conversion to greyscale using some parameters
G(:, :, 2) = G(:, :, 1); % Just put the same information in the other layers
G(:, :, 3) = G(:, :, 1);
imshow(G);

%% Bring back in some colour

% First, we need to choose some random pixels
npixels = 1000; % Number of pixels
[m, n, l] = size(G); % Size of the picture array
pixels = randi(n*m, npixels, 1); % create som random integers in the right range

% If I just give Matlab one index to acess a Matrix, it goes columnwise
for i = 1:npixels
    % column:
    if floor(pixels(i)/m) == pixels(i)/m % Basically, this prevents problems at the bottom end of the matrix due to rounding
        column = floor(pixels(i)/m); 
    else
        column = floor(pixels(i)/m) + 1; 
    end
    % row:
    row = pixels(i) - (column - 1) * n;
    G(column, row, 1:3) = A(column, row, 1:3);
end

% We can compare now:
subplot(1, 2, 1), imshow(G), title('Greyscale with Color');
subplot(1, 2, 2), imshow(A), title('Original Image');






