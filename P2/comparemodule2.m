function varargout = comparemodule2(varargin)
% This module analyses the time of events of a response that where
% recorded on audio with the time when the stimulus was given to the
% participant. Upon reaching  the interface, one must be able to
% choose amongst the audio files that were previously analysed and
% search for its correspondent .txt files containing the informations
%on the test. After its analysis, the data is stored in a .csv file
% with the data that was generated before after the audio analysis.
%

% Edit the above text to modify the response to help comparemodule2

% Last Modified by GUIDE v2.5 01-Feb-2017 08:14:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
									 'gui_Singleton',  gui_Singleton, ...
									 'gui_OpeningFcn', @comparemodule2_OpeningFcn, ...
									 'gui_OutputFcn',  @comparemodule2_OutputFcn, ...
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

addpath([cd '/comparemodule']);

% --- Executes just before comparemodule2 is made visible.
function comparemodule2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to comparemodule2 (see VARARGIN)

% Choose default command line output for comparemodule2
handles.output = hObject;

% Update handles structure
set(handles.figure1, 'Name', 'Test Response Delay');
guidata(hObject, handles);

% UIWAIT makes comparemodule2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = comparemodule2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in buttonFolder.
function buttonFolder_Callback(hObject, eventdata, handles)
% hObject    handle to buttonFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

CSVPath = uigetdir(cd, 'Select the folder containing the analysed audio');
handles.CSVPath = CSVPath;
programPath = cd(CSVPath);

extension = '*.csv';
listCSV = ls(extension);
handles.CSVFiles = listCSV;
CSVPath = cd(programPath);

listCSV = handles.CSVFiles;
set(handles.listFiles, 'String', listCSV);
guidata(hObject, handles);


% --- Executes on selection change in listFiles.
function listFiles_Callback(hObject, eventdata, handles)
% hObject    handle to listFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listFiles contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listFiles
set(handles.buttonSave, 'Enable', 'off');


% --- Executes during object creation, after setting all properties.
function listFiles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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
set(handles.buttonSave, 'Enable', 'off');
if ~isempty(get(handles.editTest, 'String'))
	set(handles.buttonAnalyse, 'Enable', 'on');
end


function editTest_Callback(hObject, eventdata, handles)
% hObject    handle to editTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTest as text
%        str2double(get(hObject,'String')) returns contents of editTest as a double
set(handles.buttonSave, 'Enable', 'off');
if ~isempty(get(handles.editTest, 'String'))
	set(handles.buttonAnalyse, 'Enable', 'on');
else
	set(handles.buttonAnalyse, 'Enable', 'off');
end

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


% --- Executes on button press in buttonAnalyse.
function buttonAnalyse_Callback(hObject, eventdata, handles)
% hObject    handle to buttonAnalyse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents = cellstr(get(handles.listFiles, 'String'));
filename = contents{get(handles.listFiles, 'Value')};
CSVPath = handles.CSVPath;
filename = strcat(CSVPath, '\', filename);
handles.filename = filename;

responseTime = analyse_for_stimulus(filename, get(handles.editTest, 'String'));
set(handles.listAnalysis, 'String', responseTime);
set(handles.buttonSave, 'Enable', 'on');

handles.responseTime = responseTime;

guidata(hObject, handles);


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
	content{1}{1} = strcat(content{1}{1}, ';Delay');
	
	for n = 2:length(content{1})
		responseFile = replace_dot(responseTime(n-1));
		content{1}{n} = strcat(content{1}{n}, ';', responseFile);
	end
else
	content{1}{1} = content{1}{1}(1:semicollon(2));
	content{1}{1} = strcat(content{1}{1}, 'Delay');

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

h = msgbox('File successfully saved!');

