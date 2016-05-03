function varargout = rhythmconfig(varargin)
% RHYTHMCONFIG M-file for rhythmconfig.fig
%      RHYTHMCONFIG, by itself, creates a new RHYTHMCONFIG or raises the existing
%      singleton*.
%
%      H = RHYTHMCONFIG returns the handle to a new RHYTHMCONFIG or the handle to
%      the existing singleton*.
%
%      RHYTHMCONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RHYTHMCONFIG.M with the given input arguments.
%
%      RHYTHMCONFIG('Property','Value',...) creates a new RHYTHMCONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rhythmconfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rhythmconfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rhythmconfig

% Last Modified by GUIDE v2.5 03-May-2016 17:05:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rhythmconfig_OpeningFcn, ...
                   'gui_OutputFcn',  @rhythmconfig_OutputFcn, ...
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


% --- Executes just before rhythmconfig is made visible.
function rhythmconfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rhythmconfig (see VARARGIN)

% Choose default command line output for rhythmconfig
handles.output = hObject;

% Load constants
handles.constants = load_constants();
set(handles.deltaf1, 'String', handles.constants.get('deltaf1'));
set(handles.deltaf2, 'String', handles.constants.get('deltaf2'));
set(handles.thetaf1, 'String', handles.constants.get('thetaf1'));
set(handles.thetaf2, 'String', handles.constants.get('thetaf2'));
set(handles.alphaf1, 'String', handles.constants.get('alphaf1'));
set(handles.alphaf2, 'String', handles.constants.get('alphaf2'));
set(handles.betaf1, 'String', handles.constants.get('betaf1'));
set(handles.betaf2, 'String', handles.constants.get('betaf2'));
set(handles.gammaf1, 'String', handles.constants.get('gammaf1'));
set(handles.gammaf2, 'String', handles.constants.get('gammaf2'));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rhythmconfig wait for user response (see UIRESUME)
% uiwait(handles.rhythmconfig);


% --- Outputs from this function are returned to the command line.
function varargout = rhythmconfig_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in okrythms.
function okrythms_Callback(hObject, eventdata, handles)
% hObject    handle to okrythms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global deltaf1 deltaf2 thetaf1 thetaf2 alphaf1 alphaf2 betaf1 betaf2 gammaf1 gammaf2
error=checkvalue(handles.deltaf1);
switch error
    case 1
        set(handles.deltaf1,'string',num2str(deltaf1))
        msgbox('An error ocurred in the definition of lower Delta frequency')
        return
end
error=checkvalue(handles.deltaf2);
switch error
    case 1
        set(handles.deltaf2,'string',num2str(deltaf2))
        msgbox('An error ocurred in the definition of higher Delta frequency')
        return
end
error=checkvalue(handles.thetaf1);
switch error
    case 1
        set(handles.thetaf1,'string',num2str(thetaf1))
        msgbox('An error ocurred in the definition of lower Theta frequency')
        return
end
error=checkvalue(handles.thetaf2);
switch error
    case 1
        set(handles.thetaf2,'string',num2str(thetaf2))
        msgbox('An error ocurred in the definition of higher Theta frequency')
        return
end
error=checkvalue(handles.alphaf1);
switch error
    case 1
        set(handles.alphaf1,'string',num2str(alphaf1))
        msgbox('An error ocurred in the definition of lower Alpha frequency')
        return
end
error=checkvalue(handles.alphaf2);
switch error
    case 1
        set(handles.alphaf2,'string',num2str(alphaf2))
        msgbox('An error ocurred in the definition of higher Alpha frequency')
        return
end
error=checkvalue(handles.betaf1);
switch error
    case 1
        set(handles.betaf1,'string',num2str(betaf1))
        msgbox('An error ocurred in the definition of lower beta frequency')
        return
end
error=checkvalue(handles.betaf2);
switch error
    case 1
        set(handles.betaf2,'string',num2str(betaf2))
        msgbox('An error ocurred in the definition of higher beta frequency')
        return
end
error=checkvalue(handles.gammaf1);
switch error
    case 1
        set(handles.gammaf1,'string',num2str(gammaf1))
        msgbox('An error ocurred in the definition of lower Gamma frequency')
        return
end
error=checkvalue(handles.gammaf2);
switch error
    case 1
        set(handles.gammaf2,'string',num2str(gammaf2))
        msgbox('An error ocurred in the definition of higher Gamma frequency')
        return
end

handles.constants.put('deltaf1', get(handles.deltaf1,'string'));
handles.constants.put('deltaf2', get(handles.deltaf2,'string'));
handles.constants.put('thetaf1', get(handles.thetaf1,'string'));
handles.constants.put('thetaf2', get(handles.thetaf2,'string'));
handles.constants.put('alphaf1', get(handles.alphaf1,'string'));
handles.constants.put('alphaf2', get(handles.alphaf2,'string'));
handles.constants.put('betaf1', get(handles.betaf1,'string'));
handles.constants.put('betaf2', get(handles.betaf2,'string'));
handles.constants.put('gammaf1', get(handles.gammaf1,'string'));
handles.constants.put('gammaf2', get(handles.gammaf2,'string'));
save_constants(handles.constants);
close(handles.rhythmconfig);


% --- Executes on button press in cancelrhytms.
function cancelrhytms_Callback(hObject, eventdata, handles)
% hObject    handle to cancelrhytms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.rhythmconfig)


function deltaf1_Callback(hObject, eventdata, handles)
% hObject    handle to deltaf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of deltaf1 as text
%        str2double(get(hObject,'String')) returns contents of deltaf1 as a double
% --- Executes during object creation, after setting all properties.
function deltaf1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to deltaf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global deltaf1
set(hObject,'string',num2str(deltaf1))


function deltaf2_Callback(hObject, eventdata, handles)
% hObject    handle to deltaf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of deltaf2 as text
%        str2double(get(hObject,'String')) returns contents of deltaf2 as a double


% --- Executes during object creation, after setting all properties.
function deltaf2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to deltaf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global deltaf2
set(hObject,'string',num2str(deltaf2))


function gammaf2_Callback(hObject, eventdata, handles)
% hObject    handle to gammaf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gammaf2 as text
%        str2double(get(hObject,'String')) returns contents of gammaf2 as a double


% --- Executes during object creation, after setting all properties.
function gammaf2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gammaf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global gammaf2
set(hObject,'string',num2str(gammaf2))



function gammaf1_Callback(hObject, eventdata, handles)
% hObject    handle to gammaf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gammaf1 as text
%        str2double(get(hObject,'String')) returns contents of gammaf1 as a double

% --- Executes during object creation, after setting all properties.
function gammaf1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gammaf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global gammaf1
set(hObject,'string',num2str(gammaf1))



function betaf1_Callback(hObject, eventdata, handles)
% hObject    handle to betaf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of betaf1 as text
%        str2double(get(hObject,'String')) returns contents of betaf1 as a double


% --- Executes during object creation, after setting all properties.
function betaf1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to betaf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global betaf1
set(hObject,'string',num2str(betaf1))



function betaf2_Callback(hObject, eventdata, handles)
% hObject    handle to betaf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of betaf2 as text
%        str2double(get(hObject,'String')) returns contents of betaf2 as a double


% --- Executes during object creation, after setting all properties.
function betaf2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to betaf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global betaf2
set(hObject,'string',num2str(betaf2))



function alphaf2_Callback(hObject, eventdata, handles)
% hObject    handle to alphaf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alphaf2 as text
%        str2double(get(hObject,'String')) returns contents of alphaf2 as a double


% --- Executes during object creation, after setting all properties.
function alphaf2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alphaf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global alphaf2
set(hObject,'string',num2str(alphaf2))



function alphaf1_Callback(hObject, eventdata, handles)
% hObject    handle to alphaf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alphaf1 as text
%        str2double(get(hObject,'String')) returns contents of alphaf1 as a double



% --- Executes during object creation, after setting all properties.
function alphaf1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alphaf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global alphaf1
set(hObject,'string',num2str(alphaf1))



function thetaf2_Callback(hObject, eventdata, handles)
% hObject    handle to thetaf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thetaf2 as text
%        str2double(get(hObject,'String')) returns contents of thetaf2 as a double


% --- Executes during object creation, after setting all properties.
function thetaf2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thetaf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global thetaf2
set(hObject,'string',num2str(thetaf2))



function thetaf1_Callback(hObject, eventdata, handles)
% hObject    handle to thetaf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thetaf1 as text
%        str2double(get(hObject,'String')) returns contents of thetaf1 as a double


% --- Executes during object creation, after setting all properties.
function thetaf1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thetaf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global thetaf1
set(hObject,'string',num2str(thetaf1))
