function varargout = stft2(varargin)
% STFT2 M-file for stft2.fig
%      STFT2, by itself, creates a new STFT2 or raises the existing
%      singleton*.
%
%      H = STFT2 returns the handle to a new STFT2 or the handle to
%      the existing singleton*.
%
%      STFT2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STFT2.M with the given input arguments.
%
%      STFT2('Property','Value',...) creates a new STFT2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before stft2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to stft2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help stft2

% Last Modified by GUIDE v2.5 02-Oct-2009 16:36:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @stft2_OpeningFcn, ...
                   'gui_OutputFcn',  @stft2_OutputFcn, ...
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


% --- Executes just before stft2 is made visible.
function stft2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to stft2 (see VARARGIN)

% Choose default command line output for stft2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes stft2 wait for user response (see UIRESUME)
% uiwait(handles.stftpanel);
global deltaf1 deltaf2 thetaf1 thetaf2 alphaf1 alphaf2 bethaf1 bethaf2 gammaf1 gammaf2 fa fb fc fs stftpow
clc
deltaf1=0.5;
deltaf2=3.5;
thetaf1=3.5;
thetaf2=7;
alphaf1=8;
alphaf2=13;
bethaf1=15;
bethaf2=24;
gammaf1=30;
gammaf2=70;
fa=4096;
fb=0.0610426077402027;
fc=250;
fs=256;
% set(handles.taxes,'xlabel','Frequency [Hz]')
% set(handles.taxes,'ylabel','[uV^2]')
% set(handles.faxes,'xlabel','Time [s]')
% set(handles.faxes,'ylabel','[uV^2]')
stftpow=@powcalc;
set(handles.faxes)




% --- Outputs from this function are returned to the command line.
function varargout = stft2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in plottaxes.
function plottaxes_Callback(hObject, eventdata, handles)
% hObject    handle to plottaxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global f p
axes(handles.taxes)
interval=get(handles.listtime,'value');
plot(f',p(:,interval))
xlabel('[Hz]');
grid on
axis tight


% --- Executes on button press in plotfaxes.
function plotfaxes_Callback(hObject, eventdata, handles)
% hObject    handle to plotfaxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global t p
axes(handles.faxes)
frequency=get(handles.listfreq,'value');
plot(t,p(frequency,:))
xlabel('[s]');
grid on
axis tight


% --- Executes on selection change in listtime.
function listtime_Callback(hObject, eventdata, handles)
% hObject    handle to listtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listtime contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listtime


% --- Executes during object creation, after setting all properties.
function listtime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function listfreq_Callback(hObject, eventdata, handles)
% hObject    handle to listfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of listfreq as text
%        str2double(get(hObject,'String')) returns contents of listfreq as a double


% --- Executes during object creation, after setting all properties.
function listfreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sizewinedit_Callback(hObject, eventdata, handles)
% hObject    handle to sizewinedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sizewinedit as text
%        str2double(get(hObject,'String')) returns contents of sizewinedit as a double


% --- Executes during object creation, after setting all properties.
function sizewinedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sizewinedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popoverlap.
function popoverlap_Callback(hObject, eventdata, handles)
% hObject    handle to popoverlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popoverlap contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popoverlap


% --- Executes during object creation, after setting all properties.
function popoverlap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popoverlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function filemenu_Callback(hObject, eventdata, handles)
% hObject    handle to filemenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function figuremenu_Callback(hObject, eventdata, handles)
% hObject    handle to figuremenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function rotatemenu_Callback(hObject, eventdata, handles)
% hObject    handle to rotatemenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch strcmp('on',get(hObject,'checked'))
    case 0
        set(hObject,'checked','on')
        rotate3d on
    case 1
        set(hObject,'checked','off')
        rotate3d off
        axes(handles.stftaxes);view(0,90)
        axes(handles.taxes);view(0,90)
        axes(handles.faxes);view(0,90)
end

% --------------------------------------------------------------------
function savefigmenu_Callback(hObject, eventdata, handles)
% hObject    handle to savefigmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function openmenu_Callback(hObject, eventdata, handles)
% hObject    handle to openmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fa fb fc fs signal
[signalext,filepath]=uigetfile('*.ascii','Open File');
switch ischar(signalext);
    case 0;
        return;
end;
try
    signal=load(strcat(filepath,signalext));
    signal=detrend(((signal+fa)*fb)-fc);
    set(handles.infoname,'string',strcat('Signal:',signalext(1:length(signalext)-6)))
    set(handles.infoduration,'string',strcat('Duration [s]:',sprintf('%6.3f',length(signal)/fs)))
    set(handles.infofs,'string',strcat('Fs[Hz]:',num2str(fs)))
    set([handles.popoverlap handles.sizewinedit handles.calculate],'enable','on')
catch
    error
    beep;
    msgbox('Incompatible file format','Invalid File','warn');
    return
end

% --------------------------------------------------------------------
function quitmenu_Callback(hObject, eventdata, handles)
% hObject    handle to quitmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in calculate.
function calculate_Callback(hObject, eventdata, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fs signal f t p
axes(handles.stftaxes)
sizeerror=checkvalue(handles.sizewinedit);
switch sizeerror
    case 1
        return
    case 0
       sizewin=str2double(get(handles.sizewinedit,'string'));
end
overlap_value=get(handles.popoverlap,'value');
overlap_string=get(handles.popoverlap,'string');
overlap=str2double(overlap_string{overlap_value});
[y,f,t,p]=spectrogram(signal,sizewin*fs,overlap,2^15,fs);
% surf(t,f,10*log10(abs(p)),'EdgeColor','none');   
imagesc(t,f,p)
axis xy; axis tight; colormap(jet); view(0,90);
xlabel('Time [s]');
ylabel('Frequency [Hz]');
ylim([8 13])
xlim([40 220])
caxis([0 2.5])
colorbar
tstr{length(t)}='0';
for i=1:length(t)
    tstr{i}=num2str(t(i));
end
set(handles.listtime,'enable','on','string',tstr,'value',round(length(t)/2))
axes(handles.taxes)
plot(f',p(:,round(length(t)/2)))
xlabel('[Hz]');
grid on
axis tight
set(handles.plottaxes,'enable','on')

fstr{length(f)}='0';
for k=1:length(f)
    fstr{k}=num2str(f(k));
end
set(handles.listfreq,'enable','on','string',fstr,'value',round(length(f)/2))
axes(handles.faxes)
plot(t,p(round(length(f)/2),:))
xlabel('[s]');
grid on
axis tight
set(handles.plotfaxes,'enable','on')


% --------------------------------------------------------------------
function scalemenu_Callback(hObject, eventdata, handles)
% hObject    handle to scalemenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function intspecfig_Callback(hObject, eventdata, handles)
% hObject    handle to intspecfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function fqtimefig_Callback(hObject, eventdata, handles)
% hObject    handle to fqtimefig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uv2scale_Callback(hObject, eventdata, handles)
% hObject    handle to uv2scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function dbscale_Callback(hObject, eventdata, handles)
% hObject    handle to dbscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


