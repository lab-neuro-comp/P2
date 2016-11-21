function varargout = stimuli_analysis(varargin)
% STIMULI_ANALYSIS M-file for stimuli_analysis.fig
%      STIMULI_ANALYSIS, by itself, creates a new STIMULI_ANALYSIS or raises the existing
%      singleton*.
%
%      H = STIMULI_ANALYSIS returns the handle to a new STIMULI_ANALYSIS or the handle to
%      the existing singleton*.
%
%      STIMULI_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STIMULI_ANALYSIS.M with the given input arguments.
%
%      STIMULI_ANALYSIS('Property','Value',...) creates a new STIMULI_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before stimuli_analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to stimuli_analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help stimuli_analysis

% Last Modified by GUIDE v2.5 16-Nov-2016 10:49:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
									 'gui_Singleton',  gui_Singleton, ...
									 'gui_OpeningFcn', @stimuli_analysis_OpeningFcn, ...
									 'gui_OutputFcn',  @stimuli_analysis_OutputFcn, ...
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


% --- Executes just before stimuli_analysis is made visible.
function stimuli_analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to stimuli_analysis (see VARARGIN)

% Choose default command line output for stimuli_analysis
handles.output = hObject;
handles.files = varargin{1};

set(handles.popupAudio, 'String', handles.files);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes stimuli_analysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = stimuli_analysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupAudio.
function popupAudio_Callback(hObject, eventdata, handles)
% hObject    handle to popupAudio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupAudio contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupAudio
set(handles.buttonSave, 'Enable', 'off');


% --- Executes during object creation, after setting all properties.
function popupAudio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupAudio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
		set(hObject,'BackgroundColor','white');
end



function editTest_Callback(hObject, eventdata, handles)
% hObject    handle to editTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTest as text
%        str2double(get(hObject,'String')) returns contents of editTest as a double
set(handles.buttonSave, 'Enable', 'off');


% --- Executes during object creation, after setting all properties.
function editTest_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTest (see GCBO)
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

[filename, pathname, filterindex]  = uigetfile('*.txt', 'Select files');
set(handles.editTest, 'String', strcat(pathname, filename));
set(handles.buttonAnalyse, 'Enable', 'on');
set(handles.buttonSave, 'Enable', 'off');


% --- Executes on selection change in listAnalysis.
function listAnalysis_Callback(hObject, eventdata, handles)
% hObject    handle to listAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listAnalysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listAnalysis


% --- Executes during object creation, after setting all properties.
function listAnalysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
		set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonAnalyse.
function buttonAnalyse_Callback(hObject, eventdata, handles)
% hObject    handle to buttonAnalyse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents = cellstr(get(handles.popupAudio, 'String'));
filename = contents{get(handles.popupAudio, 'Value')};
handles.filename = filename;

responseTime = analyse_for_stimulus(filename, get(handles.editTest, 'String'));
set(handles.listAnalysis, 'String', responseTime);
set(handles.buttonSave, 'Enable', 'on');

handles.responseTime = responseTime;

guidata(hObject, handles);


% --- Executes on button press in buttonSave.
function buttonSave_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

filename = handles.filename;
filename = strrep(filename, '.wav', '.csv');
fileID = fopen(filename, 'r');
content = textscan(fileID, '%s');

semicollon = findstr(content{1}{1}, ';');

responseTime = handles.responseTime;

if length(semicollon) == 1
	content{1}{1} = strcat(content{1}{1}, ';Demora');
	
	for n = 2:length(content{1})
		responseFile = replace_dot(responseTime(n-1));
		content{1}{n} = strcat(content{1}{n}, ';', responseFile);
	end
else
	content{1}{1} = content{1}{1}(1:semicollon(2));
	content{1}{1} = strcat(content{1}{1}, 'Demora');

	for n = 2:length(content{1})
		semicollon = findstr(content{1}{n}, ';');
		content{1}{n} = content{1}{n}(1:semicollon(2));
		responseFile = replace_dot(responseTime(n-1));
		content{1}{n} = strcat(content{1}{n}, responseFile);
		disp(content{1}{n});
	end
end
fclose(fileID);

fileID = fopen(filename, 'w');
for n = 1:length(content{1})
	fprintf(fileID, '%s\n', content{1}{n});
end
fclose(fileID);

set(handles.buttonSave, 'Enable', 'off');

guidata(hObject, handles);
