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

% Last Modified by GUIDE v2.5 18-May-2009 15:19:59

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
% Update handles structure
guidata(hObject, handles);
clear global yaxis_r r_matrix vhr vhrspectrum t hvhr hvhrspec hpeack ecgplot vhrspectrum ecgexportmx
global fs fa fb fc
fs=1000;
fa=4096;
fb=0.0610426077402027;
fc=250;
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
maxfig(gcf,1);


% UIWAIT makes ecgmodule wait for user response (see UIRESUME)
% uiwait(handles.ecgpanel);


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
global hvhr
xdata=get(hvhr,'xdata');
ydata=get(hvhr,'ydata');
xlim=get(handles.vhraxes,'xlim');
ylim=get(handles.vhraxes,'ylim');
savefigure(xdata,ydata,'b',xlim,ylim,'[s]','[s]','VHR')


% --- Executes on button press in figurevhrspec.
function figurevhrspec_Callback(hObject, eventdata, handles)
global hvhrspec
xdata=get(hvhrspec,'xdata');
ydata=get(hvhrspec,'ydata');
xlim=get(handles.vhrspecaxes,'xlim');
ylim=get(handles.vhrspecaxes,'ylim');
savefigure(xdata,ydata,'b',xlim,ylim,'[Hz]','[ms^2]','VHR SPECTRUM')
% hObject    handle to figurevhrspec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function ecgfile_Callback(hObject, eventdata, handles)
% hObject    handle to ecgfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function ecgopen_Callback(hObject, eventdata, handles)
global fa fb fc fs t ecgplot ecgexportmx
% hObject    handle to ecgopen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ecgext,filepath]=uigetfile('*.ascii','Open File');
switch ischar(ecgext);
    case 0;
        return;
end;
try
    ecg=load(strcat(filepath,ecgext));
    ecgexportmx{1,1}='File:';
    ecgexportmx{1,2}=ecgext;
    set(handles.ecgname,'string',strcat('Signal:',ecgext(1:length(ecgext-6))))
    set(handles.ecgduration,'string',strcat('Duration:',sprintf('%4.3f',length(ecg)/fs),'[s]'))
    ecgexportmx{1,4}='Duration:';
    ecgexportmx{1,5}=strcat(sprintf('%4.3f',length(ecg)/fs),'[s]');
    set(handles.ecgfs,'string',strcat('Fs:',num2str(fs),'[Hz]'))
    ecgexportmx{1,7}='Fs:';
    ecgexportmx{1,8}=strcat(num2str(fs),'[Hz]');
    ecg=((ecg+fa)*fb)-fc;
    t=0:1/fs:(length(ecg)-1)/fs;
    axes(handles.ecgaxes)
    ecgplot=plot(t,ecg);
    axis([0 max(t) min(ecg) max(ecg)])
    xlabel('[seg]')
    ylabel('uV')
    grid on
    set([handles.process handles.invert handles.zoombutton],'enable','on')
catch error
    error
    return
end


% --------------------------------------------------------------------
function ecgexit_Callback(hObject, eventdata, handles)
% hObject    handle to ecgexit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in process.
function process_Callback(hObject, eventdata, handles)
global t ecgplot r_matrix yaxis_r ecgexportmx
% hObject    handle to process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ecg=get(ecgplot,'ydata');

deriv2=[0 diff(diff(ecg)) 0];
sqderiv2=deriv2.^2;

level1=prctile(sqderiv2,98);
level2=prctile(sqderiv2,97);

for i=1:length(sqderiv2)
    if sqderiv2(i)<level1
        sqderiv2(i)=0;
    end
end
r_start=0;
r_seg=0;
i_rm=1;

for i=1:length(sqderiv2)
    if sqderiv2(i)>0
        r_start=1;
        r_seg=r_seg+1;
    else
        if r_start==1
            delta=i-(r_seg);
           yaxis_r(i_rm)=t(delta);
           r_matrix(i_rm)=ecg(delta);
            if r_matrix(i_rm)>level2
                i_rm=i_rm+1;
            end
            r_start=0;
            r_seg=0;
         end
    end
end

check=diff(yaxis_r);
repeated=find(check<(60/180));
yaxis_r(repeated+1)=[];
r_matrix(repeated+1)=[];

if r_matrix(length(r_matrix))<level2
    r_matrix=r_matrix(1:length(r_matrix)-1);
    yaxis_r=yaxis_r(1:length(yaxis_r)-1);
end
ecgexportmx{9,1}='Peaks Detected';
for ex=1:length(yaxis_r)
    ecgexportmx{9+ex,1}=yaxis_r(ex);
end
vhrfcn(yaxis_r,r_matrix,handles)
set([handles.editr handles.zoombutton handles.slide handles.ecgrestart],'enable','on')
set([handles.ecgopen handles.invert],'enable','off')



function vhrfcn(tvalue,rvalue,handles)
global hvhr hvhrspec hpeack vhrspectrum faxis ecgexportmx
vhr=diff(tvalue);
ecgexportmx{9,3}='HRV(R-R)[s]';
for ex=1:length(vhr)
    ecgexportmx{9+ex,3}=vhr(ex);
end
axes(handles.ecgaxes)
hold on
hpeack=plot(tvalue,rvalue,'or');
axes(handles.vhraxes)
hvhr=plot(tvalue(2:length(tvalue)),vhr);
xlabel('[s]')
ylabel('[s]')
title('VHR')
axis tight
grid on
axes(handles.vhrspecaxes)
vhrspectrum=abs(fft(vhr));
ecgexportmx{9,5}='HRV SPECTRUM';
ecgexportmx{10,5}='Power [ms^2]';
ecgexportmx{10,6}='Frequency [Hz]';
faxis=0:1/(length(vhr)-1):1;
for ex=1:length(vhrspectrum)
    ecgexportmx{10+ex,5}=vhrspectrum(ex);
    ecgexportmx{10+ex,6}=faxis(ex);
end
[p1 p004]=min(abs(faxis-0.04));
[p1 p015]=min(abs(faxis-0.15));
[p1 p04]=min(abs(faxis-0.4));
hf=0;
lf=0;
for i=p004:p015
    lf=lf+vhrspectrum(i)^2;
end
for k=p015+1:p04
    hf=hf+vhrspectrum(k)^2;
end
hvhrspec=plot(faxis,vhrspectrum);
xlabel('[Hz]')
ylabel('[ms^2]')
title('VHR SPECTRUM')
axis tight
set(handles.vhrspecaxes,'xlim',[0 0.5])
grid on
set(handles.beats,'string',strcat('Beats:',num2str(length(tvalue))))
ecgexportmx{3,1}='Beats:';
ecgexportmx{3,2}=length(tvalue);
set(handles.sdnn,'string',strcat('SDNN:',num2str(std(vhr))))
ecgexportmx{4,1}='SDNN:';
ecgexportmx{4,2}=std(vhr);
rmsvhr=(sum(vhr.^2)/length(vhr))^0.5;
set(handles.rms,'string',strcat('RMSSD:',num2str(rmsvhr)))
ecgexportmx{5,1}='RMSSD:';
ecgexportmx{5,2}=rmsvhr;
set(handles.lfhf,'string',strcat('LF/HF:',num2str(lf/hf)))
ecgexportmx{7,1}='LF/HF:';
ecgexportmx{7,2}=lf/hf;
ecgexportmx{6,1}='pNN50:';
nn50detect=find(diff(vhr)>0.05);
switch isempty(nn50detect)
    case 1
        set(handles.pnn50,'string','pNN50:0')
        ecgexportmx{6,2}=0;
    case 0
        set(handles.pnn50,'string',strcat('pNN50:',num2str(length(nn50detect)/length(vhr))))
        ecgexportmx{6,2}=length(nn50detect)/length(vhr);
end
set(handles.showdc,'enable','on','value',1)
set([handles.figurevhr handles.figurevhrspec handles.ecgexport],'enable','on')
% --- Executes on button press in editr.
function editr_Callback(hObject, eventdata, handles)
% hObject    handle to editr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global hdata

switch get(hObject,'value')
    case 1
        hdata=datacursormode;
        datacursormode on
        set([handles.addr handles.remove],'enable','on')
        set([handles.slide handles.zoombutton],'value',0)
    case 0
        set([handles.addr handles.remove],'enable','off','value',0)
        datacursormode off
end

% Hint: get(hObject,'Value') returns toggle state of editr


% --- Executes on button press in remove.
function remove_Callback(hObject, eventdata, handles)
global hdata r_matrix yaxis_r hvhr hvhrspec hpeack
% hObject    handle to remove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
datainfo=getCursorInfo(hdata);
switch isempty(datainfo)
    case 0
        spotposition=datainfo.Position;
        ytemp=yaxis_r-spotposition(1);
        [minimum minindex]=min(abs(ytemp));
        yaxis_r(minindex)=[];
        r_matrix(minindex)=[];
        delete(hpeack)
        delete(hvhr)
        delete(hvhrspec)
        vhrfcn(yaxis_r,r_matrix,handles)
    case 1
        msgbox('Make sure there is one point selected');
        beep;
end
% Hint: get(hObject,'Value') returns toggle state of remove

% --- Executes on button press in addr.
function addr_Callback(hObject, eventdata, handles)
global hdata r_matrix yaxis_r hvhr hvhrspec hpeack
% hObject    handle to addr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
datainfo=getCursorInfo(hdata);
switch isempty(datainfo)
    case 0
        spotposition=datainfo.Position;
        yaxis_r(length(yaxis_r)+1)=spotposition(1);
        yaxis_r=sort(yaxis_r);
        index=find(yaxis_r==spotposition(1));
        if index>1
           temp=r_matrix(1:index-1);
           temp(index)=spotposition(2);
           temp(index+1:length(r_matrix)+1)=r_matrix(index:length(r_matrix));
        else
           temp=[spotposition(2) r_matrix];
        end
        r_matrix=temp;
        delete(hpeack)
        delete(hvhr)
        delete(hvhrspec)
        vhrfcn(yaxis_r,r_matrix,handles)
    case 1
        msgbox('Make sure there is one point selected');
        beep;
end


% --- Executes on button press in zoombutton.
function zoombutton_Callback(hObject, eventdata, handles)
% hObject    handle to zoombutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(hObject,'value')
    case 1
        zoom on
        set([handles.slide handles.editr],'value',0)
        set([handles.addr handles.remove],'value',0,'enable','off')
    case 0
        zoom off
end
% --- Executes on button press in slide.
function slide_Callback(hObject, eventdata, handles)
% hObject    handle to slide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of slide
switch get(hObject,'value')
    case 1
        pan xon
        set([handles.zoombutton handles.editr],'value',0)
        set([handles.addr handles.remove],'value',0,'enable','off')
    case 0
        pan off
end
% --------------------------------------------------------------------
function ecgrestart_Callback(hObject, eventdata, handles)
% hObject    handle to ecgrestart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global hvhr hvhrspec hpeack ecgplot
restartans=questdlg('Are you sure you want to restart the module?','Attention','No');
switch restartans
    case 'Yes'
        delete(hvhr)
        delete(hvhrspec)
        delete(hpeack)
        delete(ecgplot)
        set(handles.ecgaxes,'xlim',[0 1],'ylim',[0 1])
        set(handles.vhraxes,'xlim',[0 1],'ylim',[0 1])
        set(handles.vhrspecaxes,'xlim',[0 1],'ylim',[0 1])
        set([handles.process handles.ecgrestart],'enable','off')
        set([handles.editr handles.addr handles.remove handles.zoombutton handles.slide],'value',0,'enable','off')
        zoom off
        datacursormode off
        pan off
        set(handles.beats,'string','Beats:')
        set(handles.sdnn,'string','SDNN:')
        set(handles.rms,'string','RMSSD:')
        set(handles.lfhf,'string','LF/HF:')
        set(handles.pnn50,'string','pNN50:')
        set(handles.ecgname,'string','Signal:')
        set(handles.ecgduration,'string','Duration:')
        set(handles.ecgfs,'string','Fs:')
        set(handles.ecgopen,'enable','on')
        set(handles.showdc,'enable','off','value',0)
        set([handles.figurevhr handles.figurevhrspec],'enable','off')
        clear global yaxis_r r_matrix vhr vhrspectrum t hvhr hvhrspec hpeack ecgplot vhrspectrum ecgexportmx
    case 'No'
        return
end


% --- Executes on button press in showdc.
function showdc_Callback(hObject, eventdata, handles)
global vhrspectrum faxis
% hObject    handle to showdc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(handles.showdc,'value')
    case 1
        set(handles.vhrspecaxes,'xlim',[0 0.5],'ylim',[0 max(vhrspectrum)])
    case 0
        set(handles.vhrspecaxes,'xlim',[faxis(2) 0.5],'ylim',[0 max(vhrspectrum(2:length(vhrspectrum)))])
end
% Hint: get(hObject,'Value') returns toggle state of showdc


% --------------------------------------------------------------------
function ecgexport_Callback(hObject, eventdata, handles)
global ecgexportmx
[xlsfile xlspath]=uiputfile('*.xls','Save File');
xlswrite(strcat(xlspath,xlsfile),ecgexportmx)
% hObject    handle to ecgexportmx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in invert.
function invert_Callback(hObject, eventdata, handles)
% hObject    handle to invert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of invert
global ecgplot
ecgdata=get(ecgplot,'ydata');
set(ecgplot(),'ydata',-ecgdata);
axis tight


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
