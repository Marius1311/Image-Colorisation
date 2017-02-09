function varargout = colorisation_gui(varargin)
% COLORISATION_GUI MATLAB code for colorisation_gui.fig
%      COLORISATION_GUI, by itself, creates a new COLORISATION_GUI or raises the existing
%      singleton*.
%
%      H = COLORISATION_GUI returns the handle to a new COLORISATION_GUI or the handle to
%      the existing singleton*.
%
%      COLORISATION_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COLORISATION_GUI.M with the given input arguments.
%
%      COLORISATION_GUI('Property','Value',...) creates a new COLORISATION_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before colorisation_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to colorisation_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help colorisation_gui

% Last Modified by GUIDE v2.5 09-Feb-2017 12:25:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @colorisation_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @colorisation_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before colorisation_gui is made visible.
function colorisation_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to colorisation_gui (see VARARGIN)

handles.image = imread('Images/borad2.jpg'); % Load a picture and store it
handles.current_data = handles.image;
imshow(handles.current_data); % Shows the picture

 % add a continuous value change listener
 if ~isfield(handles,'hListener')
    handles.hListener = ...
        addlistener(handles.slider1,'ContinuousValueChange',@respondToContSlideCallback);
 end

% set the slider range and step size
numSteps = 200000;
set(handles.slider1, 'Min', 1);
set(handles.slider1, 'Max', numSteps);
set(handles.slider1, 'Value', 100);
set(handles.slider1, 'SliderStep', [10/(numSteps -1) , 10/(numSteps-1) ]);

% save the current/last slider value
handles.lastSliderVal = get(handles.slider1,'Value');

handles.nPixels = get(handles.slider1,'Value');



% Choose default command line output for colorisation_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes colorisation_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = colorisation_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load_image.
function load_image_Callback(hObject, eventdata, handles)
% hObject    handle to load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% This is the button the load a file
[filename1,filepath1]=uigetfile({'*.*','All Files'},...
  'Select Data File 1');
  % cd(filepath1);
% handles.raw=load([filepath1 filename1]);

disp([filepath1, filename1]);
handles.image = imread([filepath1, filename1]);

axes(handles.axes3); 
imshow(handles.image); % Shows the picture

cla(handles.axes1,'reset');
set(handles.messages, 'String', '');
set(handles.messages2, 'String', 'nice choice');


% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in make_grey.
function make_grey_Callback(hObject, eventdata, handles)
% hObject    handle to make_grey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = handles.image;
handles.grey = handles.image;
handles.grey(:, :, 1) = A(:, :, 1) * 0.3 + A(:, :, 2) * 0.59 + A(:, :, 3)*  0.11; % Conversion to greyscale using some parameters
handles.grey(:, :, 2) = handles.grey(:, :, 1); % Just put the same information in the other layers
handles.grey(:, :, 3) = handles.grey(:, :, 1);
handles.current_data = handles.grey;
axes(handles.axes1); 
imshow(handles.grey);

set(handles.messages, 'String', 'removed all color information');

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in add_color.
function add_color_Callback(hObject, eventdata, handles)
% hObject    handle to add_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% handles = guidata(hObject);

% Load
G = handles.grey;
A = handles.image;

% First, we need to choose some random pixels
npixels = floor(handles.nPixels); % Number of pixels

[m, n, ~] = size(G); % Size of the picture array
pixels = randi(n*m, npixels, 1); % create som random integers in the right range

% Give color Info
for i = 1:npixels
    % column:
    if floor(pixels(i)/m) == pixels(i)/m % Basically, this prevents problems at the bottom end of the matrix due to rounding
        column = floor(pixels(i)/m); 
    else
        column = floor(pixels(i)/m) + 1; 
    end
    % row:
    row = pixels(i) - (column - 1) * m;
    G(row, column, 1:3) = A(row, column, 1:3);
end

set(handles.messages, 'String', ['added ', num2str(npixels), ' color pixels']);
     
axes(handles.axes1); 
imshow(G);

handles.grey = G;
handles.image = A;
% Update handles structure
guidata(hObject, handles);


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% % --- Executes on slider movement.
% function slider1_Callback(hObject, eventdata, handles)
% % hObject    handle to slider1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'Value') returns position of slider
% %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% 
% nPixels = get(handles.slider1,'Value');
% set(handles.pixelsNumber, 'String', num2str(nPixels));
% handles.nPixels = nPixels;
% 
% % Update handles structure
% guidata(hObject, handles);


 % --- Executes on slider movement.
 function respondToContSlideCallback(hObject, eventdata)
 % hObject    handle to slider1 (see GCBO)
 % eventdata  reserved - to be defined in a future version of MATLAB

 % Hints: get(hObject,'Value') returns position of slider
 %        get(hObject,'Min') and get(hObject,'Max') to determine range of sli
 % first we need the handles structure which we can get from hObject
 handles = guidata(hObject);

 % get the slider value and convert it to the nearest integer that is less
 % than this value
 newVal = floor(get(hObject,'Value'));

 % set the slider value to this integer which will be in the set {1,2,3,...,12,13}
 set(hObject,'Value',newVal);
 
 % now only do something in response to the slider movement if the 
 % new value is different from the last slider value
 if newVal ~= handles.lastSliderVal
 % it is different, so we have moved up or down from the previous intege
     % save the new value
     handles.lastSliderVal = newVal;
     guidata(hObject,handles);
     set(handles.pixelsNumber, 'String', ['n =  ' num2str(get(hObject,'Value'))]);
     handles.npixels = get(hObject,'Value');
    % display the current value of the slider
   % disp(['at slider value ' num2str(get(hObject,'Value'))]);
 end
 
 % Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over slider1.
function slider1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function messages_CreateFcn(hObject, eventdata, handles)
% hObject    handle to messages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function uipushtool2_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load_image_Callback(hObject, eventdata, handles);
