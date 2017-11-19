function varargout = GUI_control(varargin)
% GUI_CONTROL MATLAB code for GUI_control.fig
%      GUI_CONTROL, by itself, creates a new GUI_CONTROL or raises the existing
%      singleton*.
%
%      H = GUI_CONTROL returns the handle to a new GUI_CONTROL or the handle to
%      the existing singleton*.
%
%      GUI_CONTROL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_CONTROL.M with the given input arguments.
%
%      GUI_CONTROL('Property','Value',...) creates a new GUI_CONTROL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_control_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_control_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_control

% Last Modified by GUIDE v2.5 19-Nov-2017 11:26:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_control_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_control_OutputFcn, ...
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


% --- Executes just before GUI_control is made visible.
function GUI_control_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_control (see VARARGIN)

% Choose default command line output for GUI_control
handles.output = hObject;

handles.m1 = 18.0; % (kg) Cart mass
handles.m2 = 12.0; % (kg) pole mass
handles.l = 5.0; % (m) pendulum (pole) length
handles.time = 10.0; % (s) durantion time of simulation
handles.angle = 45; % (degree) initial angle

set(handles.sld_time,'Value',handles.time);
set(handles.sld_m1,'Value',handles.m1);
set(handles.sld_m2,'Value',handles.m2);
set(handles.sld_l,'Value',handles.l);
set(handles.sld_angle,'Value',handles.angle);

set(handles.edit_time,'string',num2str(handles.time));
set(handles.edit_m1,'string',num2str(handles.m1));
set(handles.edit_m2,'string',num2str(handles.m2));
set(handles.edit_l,'string',num2str(handles.l));
set(handles.edit_angle,'string',num2str(handles.angle));

clearvars -global -except hObject handles eventdata

simulation 

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_control wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_control_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_run.
function btn_run_Callback(hObject, eventdata, handles)
% hObject    handle to btn_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% clear florHandle cartHandle poleHandle bobHandle starHandle ... 
%     r_wheelHandle l_wheelHandle

clearvars -global -except hObject handles eventdata

simulation 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on slider movement.
function sld_time_Callback(hObject, eventdata, handles)
% hObject    handle to sld_m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.time = get(hObject,'Value');
set(handles.edit_time,'string',num2str(handles.time));

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function sld_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sld_m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_time_Callback(hObject, eventdata, handles)
% hObject    handle to edit_m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit_m1 as text
%        str2double(get(hObject,'String')) returns contents of edit_m1 as a double

handles.time = str2double(get(hObject,'String'));
set(handles.sld_time,'Value',handles.time);

% Update handles structure
guidata(hObject, handles); 


% --- Executes during object creation, after setting all properties.
function edit_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on slider movement.
function sld_m1_Callback(hObject, eventdata, handles)
% hObject    handle to sld_m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.m1 = get(hObject,'Value');
set(handles.edit_m1,'string',num2str(handles.m1));

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function sld_m1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sld_m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_m1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit_m1 as text
%        str2double(get(hObject,'String')) returns contents of edit_m1 as a double

handles.m1 = str2double(get(hObject,'String'));
set(handles.sld_m1,'Value',handles.m1);

% Update handles structure
guidata(hObject, handles); 


% --- Executes during object creation, after setting all properties.
function edit_m1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sld_m2_Callback(hObject, eventdata, handles)
% hObject    handle to sld_m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.m2 = get(hObject,'Value');
set(handles.edit_m2,'string',num2str(handles.m2));

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function sld_m2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sld_m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_m2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_m2 as text
%        str2double(get(hObject,'String')) returns contents of edit_m2 as a double

handles.m2 = str2double(get(hObject,'String'));
set(handles.sld_m2,'Value',handles.m2);

% Update handles structure
guidata(hObject, handles); 

% --- Executes during object creation, after setting all properties.
function edit_m2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sld_l_Callback(hObject, eventdata, handles)
% hObject    handle to sld_l (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.l = get(hObject,'Value');
set(handles.edit_l,'string',num2str(handles.l));

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function sld_l_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sld_l (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_l_Callback(hObject, eventdata, handles)
% hObject    handle to edit_l (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_l as text
%        str2double(get(hObject,'String')) returns contents of edit_l as a double

% handles.l = str2double(get(hObject,'String'));
% set(handles.sld_l,'Value',handles.l);

% Update handles structure
guidata(hObject, handles); 

% --- Executes during object creation, after setting all properties.
function edit_l_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_l (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sld_angle_Callback(hObject, eventdata, handles)
% hObject    handle to sld_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.angle = get(hObject,'Value');
set(handles.edit_angle,'string',num2str(handles.angle));

% Update handles structure
guidata(hObject, handles); 

% --- Executes during object creation, after setting all properties.
function sld_angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sld_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function edit_angle_Callback(hObject, eventdata, handles)
% hObject    handle to edit_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_angle as text
%        str2double(get(hObject,'String')) returns contents of edit_angle as a double

handles.angle = str2double(get(hObject,'String'));
set(handles.sld_angle,'Value',handles.angle);

% Update handles structure
guidata(hObject, handles); 

% --- Executes during object creation, after setting all properties.
function edit_angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
