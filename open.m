function [ handles ] = open(handles )
%Opening Function

axes(handles.axes3); 
handles.image = imread('Images/borad2.jpg'); % Load a picture and store it
imshow(handles.image); % Shows the picture

 % add a continuous value change listener
 if ~isfield(handles,'hListener')
     fhandle = @(hObject, eventdata) respondToContSlideCallback(hObject, eventdata);
    handles.hListener = ...
        addlistener(handles.slider1,'ContinuousValueChange',fhandle);
 end

% set the slider range and step size
numSteps = 1000;
set(handles.slider1, 'Min', 1);
set(handles.slider1, 'Max', numSteps);
set(handles.slider1, 'Value', 100);
set(handles.slider1, 'SliderStep', [10/(numSteps -1) , 10/(numSteps-1) ]);

% save the current/last slider value
handles.lastSliderVal = get(handles.slider1,'Value');

% Number of pixels that will have color information
handles.nPixels = get(handles.slider1,'Value');

% Get the size of the image
[m, n, ~] = size(handles.image);

% Give out information about the image size
message = sprintf('This image has a size of %1.0f by %1.0f',m, n );
set(handles.messages2, 'String', message);

% Sets the radial basis function that will be used later, 0 standts for
% gauss, 1 stands for radial basis
handles.radB = 0;

% Sets the standart solver for the linear system to be matlab backslash
handles.solver = 0;

end

