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
v5fft=fft(v5editdata(v5editpoints(1):v5editpoints(2)));
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

% <a href="dwtmodule -> calcular -> f7calcular_fcn"> <code>
switch isempty(h7axapdet)
case 0
	delete(h7axapdet);
    clear v7plotapdet;
    h7axapdet=[];
    set(h7axesini,'position',[0.056,0.165,0.755,0.76]);
    set(h7selsignal,'value',1,'string','Nenhum');
    set([h7pfinalvalue h7pinicialvalue],'string','1');
    v7editmx=[];
    h7cdataedit=[];
    set([h7editsignaltxt h7selsignal h7edittodo h7editintervalo h7pinicialtxt h7pinicialvalue h7pfinaltxt],'enable','off');
    set([h7pfinalvalue h7v1txt h7v1value h7editar h7desfazer h7limitar h7limitarhist h7substituir],'enable','off');
    set(h7salvarsignal,'value',1,'string','N/A');
    set([h7salvar h7salvarfig h7salvartxt h7salvarsignal],'enable','off');
end
switch isempty(v7plotrec)
case 0
    delete(v7plotrec);
    v7plotrec=[];
    set([h7saverecfig h7saverec],'enable','off');
end
v7sigselect=[]
v7level=get(h7level,'value');
v7apxname={};
v7detname={};
for i=1:v7level
    v7apxname{i,1}=strcat('cA',num2str(i));
    v7apxname{i,2}=strcat('A',num2str(i));
    v7apxname{i,3}=1;
    v7apxname{i,4}=i;
    v7detname{i,1}=strcat('cD',num2str(i));
    v7detname{i,2}=strcat('D',num2str(i));
    v7detname{i,3}=0;
    v7detname{i,4}=i;
end
set(h7veropt,'value',1)
set(h7listaprox,'string',v7apxname(:,1));
set(h7listdetalhes,'string',v7detname(:,1));
set(h7listatotal,'value',1,'string','Nenhum');
[v7c v7l]=wavedec(v7signal,v7level,v7wname);
set(h7zoombutton,'enable','off','value',0);
set(h7zoom,'enable','off');
set([h7addaprox h7listatotaltxt h7listdetalhes h7addetalhe h7listatotal h7remover h7visualizar],'enable','on');
set([h7veropt h7veraproxradio h7verdetalradio h7verdefradio h7aproxtxt h7listaprox h7detatxt],'enable','on');
eval(f7radioverdef_fcn);
% </code> </a>

% <a href="addsignal from fourier"> <code>
if v1numsig>7;
    msgbox('O numero maximo de sinais simultaneos e 7. Para inserir outro oculte um dos sinais atuais.','Numero maximo de sinais apresentados','warn');
    return;
end;
[v1signalext,v1filepath]=uigetfile('*.ascii','Escolha o arquivo de registro');
switch ischar(v1signalext);
    case 0;
        return;
end;
v1file=strcat(v1filepath,v1signalext);
eval('load(v1file)',f1errorsignal_fcn);
if v1errorfile==1;
    v1errorfile=0;
    return;
end;
h7msnimport=msgbox('...importando sinal...','Espere','warn');
figure(h1fourier);
v1signalname{v1numsig}=v1signalext(1:length(v1signalext)-6);
v1presignal=eval(v1signalname{v1numsig});
v1signal=((v1presignal+fa)*fb)-fc;
v1maxsignal(v1numsig)=max(v1signal);
v1minsignal(v1numsig)=min(v1signal);
v1lengthsignal(v1numsig)=length(v1signal);
v1faxis=0:fs/(length(v1signal)-1):fs;
v1t{v1numsig}=0:1/fs:(length(v1signal)-1)/fs;
v1tregind(v1numsig)=round(max(v1t{v1numsig}));
v1tregmin=min(v1tregind);
v1treg=round(max(v1tregind));
v1tregstr=sprintf('%6.2f',v1treg);
v1tfinalok=str2num(v1tregstr);
v1tempotext=strcat('Tempo de registro [s]: ',v1tregstr);
set(h1tempolabel,'enable','on','string',v1tempotext);
for i=1:7;
    if v1colorname{i,2}==0;
        v1colorstr=v1colorname{i,1};
        v1colorname{i,2}=1;
        v1colorplot=v1colorname{i,3};
        v1colormatindex(v1numsig)=i;
        break;
    end;
end;
if v1tempind==1;
    set([h1fftmenuvertsin h1tinicialvalue h1tfinalvalue h1tinicialtext h1tfinaltext],'enable','on');
    v1signmtxt=v1signalname{v1numsig};
    axes(h1axestempo);
    hold on;
    v1pt(v1numsig)=plot(v1t{v1numsig},v1signal,v1colorplot);
    grid on;
    axis tight;
end;
set(h1tfinalvalue,'string',v1tregstr);
v1jandata=eval(strcat(v1janela,'(',num2str(length(v1signal)),');'));
v1signal=v1signal.*v1jandata;
v1frecsignal=fft(v1signal)./length(v1signal);
v1maxspec(v1numsig)=max(abs(v1frecsignal));
v1faxis=0:fs/(length(v1signal)-1):fs;
axes(h1axesfourier);
hold on;
v1p(v1numsig)=plot(v1faxis,abs(v1frecsignal),v1colorplot);
grid on;
axis tight;
set(h1axesfourier,'xlim',[str2num(get(h1fminvalue,'string')) str2num(get(h1fmaxvalue,'string'))]);
v1newfftind=0;
v1tempind=strcmp(get(h1fftmenuvertsin,checked'),'on');
v1sigtxt=strcat(v1signalname{v1numsig},'','(',v1colorstr,')');
v1signalploted{v1numsig}=v1sigtxt;
v1saveplot=v1signalploted;
v1saveplot{v1numsig+1}='Todos';
v1numsig=v1numsig+1;
set(h1listsignal,'string',v1signalploted,'value',v1numsig-1);
set(h1savesig,'string',v1saveplot);
set(h1popfrec,'enable','on','value',1);
set([h1fmintext h1fmaxtext h1fminvalue h1fmaxvalue h1fftmenujanela],'enable','off');
set(h1fminvalue,'string','0');
set(h1fmaxvalue,'string',num2str(fs/2));
delete(h7msnimport);
set([h1calcpot h1zoombutton h1fftmenuvertsin h1limpar h1apagar h1fftmenuver],'enable','on');
eval(f1potencia_fcn);
set([h1savesig h1expdados h1expfig h1pototal],'enable','on');
% </code> </a>

% <a href="COLORMATRIX"> <code>
v1colorname{1,1}='Azul'; v1colorname{1,2}=0; v1colorname{1,3}='b';
v1colorname{2,1}='Vermelho'; v1colorname{2,2}=0; v1colorname{2,3}='r';
v1colorname{3,1}='Verde'; v1colorname{3,2}=0; v1colorname{3,3}='g';
v1colorname{4,1}='Preto'; v1colorname{4,2}=0; v1colorname{4,3}='k';
v1colorname{5,1}='Amarelo'; v1colorname{5,2}=0; v1colorname{5,3}='y';
v1colorname{6,1}='Ciam'; v1colorname{6,2}=0; v1colorname{6,3}='c';
v1colorname{7,1}='Magenta'; v1colorname{7,2}=0; v1colorname{7,3}='m';
% </code> </a>
