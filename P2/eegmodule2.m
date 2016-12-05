function varargout = eegmodule2(varargin)
% EEGMODULE2 M-file for eegmodule2.fig
%      EEGMODULE2, by itself, creates a new EEGMODULE2 or raises the existing
%      singleton*.
%
%      H = EEGMODULE2 returns the handle to a new EEGMODULE2 or the handle to
%      the existing singleton*.
%
%      EEGMODULE2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EEGMODULE2.M with the given input arguments.
%
%      EEGMODULE2('Property','Value',...) creates a new EEGMODULE2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before eegmodule2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to eegmodule2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help eegmodule2

% Last Modified by GUIDE v2.5 05-Dec-2016 09:43:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @eegmodule2_OpeningFcn, ...
                   'gui_OutputFcn',  @eegmodule2_OutputFcn, ...
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

addpath ([cd '/eegmodule']);
% End initialization code - DO NOT EDIT


% --- Executes just before eegmodule2 is made visible.
function eegmodule2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to eegmodule2 (see VARARGIN)

% Choose default command line output for eegmodule2
handles.output = hObject;
handles.constants = load_constants();
add_eeglab_path(get(handles.constants, 'EEGLAB_PATH'));

% Update handles structure
set(handles.editEEGLab, 'String', handles.constants.get('EEGLAB_PATH'));
set(handles.editLocations, 'String', handles.constants.get('LOCATIONS_PATH'));
set(handles.figure1, 'Name', 'EEG Module');
guidata(hObject, handles);

% UIWAIT makes eegmodule2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = eegmodule2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%-----------------------------------------------------------------
% --- Executes on button press in buttonParameters.
function buttonParameters_Callback(hObject, eventdata, handles)
% hObject    handle to buttonParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch get(handles.buttonParameters, 'Value')
    case 1
        set([handles.editEEGLab handles.editLocations], 'Enable', 'on');
    otherwise
        set([handles.editEEGLab handles.editLocations], 'Enable', 'off');
        handles.constants.put('EEGLAB_PATH', get(handles.editEEGLab, 'String'));
        handles.constants.put('LOCATIONS_PATH', get(handles.editLocations, 'String'));
        save_constants(handles.constants);
end


function editEEGLab_Callback(hObject, eventdata, handles)
% hObject    handle to editEEGLab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEEGLab as text
%        str2double(get(hObject,'String')) returns contents of editEEGLab as a double


% --- Executes during object creation, after setting all properties.
function editEEGLab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEEGLab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editLocations_Callback(hObject, eventdata, handles)
% hObject    handle to editLocations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editLocations as text
%        str2double(get(hObject,'String')) returns contents of editLocations as a double


% --- Executes during object creation, after setting all properties.
function editLocations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLocations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%-----------------------------------------------------------------
function editTable_Callback(hObject, eventdata, handles)
% hObject    handle to editTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTable as text
%        str2double(get(hObject,'String')) returns contents of editTable as a double

if isempty(get(handles.editTable, 'String'))
    set([handles.buttonRun, handles.checkRerefer, handles.checkLocate,...
        handles.checkInfo, handles.checkICA, handles.checkSteps],...
        'Enable', 'off');
end


% --- Executes during object creation, after setting all properties.
function editTable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonSearch.
function buttonSearch_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSearch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile('*.xls');

if ~isequal(filename, 0)
    outlet = strcat(pathname, filename);
    set([handles.buttonRun, handles.checkRerefer, handles.checkLocate,...
        handles.checkInfo, handles.checkICA, handles.checkSteps],...
        'Enable', 'on');
    set(handles.editTable, 'String', outlet);
else
    return;
    set([handles.buttonRun, handles.checkRerefer, handles.checkLocate,...
        handles.checkInfo, handles.checkICA, handles.checkSteps],...
        'Enable', 'off');
end


%-----------------------------------------------------------------
% --- Executes on button press in checkRerefer.
function checkRerefer_Callback(hObject, eventdata, handles)
% hObject    handle to checkRerefer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkRerefer


% --- Executes on button press in checkLocate.
function checkLocate_Callback(hObject, eventdata, handles)
% hObject    handle to checkLocate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkLocate


% --- Executes on button press in checkInfo.
function checkInfo_Callback(hObject, eventdata, handles)
% hObject    handle to checkInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkInfo


% --- Executes on button press in checkICA.
function checkICA_Callback(hObject, eventdata, handles)
% hObject    handle to checkICA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkICA


% --- Executes on button press in checkSteps.
function checkSteps_Callback(hObject, eventdata, handles)
% hObject    handle to checkSteps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkSteps


% --- Executes on button press in buttonRun.
function buttonRun_Callback(hObject, eventdata, handles)
% hObject    handle to buttonRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Abrir o arquivo
xlsfile = get(handles.editTable, 'String');
% [A, T] = xlsread(get(handles.editTable, 'String'));
ints_table = ler_arq_ints(xlsfile)

% Open eeglab:
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab; 

%Iniciar varredura para corte de intervalos
for i=1:size(ints_table)

    % sujeito=T(i+1,1);
    % teste= T(i+1,2); 
    % arqset = T(i+1,3);
    % int1 = A(i,1);
    % int2 = A(i,2);
    % arqedf = T(i+1, 4)

    % arqset = strcat(localdestino, char(sujeito), char(teste), '.set');

    % arqedf = strcat(localorigem, char(arqedf),'.edf');

    % %corte = [int1/1000 int2/1000]; 
    % corte = [int1/1000 int2/1000]; 

    % disp(corte);
    % %disp(getfiletype(char(arqedf)));
end
