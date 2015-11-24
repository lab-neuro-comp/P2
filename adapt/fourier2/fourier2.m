function varargout = fourier2(varargin)
% FOURIER2 M-file for fourier2.fig
%      FOURIER2, by itself, creates a new FOURIER2 or raises the existing
%      singleton*.
%
%      H = FOURIER2 returns the handle to a new FOURIER2 or the handle to
%      the existing singleton*.
%
%      FOURIER2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FOURIER2.M with the given input arguments.
%
%      FOURIER2('Property','Value',...) creates a new FOURIER2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fourier2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fourier2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fourier2

% Last Modified by GUIDE v2.5 25-May-2009 16:01:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fourier2_OpeningFcn, ...
                   'gui_OutputFcn',  @fourier2_OutputFcn, ...
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


% --- Executes just before fourier2 is made visible.
function fourier2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fourier2 (see VARARGIN)

% Choose default command line output for fourier2
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fourier2 wait for user response (see UIRESUME)
% uiwait(handles.fourierpanel);
global deltaf1 deltaf2 thetaf1 thetaf2 alphaf1 alphaf2 bethaf1 bethaf2 gammaf1 gammaf2 fa fb fc fs frhzoom hfourier pcalc
clc

set(handles.fsinfo,'string',strcat('Fs:',num2str(fs),'[Hz]'));
axes(handles.frqaxes);grid on
set(handles.axetime,'visible','off')
frhzoom=zoom;
set(frhzoom,'actionprecallback',@getlimits);
set(frhzoom,'actionpostcallback',@checkaxes);
set(frhzoom,'RightClickAction', 'InverseZoom');
set(handles.fmaxima,'string',num2str(fs/2))
maxfig(gcf,1);
initialize;
hfourier=handles;
pcalc=@powcalc;

function initialize
global frmaxpw frmintime frmaxtime frtimereg  frcolorname frnumsig frsignalinfo frwindowname
frnumsig=1;
frsignalinfo=[];
frmaxpw=[];
frmintime=[];
frmaxtime=[];
frtimereg=[];
frwindowname='hanning';
frcolorname{1,1}='Blue'; frcolorname{1,2}=0; frcolorname{1,3}='b';
frcolorname{2,1}='Red'; frcolorname{2,2}=0; frcolorname{2,3}='r';
frcolorname{3,1}='Green'; frcolorname{3,2}=0; frcolorname{3,3}='g';
frcolorname{4,1}='Black'; frcolorname{4,2}=0; frcolorname{4,3}='k';
frcolorname{5,1}='Yellow'; frcolorname{5,2}=0; frcolorname{5,3}='y';
frcolorname{6,1}='Ciam'; frcolorname{6,2}=0; frcolorname{6,3}='c';
frcolorname{7,1}='Magenta'; frcolorname{7,2}=0; frcolorname{7,3}='m';
set(findobj('tag','wdwname'),'string',strcat('Window:',frwindowname));

function originalspec
global frsignalinfo frnumsig
for i=1:frnumsig-1
    set(frsignalinfo{i,3},'xdata',frsignalinfo{i,11},'ydata',frsignalinfo{i,12})
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%frsignalinfo: NAME LENGTH PLOTFREQ frcolorname COLORSTATE COLORCODE MAX MIN NAMECOLOR PLOTIME
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Outputs from this function are returned to the command line.
function varargout = fourier2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% --- Executes on button press in savedata.
function savedata_Callback(hObject, eventdata, handles)
% --- Executes on button press in savefigure.
savedatafourier
function savefigure_Callback(hObject, eventdata, handles)
% --- Executes on button press in zoombutton.

function prelimits=getlimits(hObject, eventdata, handles)
global frprexlimits frpreylimits
frprexlimits=get(gca,'xlim');
frpreylimits=get(gca,'ylim');

function zoombutton_Callback(hObject, eventdata, handles)
global fs frmaxpw frmaxtime frmintime frtimereg  frhaxetime frhfrqaxes frhzoom
switch get(handles.zoombutton,'value')
    case 0
        set(frhzoom,'enable','off')
        axes(handles.axetime)
        switch isempty(frtimereg)
            case 0
                axis([0 max(frtimereg) min(frmintime) max(frmaxtime)])
        end
        axes(handles.frqaxes)
        axis([0 fs/2 0 max(frmaxpw)])
        originalspec
        set(handles.tminimo,'string','0')
        set(handles.tmaximo,'string',num2str(max(frtimereg)))
    case 1
        set(frhzoom,'enable','on')
        frhaxetime=handles.axetime;
        frhfrqaxes=handles.frqaxes;
end
%--------------------------------------------------------------------
function checkaxes(hObject, eventdata, handles)
global frtimereg fs frnumsig frsignalinfo frhaxetime frhfrqaxes frprexlimits frpreylimits
switch gca
    case frhaxetime
        timelim=get(frhaxetime,'xlim');
        if timelim(2)>max(frtimereg)
            timelim(2)=max(frtimereg);
            set(frhaxetime,'xlim',timelim)
        end
        if timelim(1)<0
            timelim(1)=0;
            set(frhaxetime,'xlim',timelim)
        end
        if timelim(1)>min(frtimereg)
            msgbox('The interval selected must be valid for all signals','Invalid Interval','warn')
            set(frhaxetime,'xlim',frprexlimits)
            set(frhaxetime,'ylim',frpreylimits)
            return
        end
        set(findobj('tag','tminimo'),'string',num2str(timelim(1)))
        set(findobj('tag','tmaximo'),'string',num2str(timelim(2)))
        for i=1:frnumsig-1
            p2=timelim(2)*fs;
            if p2>frsignalinfo{i,2}
                p2=frsignalinfo{i,2};
            end
            data_interval=get(frsignalinfo{i,10},'ydata');
            interval=data_interval(round(timelim(1)*fs)+1:round(p2));
            [faxis_interval freqsignal_interval]=specalc(interval');
            maxpow_interval(i)=max(freqsignal_interval);
            xdatainterval=0:fs/(length(interval)-1):fs;
            set(frsignalinfo{i,3},'xdata',xdatainterval,'ydata',freqsignal_interval');
        end
        set(frhfrqaxes,'ylim',[0 max(maxpow_interval)])
        handles=guihandles;
        powcalc(handles)
    case frhfrqaxes
        frqlim=get(frhfrqaxes,'xlim');
        if frqlim(2)>fs/2
            set(frhfrqaxes,'xlim',[frqlim(1) fs/2])
        end
        if frqlim(1)<0
            set(frhfrqaxes,'xlim',[0 frqlim(2)])
        end
        set(findobj('tag','fminima'),'string',num2str(frqlim(1)))
        set(findobj('tag','fmaxima'),'string',num2str(frqlim(2)))
end
% --------------------------------------------------------------------

function fmaxima_Callback(hObject, eventdata, handles)
global frdeferror
frdeferror=checkvalue(handles.fmaxima);

% --- Executes during object creation, after setting all properties.
function fmaxima_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fmaxima (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --------------------------------------------------------------------
function fminima_Callback(hObject, eventdata, handles)
global frdeferror
frdeferror=checkvalue(handles.fminima);


% --- Executes during object creation, after setting all properties.
function fminima_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fminima (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes on button press in refreshfreq.
function refreshfreq_Callback(hObject, eventdata, handles)
global fs frdeferror frhzoom
set(handles.zoombutton,'value',1)
set(frhzoom,'enable','on')
if frdeferror==1
    beep
    return
end
if str2num(get(handles.fmaxima,'string'))>fs/2
    msgbox('The maximum value allowed is Fs/2')
    set(handles.fmaxima,'string',num2str(fs/2))
    return
end
if str2num(get(handles.fmaxima,'string'))<str2num(get(handles.fminima,'string'))
    msgbox('This value most be 0<=fmin<fmax<=Fs/2')
    set(handles.fmaxima,'string',num2str(fs/2))
    return
end
if str2num(get(handles.fminima,'string'))<0
    msgbox('The minimum value allowed is 0')
    set(handles.fminima,'string','0')
    return
end
set(handles.frqaxes,'xlim',[str2num(get(handles.fminima,'string')) str2num(get(handles.fmaxima,'string'))])
% --------------------------------------------------------------------
function tmaximo_Callback(hObject, eventdata, handles)
global frdeferror
frdeferror=checkvalue(handles.tmaximo);

% --- Executes during object creation, after setting all properties.
function tmaximo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tmaximo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --------------------------------------------------------------------
function tminimo_Callback(hObject, eventdata, handles)
global frdeferror
frdeferror=checkvalue(handles.tminimo);

% --- Executes during object creation, after setting all properties.
function tminimo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tminimo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in refreshtime.
function refreshtime_Callback(hObject, eventdata, handles)
global frtimereg frdeferror frhzoom frhaxetime frhfrqaxes
set(handles.zoombutton,'value',1)
set(frhzoom,'enable','on')
if frdeferror==1
    beep
    return
end
if str2num(get(handles.tmaximo,'string'))>max(frtimereg)
    msgbox('The maximum value allowed')
    set(handles.tmaximo,'string',num2str(max(frtimereg)))
    return
end
if str2num(get(handles.tmaximo,'string'))<str2num(get(handles.tminimo,'string'))
    msgbox('This value most be 0<=tmin<tmax')
    set(handles.tmaximo,'string',num2str(max(frtimereg)))
    return
end
if str2num(get(handles.tminimo,'string'))<0
    msgbox('The minimum value allowed is 0')
    set(handles.tminimo,'string','0')
    return
end
set(handles.axetime,'xlim',[str2num(get(handles.tminimo,'string')) str2num(get(handles.tmaximo,'string'))])
axes(handles.axetime)
frhaxetime=handles.axetime;
frhfrqaxes=handles.frqaxes;
checkaxes(hObject, eventdata, handles)

% --- Executes on selection change in listfiles.
function listfiles_Callback(hObject, eventdata, handles)
powcalc(handles)
% --- Executes during object creation, after setting all properties.
function listfiles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listfiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes on button press in refreshpow.
function refreshpow_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function fourierfile_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function fourierconfig_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function fourierwdw_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function fourieropen_Callback(hObject, eventdata, handles)
% hObject    handle to fourieropen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global frsignalinfo frnumsig fa fb fc fs frtimereg frcolorname frtimesignal frmaxtime frmintime t
if frnumsig>7
    msgbox('Remove one signal before include another one','Maximum number of signals reached','warn');
end
[signalext,filepath]=uigetfile('*.ascii','Open File');
switch ischar(signalext);
    case 0;
        return;
end;
try
    signal=load(strcat(filepath,signalext));
    signal=((signal+fa)*fb)-fc;
    frsignalinfo{frnumsig,1}=signalext(1:length(signalext)-6);
    frsignalinfo{frnumsig,7}=max(signal);
    frsignalinfo{frnumsig,8}=min(signal);
    frsignalinfo{frnumsig,2}=length(signal);
    frtimereg(frnumsig)=(length(signal)-1)/fs;
    frmaxtime(frnumsig)=max(signal); %informacion repetida con dos lineas arriba
    frmintime(frnumsig)=min(signal);
    set(handles.tmaximo,'string',num2str(max(frtimereg)))
    for i=1:7
        if frcolorname{i,2}==0;
            frtimesignal{frnumsig,1}=signal;
            frtimesignal{frnumsig,2}=frcolorname{i,3};
            break;
        end;
    end;
    switch strcmp('on',get(handles.axetime,'visible'))
        case 1
            t=0:1/fs:(frsignalinfo{frnumsig,2}-1)/fs;
            axes(handles.axetime)
            frsignalinfo{frnumsig,10}=plot(t,signal,frtimesignal{frnumsig,2});
            axis([0 max(frtimereg) min(frmintime) max(frmaxtime)])
            set(handles.tmaximo,'string',num2str(max(frmaxtime)))
            originalspec
    end
    [faxis freqsignal]=specalc(signal);
    frsignalinfo{frnumsig,11}=faxis;
    frsignalinfo{frnumsig,12}=freqsignal;
    plotspec(freqsignal,faxis,handles)
    set(handles.fourierwdw,'enable','off')
catch error
    error
    beep;
    msgbox('Incompatible file format','Invalid File','warn');
    return
end
% --------------------------------------------------------------------

% function [faxis freqsignal]=specalc(signal)
% global fs frwindowname
% faxis=0:fs/(length(signal)-1):fs;
% window=eval(strcat(frwindowname,'(',num2str(length(signal)),')'));
% freqsignal=abs(fft(signal.*window)./length(signal));
function [faxis freqsignal]=specalc(signal)
global fs
    [freqsignal,faxis]=pwelch(signal,512,256,2^11,fs);

function plotspec(freqsignal,faxis,handles)
global frnumsig frsignalinfo frcolorname frmaxpw fs

frmaxpw(frnumsig)=max(freqsignal);

for i=1:7
    if frcolorname{i,2}==0;
       frsignalinfo{frnumsig,4}=frcolorname{i,1};
       frsignalinfo{frnumsig,5}=frcolorname{i,3};
       frsignalinfo{frnumsig,6}=i;
       frsignalinfo{frnumsig,9}=strcat(frsignalinfo{frnumsig,1},'(',frsignalinfo{frnumsig,4},')');
       frcolorname{i,2}=1;
       break;
    end;
end;
axes(handles.frqaxes)
frsignalinfo{frnumsig,3}=plot(faxis,freqsignal,frsignalinfo{frnumsig,5});
set(handles.listfiles,'string',frsignalinfo(:,9),'value',frnumsig)
set(handles.filetime,'string',strcat('Time:',sprintf('%4.3f',frsignalinfo{frnumsig,2}/fs),'[s]'))
xlabel('[Hz]')
ylabel('[uV^2]')
hold on
axis([0 fs/2 0 max(frmaxpw)]);
powcalc(handles);
frnumsig=frnumsig+1;
grid on
set([handles.removesignal handles.viewtime],'enable','on')
set([handles.refreshfreq handles.fminima handles.fmaxima],'enable','on')
set([handles.zoombutton handles.datainfo],'enable','on')
set([handles.savedata handles.savefigure],'enable','on')
% --------------------------------------------------------------------
function [deltapower,thetapower,alphapower,bethapower,gammapower,powtotal]=powcalc(handles)
global frsignalinfo fs deltaf1 deltaf2 thetaf1 thetaf2 alphaf1 alphaf2 bethaf1 bethaf2 gammaf1 gammaf2
sigid=get(handles.listfiles,'value');
set(handles.powname,'string',strcat('Signal:',frsignalinfo{sigid,1}))
specdata=get(frsignalinfo{sigid,3},'ydata');
deltap1=round(deltaf1*length(specdata)/fs);
deltap2=round(deltaf2*length(specdata)/fs);
deltapower=0;
for i1=deltap1:deltap2
    deltapower=deltapower+specdata(i1)^2;
end
thetap1=round(thetaf1*length(specdata)/fs);
thetap2=round(thetaf2*length(specdata)/fs);
thetapower=0;
for i2=thetap1:thetap2
    thetapower=thetapower+specdata(i2)^2;
end
alphap1=round(alphaf1*length(specdata)/fs);
alphap2=round(alphaf2*length(specdata)/fs);
alphapower=0;
for i3=alphap1:alphap2
    alphapower=alphapower+specdata(i3)^2;
end
bethap1=round(bethaf1*length(specdata)/fs);
bethap2=round(bethaf2*length(specdata)/fs);
bethapower=0;
for i4=bethap1:bethap2
    bethapower=bethapower+specdata(i4)^2;
end
gammap1=round(gammaf1*length(specdata)/fs);
gammap2=round(gammaf2*length(specdata)/fs);
gammapower=0;
for i5=gammap1:gammap2
    gammapower=gammapower+specdata(i5)^2;
end
powtotal=0;
for i6=1:length(specdata)/2
    powtotal=powtotal+specdata(i6)^2;
end
set(handles.powtime,'string',strcat('Time interval: [',get(handles.tminimo,'string'),':',get(handles.tmaximo,'string'),']'))
set(handles.deltapow,'string',strcat('Delta:',sprintf('%10.5f',deltapower)))
set(handles.tethapow,'string',strcat('Theta:',sprintf('%10.5f',thetapower)))
set(handles.alphapow,'string',strcat('Alpha:',sprintf('%10.5f',alphapower)))
set(handles.bethapow,'string',strcat('Betha:',sprintf('%10.5f',bethapower)))
set(handles.gammapow,'string',strcat('Gamma:',sprintf('%10.5f',gammapower)))
set(handles.currentpow,'string',sprintf('%10.3f',powtotal))
set(handles.filetime,'string',strcat('Time:',num2str(frsignalinfo{sigid,2}/fs),'[s]'))
% --------------------------------------------------------------------
function fourierexit_Callback(hObject, eventdata, handles)
exit=questdlg('Are you sure you want to quit?','Quit Fourier Module','Yes','No','No');
switch strcmp(exit,'Yes')
    case 1
        delete(gcf)
        clear global fr*
end
% --------------------------------------------------------------------
function hanningwdw_Callback(hObject, eventdata, handles)
global frwindowname
set(findobj('checked','on'),'checked','off')
set(hObject,'checked','on')
frwindowname='hanning';
set(handles.wdwname,'string',strcat('Window:',frwindowname));

% --------------------------------------------------------------------
function hammingwdw_Callback(hObject, eventdata, handles)
global frwindowname
set(findobj('checked','on'),'checked','off')
set(hObject,'checked','on')
frwindowname='hamming';
set(handles.wdwname,'string',strcat('Window:',frwindowname));

% --------------------------------------------------------------------
function blackmanwdw_Callback(hObject, eventdata, handles)
global frwindowname
set(findobj('checked','on'),'checked','off')
set(hObject,'checked','on')
frwindowname='blackman';
set(handles.wdwname,'string',strcat('Window:',frwindowname));

% --------------------------------------------------------------------
function kaiserwdw_Callback(hObject, eventdata, handles)
global frwindowname
set(findobj('checked','on'),'checked','off')
set(hObject,'checked','on')
frwindowname='kaiser';
set(handles.wdwname,'string',strcat('Window:',frwindowname));


% --------------------------------------------------------------------
function gausswdw_Callback(hObject, eventdata, handles)
global frwindowname
set(findobj('checked','on'),'checked','off')
set(hObject,'checked','on')
frwindowname='gausswin';
set(handles.wdwname,'string',strcat('Window:',frwindowname));

% --- Executes on button press in removesignal.


function removesignal_Callback(hObject, eventdata, handles)
global frsignalinfo frtimesignal frnumsig frmaxpw frcolorname frtimereg frmintime frmaxtime
sigid=get(handles.listfiles,'value');
delete(frsignalinfo{sigid,3})
switch strcmp('on',get(handles.axetime,'visible'))
    case 1
        delete(frsignalinfo{sigid,10})
        frtimereg(sigid)=[];
        frmintime(sigid)=[];
        frmaxtime(sigid)=[];
        axes(handles.axetime)
        switch isempty(frtimereg)
            case 1
                axis([0 1 0 1])
            case 0
                axis([0 max(frtimereg) min(frmintime) max(frmaxtime)])
        end
end
frcolorname{frsignalinfo{sigid,6},2}=0;
frtimesignal(sigid,:)=[];
frsignalinfo(sigid,:)=[];
frmaxpw(sigid)=[];
frnumsig=frnumsig-1;
list=get(handles.listfiles,'string');
list(sigid)=[];
switch isempty(list)
    case 1
        set(handles.listfiles,'string','None','value',1)
        set(handles.frqaxes,'ylim',[0 1],'xlim',[0 1])
        set([handles.refreshfreq handles.fminima handles.fmaxima],'enable','off')
        set([handles.zoombutton handles.datainfo],'enable','off')
        set([handles.savedata handles.savefigure],'enable','off')
    case 0
       set(handles.listfiles,'string',list,'value',1)
       originalspec
       powcalc(handles)
       set(handles.frqaxes,'ylim',[0 max(frmaxpw)])
end
% --- Executes during object deletion, before destroying properties.
function fourierpanel_DeleteFcn(hObject, eventdata, handles)
clear global fr*
% --- Executes on button press in viewtime.
function viewtime_Callback(hObject, eventdata, handles)
% hObject    handle to viewtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of viewtime
global frsignalinfo frnumsig frtimesignal fs frmaxtime frmintime frtimereg
axesposition=get(handles.frqaxes,'position');
switch get(handles.viewtime,'value')
    case 1
        axesposition(4)=0.58;
        axes(handles.axetime);
        for k=1:frnumsig-1
            t=0:1/fs:(frsignalinfo{k,2}-1)/fs;
            frsignalinfo{k,10}=plot(t,frtimesignal{k,1},frtimesignal{k,2});
            hold on
        end
        axis([0 max(frtimereg) min(frmintime) max(frmaxtime)])
        xlabel('[seg]')
        ylabel('[uV]')
        grid on
        set(handles.axetime,'visible','on')
        set([handles.refreshtime handles.tminimo handles.tmaximo],'enable','on')
    case 0
        axesposition(4)=0.86;
        set(handles.axetime,'visible','off')
        for k=1:frnumsig-1
            delete(frsignalinfo{k,10})
            frsignalinfo{k,10}=[];
        end
        set([handles.tminimo handles.tmaximo],'string','0')
        set([handles.refreshtime handles.tminimo handles.tmaximo],'enable','off')
        originalspec
end
set(handles.frqaxes,'position',axesposition)

% --- Executes on button press in datainfo.
function datainfo_Callback(hObject, eventdata, handles)
global frhzoom
switch get(handles.datainfo,'value')
    case 1
        set(frhzoom,'enable','off')
        set(handles.zoombutton,'value',0)
        datacursormode on
    case 0
        datacursormode off
end


% --------------------------------------------------------------------
function rhythmconfig_Callback(hObject, eventdata, handles)
% hObject    handle to rhythmconfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rhythmconfig

% --------------------------------------------------------------------
function restart_Callback(hObject, eventdata, handles)
% hObject    handle to restart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global frsignalinfo
restart=questdlg('Are you sure you want to restart?','Restart Fourier Module','Yes','No','No');
switch strcmp(restart,'Yes')
    case 1
        delete(frsignalinfo{:,3})
        switch strcmp('on',get(handles.axetime,'visible'))
            case 1
                delete(frsignalinfo{:,10})
                axeposition=get(handles.frqaxes,'position');
                axeposition(4)=0.86;
                set(handles.axetime,'visible','off')
                set(handles.frqaxes,'position',axeposition);
        end
        set(handles.listfiles,'value',1,'string','None')
        set(findobj('style','pushbutton'),'enable','off')
        set(findobj('style','togglebutton'),'enable','off')
        set(findobj('style','edit'),'enable','off','string','0')
        set(handles.powname,'string','Signal:')
        set(handles.powtime,'string','Time Interval:')
        set(handles.deltapow,'string','Delta:')
        set(handles.thetapow,'string','Theta:')
        set(handles.alphapow,'string','Alpha:')
        set(handles.bethapow,'string','Betha:')
        set(handles.gammapow,'string','Gamma:')
        set(handles.currentpow,'string','0.0')
        set(handles.filetime,'string','Time:')
        set([handles.axetime handles.frqaxes],'xlim',[0 1],'ylim',[0 1])
        set(handles.viewtime,'value',0,'enable','off')
        set(handles.fourierwdw,'enable','on')
        clear global fr*
        initialize;
        hanningwdw_Callback(handles.hanningwdw, eventdata, handles)
end
