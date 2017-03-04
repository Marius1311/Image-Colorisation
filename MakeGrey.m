function [ handles ] = MakeGrey(handles)
%This fucntion removes all colour information

%Load the color Image
A = handles.image;

% Create a new handle with this image
handles.grey = handles.image;

% Convert to greysclae
handles.grey(:, :, 1) = A(:, :, 1) * 0.3 + A(:, :, 2) * 0.59 + A(:, :, 3)*  0.11; % Conversion to greyscale using some parameters
handles.grey(:, :, 2) = handles.grey(:, :, 1); % Just put the same information in the other layers
handles.grey(:, :, 3) = handles.grey(:, :, 1);

% Chose axes for plotting
axes(handles.axes1); 

% Plot image
imshow(handles.grey);

% Create another handle that will later be used to store partical color
% information
handles.someColor = handles.grey;

% Give an output message
set(handles.messages, 'String', 'removed all color information');

end

