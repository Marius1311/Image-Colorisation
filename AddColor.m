function [handles] = AddColor(handles)
%This function adds some color pixels back in. Pixels are randomly chosen.

% Load full color image and partial color image
A = handles.image;
S = handles.someColor;
    
%Determine the number of desired color pixels
npixels = floor(handles.nPixels); 

% Size of the picture array
[m, n, ~] = size(S);

% create som random integers in the right range
% pixels = randi(n*m, npixels, 1); 
pixels = randperm(n*m, npixels)';

% Save the location of the color Pixels in a handle:
handles.colorPixels = pixels;

% Introduce color info
for i = 1:npixels
    z = pixels(i);
    [row, column] = GetPosition(z, m);
    S(row, column, 1:3) = A(row, column, 1:3);
end

%Give out a message to the user
set(handles.messages, 'String', ['added ', num2str(npixels), ' color pixels']);
     
% Chose axes and display the partial color image
axes(handles.axes1); 
imshow(S);

%Update the handle
handles.someColor = S;

end

