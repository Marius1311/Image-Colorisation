function varargout = colorisation_gui3(varargin)
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

% Last Modified by GUIDE v2.5 04-Mar-2017 23:37:48

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

% Most things are encapsulated in the following function
handles = open(handles);

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

handles = GetFigure(handles);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in make_grey.
function make_grey_Callback(hObject, eventdata, handles)
% hObject    handle to make_grey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = MakeGrey(handles);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in add_color.
function add_color_Callback(hObject, eventdata, handles)
% hObject    handle to add_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% handles = guidata(hObject);
handles = AddColor(handles);

% Update handles structure
guidata(hObject, handles);


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function messages_CreateFcn(hObject, eventdata, handles)
% hObject    handle to messages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in recolor.
function recolor_Callback(hObject, eventdata, handles)
% hObject    handle to recolor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

message = 'Thinking...';
set(handles.results, 'String', message);
guidata(hObject, handles);

handles = recolor(hObject, handles);

%Update handles structure
guidata(hObject, handles);

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

nPixels = get(handles.slider1,'Value');
set(handles.pixelsNumber, 'String', num2str(nPixels));
handles.nPixels = nPixels;

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function recolor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to recolor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function delta_Callback(hObject, eventdata, handles)
% hObject    handle to delta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of delta as text
%        str2double(get(hObject,'String')) returns contents of delta as a double


% --- Executes during object creation, after setting all properties.
function delta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sigma1_Callback(hObject, eventdata, handles)
% hObject    handle to sigma1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sigma1 as text
%        str2double(get(hObject,'String')) returns contents of sigma1 as a double


% --- Executes during object creation, after setting all properties.
function sigma1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sigma1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sigma2_Callback(hObject, eventdata, handles)
% hObject    handle to sigma2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sigma2 as text
%        str2double(get(hObject,'String')) returns contents of sigma2 as a double


% --- Executes during object creation, after setting all properties.
function sigma2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sigma2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pedit_Callback(hObject, eventdata, handles)
% hObject    handle to pedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pedit as text
%        str2double(get(hObject,'String')) returns contents of pedit as a double


% --- Executes during object creation, after setting all properties.
function pedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gauss.
function gauss_Callback(hObject, eventdata, handles)
% hObject    handle to gauss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.radB = 0;

% Hint: get(hObject,'Value') returns toggle state of gauss

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in compsupp.
function compsupp_Callback(hObject, eventdata, handles)
% hObject    handle to compsupp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.radB = 1;

% Hint: get(hObject,'Value') returns toggle state of compsupp

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in GetHandles.
function GetHandles_Callback(hObject, eventdata, handles)
% hObject    handle to GetHandles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles


% --- Executes on button press in worspace.
function worspace_Callback(hObject, eventdata, handles)
% hObject    handle to worspace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
assignin('base', 'A', handles.image);
assignin('base', 'G', handles.grey);
assignin('base', 'S', handles.someColor);
assignin('base', 'colorPixels', handles.colorPixels);
assignin('base', 'Recolored', handles.recolored);

delta = str2double(get(handles.delta, 'String'));
p = str2double(get(handles.pedit, 'String'));
sigma1 = str2double(get(handles.sigma1, 'String'));
sigma2 = str2double(get(handles.sigma2, 'String'));

assignin('base', 'delta', delta);
assignin('base', 'p', p);
assignin('base', 'sigma1', sigma1);
assignin('base', 'sigma2', sigma2);


% --- Executes on button press in matlab.
function matlab_Callback(hObject, eventdata, handles)
% hObject    handle to matlab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of matlab

% Sets the solver to be matlabs backslash
handles.solver = 0;

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in gmres.
function gmres_Callback(hObject, eventdata, handles)
% hObject    handle to gmres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gmres

% Sets the solver to be GMRES a la Marius
handles.solver = 1;

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
