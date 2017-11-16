function varargout = ecgmodule(varargin)
% ECGMODULE M-file for ecgmodule.fig
%      ECGMODULE, by itself, creates a new ECGMODULE or raises the existing
%      singleton*.
%
%      H = ECGMODULE returns the handle to a new ECGMODULE or the handle to
%      the existing singleton*.
%
%      ECGMODULE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ECGMODULE.M with the given input arguments.
%
%      ECGMODULE('Property','Value',...) creates a new ECGMODULE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ecgmodule_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ecgmodule_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ecgmodule

% Last Modified by GUIDE v2.5 25-Jun-2017 14:12:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ecgmodule_OpeningFcn, ...
                   'gui_OutputFcn',  @ecgmodule_OutputFcn, ...
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

addpath ([cd '/ecgmodule']);
% End initialization code - DO NOT EDIT


% --- Executes just before ecgmodule is made visible.
function ecgmodule_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ecgmodule (see VARARGIN)

% Choose default command line output for ecgmodule
handles.output = hObject;
handles.hpeack = [];
handles.hvhr = [];
handles.hvhrspec = [];
handles.constants = load_constants();

%uV=(ASCII+fa)*fb-fc
axes(handles.vhraxes)
xlabel('[s]')
ylabel('[s]')
title('VHR')
grid on

axes(handles.vhrspecaxes)
xlabel('[Hz]')
ylabel('[ms^2]')
title('VHR SPECTRUM')
grid on

axes(handles.ecgaxes)
xlabel('[s]')
ylabel('[uV]')
grid on

%maxfig(gcf, 1);

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = ecgmodule_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in figurevhr.
function figurevhr_Callback(hObject, eventdata, handles)
% hObject    handle to figurevhr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

xdata = get(handles.hvhr, 'xdata');
ydata = get(handles.hvhr, 'ydata');
xlim = get(handles.vhraxes, 'xlim');
ylim = get(handles.vhraxes, 'ylim');
savefigure(xdata, ydata, 'b', xlim, ylim, '[s]', '[s]', 'VHR')


% --- Executes on button press in figurevhrspec.
function figurevhrspec_Callback(hObject, eventdata, handles)
% hObject    handle to figurevhrspec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

xdata = get(handles.hvhrspec,'xdata');
ydata = get(handles.hvhrspec,'ydata');
xlim = get(handles.vhrspecaxes,'xlim');
ylim = get(handles.vhrspecaxes,'ylim');
savefigure(xdata, ydata, 'b', xlim, ylim, '[Hz]', '[ms^2]', 'VHR SPECTRUM');


% --------------------------------------------------------------------
function ecgfile_Callback(hObject, eventdata, handles)
% hObject    handle to ecgfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function ecgexit_Callback(hObject, eventdata, handles)
% hObject    handle to ecgexit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);


% --------------------------------------------------------------------
function ecgopen_Callback(hObject, eventdata, handles)

fa = str2num(handles.constants.get('fa'));
fb = str2num(handles.constants.get('fb'));
fc = str2num(handles.constants.get('fc'));
fs = str2num(handles.constants.get('fs'));

[ecgname, ecgpath, filterindex]  = uigetfile('*.ascii', 'Select files', ...
                                             'MultiSelect', 'on');
handles.cases = {};
if ~isequal(ecgname, 0)
    if ischar(ecgname)
        handles.cases = {strcat(ecgpath, ecgname)};
        ecgexportmx{1,1} = 'File:';
        ecgexportmx{1,2} = ecgname;    
    elseif iscell(ecgname)
        handles.cases = {};
        for n = 1:length(ecgname)
            handles.cases{n} = strcat(ecgpath, ecgname{n});
        end
        ecgexportmx{1,1} = 'File:';
        ecgexportmx{1,2} = ecgname{1};    
    end
    set(handles.popupECG, 'String', ecgname, 'Visible', 'on');
    handles.ecgpath = ecgpath;
    handles.ecgname = ecgname;

    try
        ecg = load(handles.cases{1});
        set(handles.textDuration, 'String', strcat(sprintf('%4.3f', length(ecg)/fs), '[s]'));
        ecgexportmx{1,4} = 'Duration:';
        ecgexportmx{1,5} = strcat(sprintf('%4.3f',length(ecg)/fs), '[s]');
        set(handles.textFs, 'String', strcat(num2str(fs), '[Hz]'));
        ecgexportmx{1,7} = 'Fs:';
        ecgexportmx{1,8} = strcat(num2str(fs), '[Hz]');

        ecg = ((ecg + fa)*fb) - fc;
        t = 0:1/fs:(length(ecg)-1)/fs;
        axes(handles.ecgaxes)
        ecgplot = plot(t, ecg);
        axis([0 max(t) min(ecg) max(ecg)]);
        xlabel('[seg]');
        ylabel('uV');
        grid on;
        set([handles.process handles.invert handles.zoombutton], 'Enable', 'on');
    catch
        error;
        return;
    end
end

handles.t = t;
handles.ecgplot = ecgplot;
handles.ecgexportmx = ecgexportmx;

guidata(hObject, handles);


% --- Executes on selection change in popupECG.
function popupECG_Callback(hObject, eventdata, handles)

fa = str2num(handles.constants.get('fa'));
fb = str2num(handles.constants.get('fb'));
fc = str2num(handles.constants.get('fc'));
fs = str2num(handles.constants.get('fs'));

contents = cellstr(get(hObject, 'String'));
ecgname = contents{get(hObject, 'Value')};

delete(handles.ecgplot);

try
    ecg = load(strcat(handles.ecgpath, ecgname));
    ecgexportmx{1,1} = 'File:';
    ecgexportmx{1,2} = ecgname;
    set(handles.textDuration, 'String', strcat(sprintf('%4.3f', length(ecg)/fs), '[s]'));
    ecgexportmx{1,4} = 'Duration:';
    ecgexportmx{1,5} = strcat(sprintf('%4.3f',length(ecg)/fs), '[s]');
    set(handles.textFs, 'String', strcat(num2str(fs), '[Hz]'));
    ecgexportmx{1,7} = 'Fs:';
    ecgexportmx{1,8} = strcat(num2str(fs), '[Hz]');

    ecg = ((ecg + fa)*fb) - fc;
    t = 0:1/fs:(length(ecg)-1)/fs;
    axes(handles.ecgaxes);
    ecgplot = plot(t, ecg);
    axis([0 max(t) min(ecg) max(ecg)]);
    xlabel('[seg]');
    ylabel('uV');
    grid on;
    set([handles.process handles.invert handles.zoombutton], 'Enable', 'on');
catch error
    error;
    return;
end

delete(handles.hpeack);
delete(handles.hvhr);
delete(handles.hvhrspec);

handles.t = t;
handles.ecgplot = ecgplot;
handles.ecgexportmx = ecgexportmx;

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupECG_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
% --- Executes on button press in process.
function process_Callback(hObject, eventdata, handles)

t = handles.t;
ecgplot = handles.ecgplot;
ecgexportmx = handles.ecgexportmx;

ecg = get(ecgplot, 'ydata');

[b, a] = butter(4, 40/1000);
ecg = filter(b, a, ecg);

deriv2 = [0 diff(diff(ecg)) 0];
sqderiv2 = deriv2.^2;

level1 = prctile(sqderiv2, 98);
level2 = prctile(sqderiv2, 97);

for i = 1:length(sqderiv2)
    if sqderiv2(i) < level1
        sqderiv2(i) = 0;
    end
end

figure;
plot(sqderiv2);
    
r_start = 0;
r_seg = 0;
i_rm = 1;

for i = 1:length(sqderiv2)
    if sqderiv2(i) > 0
        r_start = 1;
        r_seg = r_seg + 1;
    else
        if r_start == 1
            delta = i - (r_seg);
           yaxis_r(i_rm) = t(delta);
           r_matrix(i_rm) = ecg(delta);
            if r_matrix(i_rm) > level2
                i_rm = i_rm + 1;
            end
            r_start = 0;
            r_seg = 0;
         end
    end
end

check = diff(yaxis_r);
repeated = find(check < (60/180));
yaxis_r(repeated + 1) = [];
r_matrix(repeated + 1) = [];

if r_matrix(length(r_matrix)) < level2
    r_matrix = r_matrix(1:length(r_matrix)-1);
    yaxis_r = yaxis_r(1:length(yaxis_r)-1);
end

handles = vhrfcn(yaxis_r, r_matrix, hObject, handles);
set([handles.editr handles.zoombutton handles.slide handles.ecgrestart], 'Enable', 'on');
set([handles.ecgopen handles.invert], 'Enable', 'off');

handles.yaxis_r = yaxis_r;
handles.r_matrix = r_matrix;

guidata(hObject, handles);


% --- Executes on button press in editr.
function editr_Callback(hObject, eventdata, handles)

switch get(hObject,'Value')
    case 1
        hdata = datacursormode;
        datacursormode on;
        set([handles.addr handles.remove], 'Enable', 'on');
        set([handles.slide handles.zoombutton], 'Value', 0);
    case 0
        set([handles.addr handles.remove], 'Enable', 'off', 'Value', 0);
        datacursormode off;
end

handles.hdata = hdata;

guidata(hObject, handles);


% --- Executes on button press in addr.
function addr_Callback(hObject, eventdata, handles)

hdata = handles.hdata;
r_matrix = handles.r_matrix;
yaxis_r = handles.yaxis_r;
hvhr = handles. hvhr;
hvhrspec = handles.hvhrspec;
hpeack = handles.hpeack;

datainfo = getCursorInfo(hdata);
[height width] = size(datainfo);

switch isempty(datainfo)
    case 0
        for n = 1:width
            spotposition = datainfo(1,n).Position;
            yaxis_r(length(yaxis_r)+1) = spotposition(1);
            yaxis_r = sort(yaxis_r);
            index = find(yaxis_r == spotposition(1));
            if index > 1
               temp = r_matrix(1:index-1);
               temp(index) = spotposition(2);
               temp(index+1:length(r_matrix)+1) = r_matrix(index:length(r_matrix));
            else
               temp = [spotposition(2) r_matrix];
            end
            r_matrix = temp;
        end
    case 1
        msgbox('Make sure at least one point is selected.');
        beep;
end

delete(hpeack);
delete(hvhr);
delete(hvhrspec);

handles = vhrfcn(yaxis_r, r_matrix, hObject, handles);
handles.r_matrix = r_matrix;
handles.yaxis_r = yaxis_r;
handles.hdata = hdata;

guidata(hObject, handles);


% --- Executes on button press in remove.
function remove_Callback(hObject, eventdata, handles)

hdata = handles.hdata;
r_matrix = handles.r_matrix;
yaxis_r = handles.yaxis_r;
hvhr = handles. hvhr;
hvhrspec = handles.hvhrspec;
hpeack = handles.hpeack;

datainfo = getCursorInfo(hdata);
[height width] = size(datainfo);

switch isempty(datainfo)
    case 0
        for n = 1:width
            spotposition = datainfo(1,n).Position;
            ytemp = yaxis_r - spotposition(1);
            [minimum minindex] = min(abs(ytemp));
            yaxis_r(minindex) = [];
            r_matrix(minindex) = [];
        end
    case 1
        msgbox('Make sure at least one point is selected.');
        beep;
end

delete(hpeack);
delete(hvhr);
delete(hvhrspec);

handles = vhrfcn(yaxis_r, r_matrix, hObject, handles);
handles.r_matrix = r_matrix;
handles.yaxis_r = yaxis_r;
handles.hdata = hdata;

guidata(hObject, handles);


% --- Executes on button press in zoombutton.
function zoombutton_Callback(hObject, eventdata, handles)

switch get(hObject, 'Value')
    case 1
        zoom on;
        set([handles.slide handles.editr], 'Value', 0);
        set([handles.addr handles.remove], 'Value', 0, 'Enable', 'off');
    case 0
        zoom off;
end


% --- Executes on button press in slide.
function slide_Callback(hObject, eventdata, handles)

switch get(hObject,'value')
    case 1
        pan xon;
        set([handles.zoombutton handles.editr], 'Value', 0);
        set([handles.addr handles.remove], 'Value', 0, 'Enable', 'off');
    case 0
        pan off;
end


% --------------------------------------------------------------------
function ecgrestart_Callback(hObject, eventdata, handles)

restartans = questdlg('Are you sure you want to restart the module?','Attention','No');
switch restartans
    case 'Yes'
        delete(handles.hvhr);
        delete(handles.hvhrspec);
        delete(handles.hpeack);
        delete(handles.ecgplot);
        set(handles.ecgaxes, 'xlim', [0 1], 'ylim', [0 1]);
        set(handles.vhraxes, 'xlim', [0 1], 'ylim', [0 1]);
        set(handles.vhrspecaxes, 'xlim', [0 1], 'ylim', [0 1]);
        set(handles.popupECG, 'Visible', 'off');
        set([handles.process handles.ecgrestart], 'Enable', 'off');
        set([handles.editr handles.addr handles.remove handles.zoombutton handles.slide],...
            'Value', 0, 'Enable', 'off');
        zoom off;
        datacursormode off;
        pan off;
        set(handles.beats, 'String', 'Beats:');
        set(handles.sdnn, 'String', 'SDNN:');
        set(handles.rms, 'String', 'RMSSD:');
        set(handles.lfhf, 'String', 'LF/HF:');
        set(handles.pnn50, 'String', 'pNN50:');
        set(handles.text1, 'String', 'Signal:');
        set(handles.ecgduration, 'String', 'Duration:');
        set(handles.ecgfs, 'String', 'Fs:');
        set(handles.ecgopen, 'Enable', 'on');
        set(handles.showdc, 'Enable', 'off', 'Value', 0);
        set([handles.figurevhr handles.figurevhrspec], 'Enable', 'off');
        clear handles.ecgpath handles.ecgname handles.yaxis_r handles.r_matrix handles.vhr handles.vhrspectrum handles.t handles.hvhr handles.hvhrspec handles.hpeack handles.ecgplot handles.vhrspectrum handles.ecgexportmx
    case 'No'
        return;
end


% --- Executes on button press in showdc.
function showdc_Callback(hObject, eventdata, handles)

vhrspectrum = handles.vhrspectrum;
faxis = handles.faxis;

switch get(handles.showdc, 'value')
    case 1
        set(handles.vhrspecaxes, 'xlim', [0 0.5], 'ylim', [0 max(vhrspectrum)]);
    case 0
        set(handles.vhrspecaxes, 'xlim', [faxis(2) 0.5],...
            'ylim', [0 max(vhrspectrum(2:length(vhrspectrum)))]);
end
% Hint: get(hObject,'Value') returns toggle state of showdc


% --------------------------------------------------------------------
function ecgexport_Callback(hObject, eventdata, handles)

ecgexportmx = handles.ecgexportmx;

ecgexportmx{9,1} = 'Peaks Detected';
for ex = 1:length(handles.yaxis_r)
    ecgexportmx{9+ex,1} = handles.yaxis_r(ex);
end

[xlsfile xlspath] = uiputfile('*.xls', 'Save File');
xlswrite(strcat(xlspath, xlsfile), ecgexportmx);


% --- Executes on button press in invert.
function invert_Callback(hObject, eventdata, handles)

ecgplot = handles.ecgplot;

ecgdata = get(ecgplot, 'ydata');
set(ecgplot(), 'ydata', -ecgdata);
axis tight;


% --- Executes on selection change in processoption.
function processoption_Callback(hObject, eventdata, handles)
% hObject    handle to processoption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns processoption contents as cell array
%        contents{get(hObject,'Value')} returns selected item from processoption


% --- Executes during object creation, after setting all properties.
function processoption_CreateFcn(hObject, eventdata, handles)
% hObject    handle to processoption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


