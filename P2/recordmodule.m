function varargout = recordmodule(varargin)
% RECORDMODULE M-file for recordmodule.fig
%      RECORDMODULE, by itself, creates a new RECORDMODULE or raises the existing
%      singleton*.
%
%      H = RECORDMODULE returns the handle to a new RECORDMODULE or the handle to
%      the existing singleton*.
%
%      RECORDMODULE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECORDMODULE.M with the given input arguments.
%
%      RECORDMODULE('Property','Value',...) creates a new RECORDMODULE or
%      raises the existing singleton*.  Starting from the left, property
%      value pairs are applied to the GUI before recordmodule_OpeningFunction
%      gets called.  An unrecognized property name or invalid value makes
%      property application stop.  All inputs are passed to
%      recordmodule_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help recordmodule

% Last Modified by GUIDE v2.5 04-May-2016 09:18:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @recordmodule_OpeningFcn, ...
                   'gui_OutputFcn',  @recordmodule_OutputFcn, ...
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

% Import needed folders. Yeah, I'm editing the initialization code
addpath(strcat(cd, '/util'));
addpath(strcat(cd, '/recordmodule'));

% End initialization code - DO NOT EDIT


% --- Executes just before recordmodule is made visible.
function recordmodule_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to recordmodule (see VARARGIN)

% Choose default command line output for recordmodule
handles.output = hObject;

% Update handles structure
handles.constants = load_constants();
add_eeglab_path(handles.constants.get('EEGLAB_PATH'));
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = recordmodule_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupMode.
function popupMode_Callback(hObject, eventdata, handles)
% hObject    handle to popupMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: - `contents = get(hObject, 'String')` returns popupMode
%          contents as cell array
%        - `contents{get(hObject, 'Value')}` returns selected item
%          from popupMode
contents = get(handles.popupMode, 'String');
runningmode = contents{get(handles.popupMode, 'Value')};
switch runningmode
    case 'Protolize!!'
        setup_for_protolize(handles);
    case 'EEGLAB'
        setup_for_eeglab(handles);
    case 'Chopping'
        setup_for_chopping(handles);
end

% --- Executes during object creation, after setting all properties.
function popupMode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
color = 'white';
if ~ispc
    color = get(0, 'defaultUicontrolBackgroundColor');
end
set(hObject, 'BackgroundColor', color);


% --- Executes on button press in buttonRun. -------------------------
function buttonRun_Callback(hObject, eventdata, handles)
% hObject    handle to buttonRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = get(handles.popupMode, 'String');
runningmode = contents{get(handles.popupMode, 'Value')};
switch runningmode
    case 'Protolize!!'
        run_for_protolize(handles);
    case 'EEGLAB'
        run_for_eeglab(handles);
    case 'Chopping'
        run_for_chopping(handles);
end

% --------------------------------------------------------------------
function quitMenu_Callback(hObject, eventdata, handles)
% hObject    handle to quitMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close module?'], ...
                     ['Closing module...'], ...
                     'Yes', 'No', 'Yes');
if strcmp(selection, 'No')
    return;
end
delete(handles.figure1)

% --------------------------------------------------------------------
function settingsMenu_Callback(hObject, eventdata, handles)
% hObject    handle to settingsMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuFile_Callback(hObject, eventdata, handles)
% hObject    handle to menuFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function editMenu_Callback(hObject, eventdata, handles)
% hObject    handle to editMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkMultiple. ---------------------
function checkMultiple_Callback(hObject, eventdata, handles)
% hObject    handle to checkMultiple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkMultiple

% --- Executes on button press in checkRerefer. ----------------------
function checkRerefer_Callback(hObject, eventdata, handles)
% hObject    handle to checkRerefer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkRerefer
value = 'off';
if get(handles.checkRerefer, 'Value')
    value = 'on';
end
set(handles.editRerefer, 'Enable', value);

% -------------------------------------------------------------------
function editRerefer_Callback(hObject, eventdata, handles)
% hObject    handle to editRerefer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: - get(hObject,'String') returns contents of editRerefer as text
%        - str2double(get(hObject,'String')) returns contents of 
%          editRerefer as a double


% --- Executes during object creation, after setting all properties.
function editRerefer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRerefer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject, ...
        'BackgroundColor', ...
        get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes on button press in checkResample. --------------------
function checkResample_Callback(hObject, eventdata, handles)
% hObject    handle to checkResample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkResample
value = 'off';
if get(handles.checkResample, 'Value')
    value = 'on';
end
set(handles.editResample, 'Enable', value);

function editResample_Callback(hObject, eventdata, handles)
% hObject    handle to editResample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: - get(hObject,'String') returns contents of editResample as text
%        - str2double(get(hObject,'String')) returns contents of 
%          editResample as a double


% --- Executes during object creation, after setting all properties. -
function editResample_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editResample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject, 'BackgroundColor', 'white');
else
    set(hObject, ...
        'BackgroundColor', ...
        get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes on button press in checkICA. -------------------------
function checkICA_Callback(hObject, eventdata, handles)
% hObject    handle to checkICA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkICA




% --------------------------------------------------------------------
function editInput_Callback(hObject, eventdata, handles)
% hObject    handle to editInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: - get(hObject,'String') returns contents of editInput as text
%        - str2double(get(hObject,'String')) returns contents of editInput
%          as a double


% --- Executes during object creation, after setting all properties. -
function editInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject, ...
        'BackgroundColor', ...
        'white');
else
    set(hObject, ...
        'BackgroundColor', ...
        get(0, 'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in buttonSearch. ---------------------
function buttonSearch_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSearch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*', 'MultiSelect', 'on');
if isnumeric(filename)
    return
elseif iscell(filename)
    set(handles.editInput, ...
        'String', ...
        join_strings(append_on_each_one(filename, ...
                                        pathname), ...
                     ';'));
else
    set(handles.editInput, ...
        'String', ...
        strcat(pathname, ...
               filename));
end



