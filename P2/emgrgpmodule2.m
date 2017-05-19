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

function emgrgpmodule2_OpeningFcn(hObject, eventdata, handles, varargin)

handles.constants = load_constants();
add_eeglab_path(get(handles.constants, 'EEGLAB_PATH'));

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

% Defining the path to a folder to save the new files
newPath = uigetdir(cd, 'Select the folder for new files');

% Open eeglab:
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
separateReuse = java.util.HashMap;

% Applying algorithm
for n = 1:length(testcases)

    % Loading EDF
    h = msgbox('Loading file...');
    EEG = pop_biosig(testcases{n}, 'importevent', 'off',...
								   'importannot', 'off',...
								   'blockepoch', 'off');
    
	% Naming the new file accordingly
	[edffilepath, edffilename, edffileext] = fileparts(testcases{n});
	tablefilepath = strcat(newPath, filesep, 'SeparatedChannels');
	tablenameEMG = strcat(edffilename, '_EMG.ascii');
	tablenameGSR = strcat(edffilename, '_GSR.ascii');
	close(h);

	% Checking if previous selections can be reused
    channelsSeparate = getChannelsCode({EEG.chanlocs.labels});
    if separateReuse.containsKey(channelsSeparate)
        fprintf('Reusing previous selection');
        toBeSeparated = separateReuse.get(channelsSeparate);
    else
        h = msgbox('Choose the channel to be separated:');
        toBeSeparated = pop_chansel({EEG.chanlocs.labels}, 'withindex', 'on');
        close(h);
        if toBeSeparated > 0
            separateReuse.put(channelsSeparate, toBeSeparated);
        else
        	h = msgbox({[strcat(edffilename, edffileext)];...
				   		['has no EMG-GSR channel']}, 'Error', 'error');
        end
    end

    [EMG, GSR, SamplingRate] = separateGSR(tablefilepath, EEG, toBeSeparated);
	h = msgbox('Saving files...');

	% Creating a new folder to store the files
	programPath = cd(newPath);
	mkdir(newPath, 'SeparatedChannels');

	% Opening a new file and writing the new content

	% EMG File
	fileID = fopen(strcat(tablefilepath, filesep, tablenameEMG), 'w');
	fprintf(fileID, '%f\n', EMG);
	fclose(fileID);
	
	% GSR File
	fileID = fopen(strcat(tablefilepath, filesep, tablenameGSR), 'w');
	fprintf(fileID, '%f\n', GSR);
	fclose(fileID);		
	
	% Going back to the program's folder
	newPath = cd(programPath);
	delete(h);
end

h = msgbox('Separation complete!');
set(handles.pushbuttonRun, 'String', 'Process', ...
						   'Enable', 'on');
