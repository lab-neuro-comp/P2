function varargout = emgrgpmodule2(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
				   'gui_Singleton',  gui_Singleton, ...
				   'gui_OpeningFcn', @emgrgpmodule2_OpeningFcn, ...
				   'gui_OutputFcn',  @emgrgpmodule2_OutputFcn, ...
				   'gui_LayoutFcn',  [], ...
				   'gui_Callback',   []);
if nargin && ischar(varargin{1})
	gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
	[varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
	gui_mainfcn(gui_State, varargin{:});
end

addpath([cd '/emgrgpmodule']);
if isequal(exist('edf.jar'), 0)
	  javaaddpath('edf.jar');
end

function emgrgpmodule2_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
set(handles.pushbuttonRun, 'Enable', 'off');
guidata(hObject, handles);

function varargout = emgrgpmodule2_OutputFcn(hObject, eventdata, handles)


function editFiles_Callback(hObject, eventdata, handles)
% There is no need to exist a function like this


function editFiles_CreateFcn(hObject, eventdata, handles)
% Nor a function here


function pushbuttonSearch_Callback(hObject, eventdata, handles)
% Callback when clicking "buscar" pushbutton
[filename, pathname] = uigetfile('*.edf', 'MultiSelect', 'on');
outlet = '';

if iscell(filename)
	for n = 1:length(filename)
		filename{n} = strcat(pathname, filename{n});
	end
	outlet = filename{1};
	for n = 2:length(filename)
		outlet = strcat(outlet, ';', filename{n});
	end
	set(handles.pushbuttonRun, 'Enable', 'on');
elseif ischar(filename)
	outlet = strcat(pathname, filename);
	set(handles.pushbuttonRun, 'Enable', 'on');
elseif isempty(filename)
	return;
	set(handles.pushbuttonRun, 'Enable', 'off');
end

set(handles.editFiles, 'String', outlet);

function pushbuttonRun_Callback(hObject, eventdata, handles)
% Callback when clicking "processar" pushbutton
inlet = get(handles.editFiles, 'String');

% Separating inlet into many strings
testcases = {};
while not(isempty(inlet))
	[testcases{end+1}, inlet] = strtok(inlet, ';');
end

% Applying algorithm
tic;
for n = 1:length(testcases)
	[EMG, GSR] = separateGSR(testcases{n});

	if GSR == 0
		h = msgbox({[testcases{n}];...
				   ['has no EMG-RGP channel']}, 'Error', 'error');
	else
		% TODO Add legends to plots
		figure;
		hold on;
		plot(GSR, 'r');
		plot(EMG, 'b');
		hold off;
	end
end
toc;