function varargout = plot_stuff(varargin)
% This modele provides the way for the user to clear the data
% obtained from the analysis made for the beginning of a word.
% If there's more data being recorded as a speech, the user can
% leave it unmarked to be erased when the file is saved.
%

% Edit the above text to modify the response to help plot_stuff

% Last Modified by GUIDE v2.5 01-Mar-2019 11:03:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
					 'gui_Singleton',  gui_Singleton, ...
					 'gui_OpeningFcn', @plot_stuff_OpeningFcn, ...
					 'gui_OutputFcn',  @plot_stuff_OutputFcn, ...
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


% --- Executes just before plot_stuff is made visible.
function plot_stuff_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for plot_stuff
handles.output = hObject;

% Defining some handles for the program
handles.files = varargin{1};
handles.stuff = varargin{2};
handles.ext = varargin{3};

handles.number = 1;
set(handles.panelName,...
	'Title', strcat('File: ', num2str(1), '/', num2str(length(handles.files))));

% If only one file was informed
if length(handles.files) == 1
	set(handles.pushbuttonSave, 'String', 'Save');
end

% Opens first record
[handles.record, handles.fs] = open_signal(hObject, handles,...
							   			   handles.files,...
							   			   handles.number);

% The information stored in hash map must be updated
timeArray = get(handles.stuff, handles.files{handles.number});
set(handles.editFirst, 'String', '0');
set(handles.editInterval,...
	 'String', num2str(length(handles.record)/handles.fs));
set(handles.textMax,...
	 'String', strcat('Max. ', num2str(length(handles.record)/handles.fs)));
set([handles.buttonFirst handles.buttonPrev handles.buttonNext handles.buttonLast], ...
	 'Enable', 'on');

% Prepare axes for first plot
refresh_signal(hObject, handles,...
			   handles.files,...
			   handles.stuff,...
			   handles.number,...
			   handles.record,...
			   handles.fs,...
			   handles.ext,...
			   str2num(get(handles.editFirst, 'String')),...
			   str2num(get(handles.editInterval, 'String')));

% Update number of points marked in file
set(handles.textPoints, 'String', num2str(length(timeArray)));

% Update handles structure
handles.times = timeArray;
set(handles.figure1, 'Name', 'Moments Verification');
guidata(hObject, handles);

% UIWAIT makes plot_stuff wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plot_stuff_OutputFcn(hObject, eventdata, handles)

% Get default command line output from handles structure
varargout{1} = handles.output;
close(handles.figure1);


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% Does nothing


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)

file = uigetfile('*.fig');
if ~isequal(file, 0)
	open(file);
end

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)

selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
					 ['Close ' get(handles.figure1,'Name') '...'],...
					 'Yes','No','Yes');
if strcmp(selection,'No')
	return;
end

delete(handles.figure1)

% --------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function textFilename_CreateFcn(hObject, eventdata, handles)
% Does nothing


function editFirst_Callback(hObject, eventdata, handles)

maxSec = length(handles.record)/handles.fs;
first = str2num(get(handles.editFirst, 'String'));
interval = str2num(get(handles.editInterval, 'String'));

% Checks if the first point is too big (more then size of record),
% too small (less then zero) or if the first point summed with the
% interval are bigger then the size of the record
if (first > maxSec || first < 0 || first + interval > maxSec)
	set(handles.editFirst, 'String', '0');
else
	set(handles.editFirst, 'String', num2str(first));
end
refresh_signal(hObject, handles,...
			   handles.files,...
			   handles.stuff,...
			   handles.number,...
			   handles.record,...
			   handles.fs,...
			   handles.ext,...
			   str2num(get(handles.editFirst, 'String')),...
			   str2num(get(handles.editInterval, 'String')));

	
% --- Executes during object creation, after setting all properties.
function editFirst_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonFirst.
function buttonFirst_Callback(hObject, eventdata, handles)
set(handles.editFirst, 'String', '0');
refresh_signal(hObject, handles,...
			   handles.files,...
			   handles.stuff,...
			   handles.number,...
			   handles.record,...
			   handles.fs,...
			   handles.ext,...
			   0,...
			   str2num(get(handles.editInterval, 'String')));


% --- Executes on button press in buttonPrev.
function buttonPrev_Callback(hObject, eventdata, handles)
first = str2num(get(handles.editFirst, 'String'));
interval = str2num(get(handles.editInterval, 'String'));

first = first - interval;
if (first - interval < 0)
	first = 0;
end

set(handles.editFirst, 'String', num2str(first));
refresh_signal(hObject, handles,...
			   handles.files,...
			   handles.stuff,...
			   handles.number,...
			   handles.record,...
			   handles.fs,...
			   handles.ext,...
			   first,...
			   interval);


% --- Executes on button press in buttonNext.
function buttonNext_Callback(hObject, eventdata, handles)
first = str2num(get(handles.editFirst, 'String'));
interval = str2num(get(handles.editInterval, 'String'));

first = first + interval;
if (first + interval > length(handles.record)/handles.fs)
	first = (length(handles.record)/handles.fs) - interval;
end

set(handles.editFirst, 'String', num2str(first));
refresh_signal(hObject, handles,...
			   handles.files,...
			   handles.stuff,...
			   handles.number,...
			   handles.record,...
			   handles.fs,...
			   handles.ext,...
			   first,...
			   interval);


% --- Executes on button press in buttonLast.
function buttonLast_Callback(hObject, eventdata, handles)
maxSec = length(handles.record)/handles.fs;
interval = str2num(get(handles.editInterval, 'String'));
first = maxSec - interval;

set(handles.editFirst, 'String', num2str(first));
refresh_signal(hObject, handles,...
			   handles.files,...
			   handles.stuff,...
			   handles.number,...
			   handles.record,...
			   handles.fs,...
			   handles.ext,...
			   first,...
			   interval);


function editInterval_Callback(hObject, eventdata, handles)

maxSec = length(handles.record)/handles.fs;
first = str2num(get(handles.editFirst, 'String'));
interval = str2num(get(handles.editInterval, 'String'));

% Checks if the interval is to big (bigger than max size of record)
% or too small (lesser than sampling period)
if (interval > maxSec || interval <= 1/handles.fs)
	set(handles.editFirst, 'String', '0');
	set(handles.editInterval, 'String', num2str(maxSec));
else
	% If the new interval "zooms" past end of record,
	% move first point to a new location
	if (first + interval > maxSec)
		first = maxSec - interval;
		set(handles.editFirst, 'String', num2str(first));
	end
	set(handles.editInterval, 'String', num2str(interval));
end
refresh_signal(hObject, handles,...
			   handles.files,...
			   handles.stuff,...
			   handles.number,...
			   handles.record,...
			   handles.fs,...
			   handles.ext,...
			   str2num(get(handles.editFirst, 'String')),...
			   str2num(get(handles.editInterval, 'String')));


% --- Executes during object creation, after setting all properties.
function editInterval_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonEdit.
function buttonEdit_Callback(hObject, eventdata, handles)

timeArray = handles.times;
sizeRecord = length(handles.record)/handles.fs;
first = str2num(get(handles.editFirst, 'String'));
interval = str2num(get(handles.editInterval, 'String'));
record = handles.record;
% creates a small window space to check the better spot to add the mark
checkWindow = ceil(.001*handles.fs); 

% while the toggle button is on, add/remove marks
while get(hObject, 'Value') == 1
	xInfo = xlim(handles.axes1);
	yInfo = ylim(handles.axes1);
	[x, y, b] = ginput(1);
	% user clicked on the plot with the left button (add point)
    if (b == 1 && x >= xInfo(1) && x <= xInfo(2) && y >= yInfo(1) && y <= yInfo(2))
        x = round(x*handles.fs);

        if ((x - checkWindow) < 0)
        	[y, w] = min(abs(record(0:(x + checkWindow))));
        	if (length(w) > 1)
        		[i, j] = min(abs(w - x));
        		if length(j > 1)
        			x = x + w(j(1));
        		else
        			x = x + w(j);
        		end
        	else
        		x = x + w;
        	end
        elseif ((x + checkWindow) > length(handles.record))
        	[y, w] = min(abs(record(x - checkWindow):sizeRecord));
        	if (length(w) > 1)
        		[i, j] = min(abs(w - x));
        		if length(j > 1)
        			x = x + w(j(1));
        		else
        			x = x + w(j);
        		end
        	else
        		x = x + w;
        	end
        else
        	[y, w] = min(abs(record((x - checkWindow):(x + checkWindow))));
        	if (length(w) > 1)
        		[i, j] = min(abs(w - x));
        		if length(j > 1)
        			x = x + w(j(1));
        		else
        			x = x + w(j);
        		end
        	else
        		x = x + w;
        	end
        end
        timeArray = sort([timeArray; x/handles.fs]);
        handles.times = timeArray;

		% Updates number of points marked in audio
		tmp = str2num(get(handles.textPoints, 'String'));
		set(handles.textPoints, 'String', num2str(tmp + 1));

		% Adds new points to hash map
		handles.stuff.put(handles.files{handles.number}, timeArray);
		guidata(hObject, handles);

    % user clicked on the plot with the right button (remove point)
    elseif (b == 3 && x >= xInfo(1) && x <= xInfo(2) && y >= yInfo(1) && y <= yInfo(2))
    	[j, i] = min(abs(timeArray - x));
    	if length(i > 1)
        	timeArray(i(1))= [];
        else
    		timeArray(i) = [];
    	end
    	disp(timeArray);
    	handles.times = timeArray;

    	% Updates number of points marked in audio
		tmp = str2num(get(handles.textPoints, 'String'));
		set(handles.textPoints, 'String', num2str(tmp - 1));

		% Remove points from hash map
		handles.stuff.put(handles.files{handles.number}, timeArray);
		guidata(hObject, handles);

    else
    	% if user clicks outside the plot area
    	% or with the middle button, the toggle is turned off.
    	set(hObject, 'Value', 0);
    end

    refresh_signal(hObject, handles,...
					   handles.files,...
					   handles.stuff,...
					   handles.number,...
					   handles.record,...
					   handles.fs,...
					   handles.ext,...
					   first,...
					   interval);

end
guidata(hObject, handles);


% --- Executes on button press in pushbuttonSave.
function pushbuttonSave_Callback(hObject, eventdata, handles)

number = handles.number;

% Prepares to save file
filename = handles.files;
timeArray = get(handles.stuff, filename{number});

selection = questdlg({'You will save only the marked moments.',...
					 'Do you wish to continue?'},...
					 ['Save ' filename{number} '?'],...
					 'Ok','Cancel','Ok');
if strcmp(selection,'Cancel')
	return;
end

% Updates hash map with modified information
handles.stuff.put(filename{number}, timeArray);

number = number + 1;
handles.number = number;

% If there are still more files to be analysed
if number <= length(handles.files)
	if number == length(handles.files)
		set(handles.pushbuttonSave, 'String', 'Save');
	end
	
	% Updates plot with next audio
	[handles.record, handles.fs] = open_signal(hObject, handles,...
							   				   handles.files,...
							   				   handles.number);

	% The information stored in hash map must be updated
	timeArray = get(handles.stuff, handles.files{handles.number});
	set(handles.editFirst, 'String', '0');
	set([handles.textMax handles.editInterval],...
		 'String', num2str(length(handles.record)/handles.fs));
	set([handles.buttonFirst handles.buttonPrev handles.buttonNext handles.buttonLast], ...
		 'Enable', 'off');

	% Prepare axes for next plot
	refresh_signal(hObject, handles,...
				   handles.files,...
				   handles.stuff,...
				   handles.number,...
				   handles.record,...
				   handles.fs,...
				   handles.ext,...
				   str2num(get(handles.editFirst, 'String')),...
				   str2num(get(handles.textMax, 'String')));

	%filename = handles.files;
	timeArray = get(handles.stuff, handles.files{handles.number});
	
	% Update number of points marked in file
	set(handles.textPoints, 'String', num2str(length(timeArray)));

	% Update handles structure
	handles.times = timeArray;
	guidata(hObject, handles);

% Else, if all files have been analysed
else
	% Handles control back to voicemodule2
	handles.output = handles.stuff;
	guidata(hObject, handles);
	uiresume(handles.figure1);
end
