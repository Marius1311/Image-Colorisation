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

% Last Modified by GUIDE v2.5 08-Feb-2017 23:51:51

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
handles.nPixels = 100;


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


% --- Executes on button press in make_grey.
function make_grey_Callback(hObject, eventdata, handles)
% hObject    handle to make_grey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = handles.image;
handles.grey(:, :, 1) = A(:, :, 1) * 0.3 + A(:, :, 2) * 0.59 + A(:, :, 3)*  0.11; % Conversion to greyscale using some parameters
handles.grey(:, :, 2) = handles.grey(:, :, 1); % Just put the same information in the other layers
handles.grey(:, :, 3) = handles.grey(:, :, 1);
handles.current_data = handles.grey;
axes(handles.axes1); 
imshow(handles.grey);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in add_color.
function add_color_Callback(hObject, eventdata, handles)
% hObject    handle to add_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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
    row = pixels(i) - (column - 1) * n;
    G(column, row, 1:3) = A(column, row, 1:3);
end

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


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
nPixels = get(handles.slider1,'Value');
disp(nPixels);
set(handles.pixelsNumber, 'String', num2str(nPixels));
handles.nPixels = nPixels;

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
