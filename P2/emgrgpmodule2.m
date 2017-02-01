function varargout = emgrgpmodule2(varargin)
% This module is used to separate the low frequency SGR signal from the
% high frequency EMG signal when they can't be measured in different
% channels and one signal overlaps the other.
%

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
javaaddpath('edf.jar');
if ~is_in_javapath('edf.jar')
	  javaaddpath('edf.jar');
end

function emgrgpmodule2_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
set(handles.pushbuttonRun, 'Enable', 'off');
set(handles.figure1, 'Name', 'EMG-GSR Separation Module');
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

if ~isequal(filename, 0)
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
	end
	set(handles.editFiles, 'String', outlet);
else
	return;
	set(handles.pushbuttonRun, 'Enable', 'off');
end


function pushbuttonRun_Callback(hObject, eventdata, handles)
% Callback when clicking "processar" pushbutton
inlet = get(handles.editFiles, 'String');
set(handles.pushbuttonRun, 'String', 'Processing...', ...
						   'Enable', 'off');

% Separating inlet into many strings
testcases = {};
while not(isempty(inlet))
	[testcases{end+1}, inlet] = strtok(inlet, ';');
end

% Defining th epath to a folder to save the new files
newPath = uigetdir(cd, 'Select the folder for new files');

% Applying algorithm
for n = 1:length(testcases)
	[EMG, GSR, SamplingRate] = separateGSR(testcases{n});

	if GSR == 0
		h = msgbox({[testcases{n}];...
				   ['has no EMG-GSR channel']}, 'Error', 'error');
		uiwait(h);
	else
		h = msgbox('Saving files...');

		% Creating a new folder to store the files
		programPath = cd(newPath);
		mkdir(newPath, 'SeparatedChannels');

		% Naming the new file acoordingly
		size = length(strfind(testcases{n}, '\'));
		remain = testcases{n};
		for k = 1:size
			[str, remain] = strtok(remain, '\');
		end
		tablenameEMG = strrep(remain, '.edf', '_EMG.ascii');
		tablenameGSR = strrep(remain, '.edf', '_GSR.ascii');

		% Opening a new file and writing the new content

		% EMG File
		fileID = fopen(strcat(newPath, '\SeparatedChannels\', tablenameEMG), 'w');
		fprintf(fileID, ';%s=%d\n', 'Sampling Rate', SamplingRate);
		fprintf(fileID, '%f\n', EMG);
		fclose(fileID);

		% GSR File
		fileID = fopen(strcat(newPath, '\SeparatedChannels\', tablenameGSR), 'w');
		fprintf(fileID, ';%s=%d\n', 'Sampling Rate', SamplingRate);
		fprintf(fileID, '%f\n', GSR);
		fclose(fileID);
		
		% Gaoing back to the program's folder
		newPath = cd(programPath);
		delete(h);
	end
end

h = msgbox('Separation complete!');
set(handles.pushbuttonRun, 'String', 'Process', ...
						   'Enable', 'on');
