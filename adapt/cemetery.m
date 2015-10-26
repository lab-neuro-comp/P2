% <a href="TRANSLATION OF f5novoreg">
% <code>
global fa fb fc fs

if handles.v5numsig>7;
    msgbox('O numero maximo de sinais simultaneos e 7. Para inserir outro oculte um dos sinais atuais.', 'Numero maximo de sinais apresentados','warn');
    return;
end;
[handles.v5signalname,handles.v5signalpath]=uigetfile('*.ascii','Escolha o arquivo do registro');
switch ischar(handles.v5signalname);
    case 0;
        return;
end;
handles.v5filename=strcat(handles.v5signalpath,handles.v5signalname);
eval('load(handles.v5filename)', f5errorsignal_fcn);
if handles.v5errorfile==1;
    handles.v5errorfile=0;
    return;
end;
h5msnimport=msgbox('...importando sinal...','Espere','warn');
handles.v5signalname=handles.v5signalname(1:length(handles.v5signalname)-6);
handles.v5presignal=eval(handles.v5signalname);
handles.v5signal=((handles.v5presignal+fa)*fb)-fc;
handles.v5t=0:1/fs:(length(handles.v5signal)-1)/fs;
handles.v5treg=sprintf(' %5.2f',max(handles.v5t));
handles.v5altplot=handles.v5hini/handles.v5numsig;
set(h5axes,'visible','off');
if handles.v5numsig>1;
    if str2num(handles.v5treg)~=handles.v5tfinalok;
        beep;
        msgbox('Todos os registros devem ser do mesmo tamanho','Registro invalido','warn');
        delete(h5msnimport);
        return;
    end;
    for i=handles.v5numsig:-1:2;
        set(h5axesedit(i-1),'position',[0.05,0.18+(handles.v5numsig-i+1)*handles.v5altplot,0.765,(handles.v5altplot-0.02)]);
        axes(h5axesedit(i-1));
        axis tight;
    end;
    set([h5addref h5promediar],'enable','on');
end;
handles.v5tfinalok=str2num(handles.v5treg);
figure(h5editfig);
h5axesedit(handles.v5numsig)=axes('position',[0.05,0.18,0.765,(handles.v5altplot-0.02)],'fontsize',8,'fontname','arial');
for i=1:7;
    if handles.v5color{i,2}==0;
        handles.v5color{i,2}=1;
        handles.v5colorname=handles.v5color{i,1};
        handles.v5colorcode=handles.v5color{i,3};
        handles.v5colorposition(handles.v5numsig)=i;
        break;
    end;
end;
axes(h5axesedit(handles.v5numsig));
if handles.v5numsig>1;
    linkaxes(h5axesedit,'x');
end;
handles.v5plot(handles.v5numsig)=plot(handles.v5t,handles.v5signal,handles.v5colorcode);
handles.v5listsignal{handles.v5numsig}=strcat(handles.v5signalname,'(',handles.v5colorname,')');
handles.v5editmx{handles.v5numsig}=handles.v5listsignal{handles.v5numsig};
handles.v5listsignal{handles.v5numsig+1}='Todos';
set(h5signals,'string',handles.v5listsignal);
set(h5exportar,'string',handles.v5editmx);
ylabel('Amplitude [uV]','fontsize',8,'fontname','arial');
axis tight;
grid on;
set(h5fslabel,'string',strcat('Fs [Hz]:',num2str(fs)));
set(h5temporegistro,'string',strcat('Tempo de registro [s]:',handles.v5treg));
handles.v5interval=get(h5axesedit(handles.v5numsig),'xlim');
set(h5intervaloatual,'string',strcat('Intervalo atual [s]:',strcat(sprintf(' %5.2f',handles.v5interval(1)),':',sprintf('%5.2f',handles.v5interval(2)))));
set([h5reset h5fslabel h5temporegistro h5intaptxt h5substituiropt h5filtraropt h5intervaloatual h5zoombutton],'enable','on');
set([h5remover h5signals h5expbutton h5exportar],'enable','on');
set(h5tfinaledit,'string',handles.v5treg);
handles.v5numsig=handles.v5numsig+1;
delete(h5msnimport);

% </code> </a>

% <a href="filtering"> <code>
v5tamint=v5editpoints(2)-v5editpoints(1);
%...
v5feditmaxvalue=str2num(get(h5fmaxedit,'string'));
v5feditminvalue=str2num(get(h5fminedit,'string'));
% ...
v5fmaxok=v5feditmaxvalue;
v5fminok=v5feditminvalue;
v5fmaxpoint=round(v5feditmaxvalue*v5tamint/fs);
v5fmaxpoint2=length(v5fft)-v5fmaxpoint;
v5fminpoint=round(v5feditminvalue*v5tamint/fs);
v5fminpoint2=length(v5fft)-v5fminpoint;
switch v5tipofiltro;
case 1;
    v5fft(v5fmaxpoint:v5fmaxpoint2)=0;
case 2;
    v5fft(1:v5fminpoint)=0;
    v5fft(v5fminpoint2:length(v5fft))=0;
case 3;
    v5fft(1:v5fminpoint)=0;
    v5fft(v5fminpoint2:length(v5fft))=0;
    v5fft(v5fmaxpoint:v5fmaxpoint2)=0;
case 4;
    v5fft(v5fminpoint:v5fmaxpoint)=0;
    v5fft(v5fmaxpoint2:v5fminpoint2)=0;
end;
v5editdata(v5editpoints(1):v5editpoints(2))=real(ifft(v5fft));
% </code> </a>