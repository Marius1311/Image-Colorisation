function [ handles ] = GetFigure( handles )
%This function loads in an image

% This is the button the load a file
[filename1,filepath1]=uigetfile({'*.*','All Files'},...
'Select Data File 1');

if isnumeric(filepath1) && isnumeric(filename1)
if filename1 == 0 || filepath1 == 0
    return
end
end

disp([filepath1, filename1]);

handles.image = imread([filepath1, filename1]);

axes(handles.axes3); 
imshow(handles.image); % Shows the picture

cla(handles.axes1,'reset');
cla(handles.axes4,'reset');

% Get the size of the image
[m, n, ~] = size(handles.image);

% Give out information about the image size
message = sprintf('This image has a size of %1.0f by %1.0f',m, n );
set(handles.messages2, 'String', message);
set(handles.messages, 'String', '');



end

