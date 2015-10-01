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

% Last Modified by GUIDE v2.5 26-Jun-2009 12:21:06

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
global deltaf1 deltaf2 thetaf1 thetaf2 alphaf1 alphaf2 bethaf1 bethaf2 gammaf1 gammaf2
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
error=checkvalue(handles.bethaf1);
switch error
    case 1
        set(handles.bethaf1,'string',num2str(bethaf1))
        msgbox('An error ocurred in the definition of lower Betha frequency')
        return
end
error=checkvalue(handles.bethaf2);
switch error
    case 1
        set(handles.bethaf2,'string',num2str(bethaf2))
        msgbox('An error ocurred in the definition of higher Betha frequency')
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

deltaf1=str2double(get(handles.deltaf1,'string'));
deltaf2=str2double(get(handles.deltaf2,'string'));
thetaf1=str2double(get(handles.thetaf1,'string'));
thetaf2=str2double(get(handles.thetaf2,'string'));
alphaf1=str2double(get(handles.alphaf1,'string'));
alphaf2=str2double(get(handles.alphaf2,'string'));
bethaf1=str2double(get(handles.bethaf1,'string'));
bethaf2=str2double(get(handles.bethaf2,'string'));
gammaf1=str2double(get(handles.gammaf1,'string'));
gammaf2=str2double(get(handles.gammaf2,'string'));
close(handles.rhythmconfig)


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



function bethaf1_Callback(hObject, eventdata, handles)
% hObject    handle to bethaf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bethaf1 as text
%        str2double(get(hObject,'String')) returns contents of bethaf1 as a double


% --- Executes during object creation, after setting all properties.
function bethaf1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bethaf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global bethaf1
set(hObject,'string',num2str(bethaf1))



function bethaf2_Callback(hObject, eventdata, handles)
% hObject    handle to bethaf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bethaf2 as text
%        str2double(get(hObject,'String')) returns contents of bethaf2 as a double


% --- Executes during object creation, after setting all properties.
function bethaf2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bethaf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global bethaf2
set(hObject,'string',num2str(bethaf2))



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


