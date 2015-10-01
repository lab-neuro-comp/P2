%%%% CWT %%%%%

cwt_enable=1;

v6wname='haar';
v6rit=0;
v6escintok=1;
v6escminok=2;
v6escmaxok=centfrq(v6wname)/((1/fs)*deltaf1);
v6pseudofreqok='127.50';
v6escalaok='1';
v6errorfile=0;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAINEL FRONTAL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h6cwt=figure('units','normalized',...
    'position',[0.0038,0.0495,0.993,0.89],...
    'menubar','none',...
    'numbertitle','off',...
    'name','M�dulo CWT',...
    'color','white',...
    'deletefcn','clear h6* f6* v6*;cwt_enable=0;');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%AXES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h6axescwt=axes('units','normalized',...
    'position',[0.056,0.09,0.74,0.59],...
    'fontsize',9,...
    'box','on');
grid on;
ylabel('Escala','fontsize',9,'fontname','arial');
xlabel('Tempo [s]','fontsize',9,'fontname','arial');

h6axessignal=axes('units','normalized',...
    'position',[0.056,0.73,0.74,0.24],...
    'fontsize',9,...
    'box','on');
grid on;
ylabel('Amplitude [uV]','fontsize',9,'fontname','arial');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INFO%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h6frame1=uicontrol('style','frame',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.815,0.84,0.175,0.13]);  

h6infolabel=uicontrol('style','text',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.82,0.935,0.15,0.023],...
    'fontname','arial',...
    'fontsize',10,...
    'HorizontalAlignment','left',...
    'FontWeight','bold',...
    'string','PAR�METROS BASE');   

h6sinaltxt=uicontrol('style','text',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.82,0.895,0.16,0.02],...
    'fontname','arial',...
    'fontsize',9,...
    'HorizontalAlignment','left',...
    'string','Sinal:');

h6fstext=uicontrol('style','text',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.82,0.865,0.167,0.02],...
    'fontname','arial',...
    'fontsize',9,...
    'HorizontalAlignment','left',...
    'string',strcat('Freq��ncia de amostragem [Hz]:',num2str(fs)));

h6frqinttext=uicontrol('style','text',...
    'backgroundcolor','white',...
    'units','normalized',...
    'position',[0.31,0.01,0.25,0.022],...
    'fontname','arial',...
    'fontsize',10,...
    'HorizontalAlignment','left',...
    'string',strcat('Intervalo de pseudo-freq��ncias [Hz]:[',num2str(deltaf1),':',num2str(fs/2),']'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%WAVECALC%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h6frame4=uicontrol('style','frame',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.815,0.4,0.175,0.433]);

f6calcular_fcn=['h6msn=msgbox(''...calculando transformada...'',''Espere'',''warn'');'...
    'axes(h6axescwt);'...
    'clear v6cwt;'...
    'v6cwt=cwt(v6signal,v6escminok:v6escintok:v6escmaxok,v6wname,''plot'');',...
    'v6verescok=[v6escminok v6escmaxok];'...
    'set([h6verescalavalue h6convescalavalue],''string'',sprintf(''%5.2f'',v6verescok(1)));'...
    'eval(f6convesfr_fcn);'...
    'xlabel(strcat(''Tempo [s]'','' ['',''0:'',v6tregstr,'']''));',...
    'ylabel(''Escala'');'...
    'title('''');'...
    'set([h6colorbar h6vercolormap h6verescalaradio h6vertemporadio h6verescalavalue h6verescala h6limpar h6zoombutton],''enable'',''on'');'...
    'set(h6vertempovalue,''string'',''1'',''enable'',''off'');'...
    'set(h6verescalaradio,''value'',1);'...
    'set(h6vertemporadio,''value'',0);'...
    'colormap(h6axescwt,''hot'');',...
    'set(h6axessignal,''xlim'',[0 v6treg]);'...
    'close(h6msn);'];

h6calcular=uicontrol('style','pushbutton',...
    'units','normalized',...
    'enable','off',...
    'fontname','arial',...
    'fontsize',9,...
    'string','Calcular',...
    'Interruptible','off',...
    'position',[0.856,0.415,0.1,0.05],...
    'callback',f6calcular_fcn);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%WAVEOPT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


h6frame2=uicontrol('style','frame',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.825,0.735,0.155,0.08]);

h6wavelabel=uicontrol('style','text',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.83,0.78,0.12,0.023],...
    'fontname','arial',...
    'fontsize',10,...
    'HorizontalAlignment','left',...
    'FontWeight','bold',...
    'string','TIPO DE WAVELET');   

f6tipowave_fcn=['switch get(h6tipowave,''value'');'...
        'case 1;'...
            'set(h6paramwave,''visible'',''off'',''value'',1);'...
            'v6wname=''haar'';'...
        'case 2;'...
            'set(h6paramwave,''visible'',''on'',''value'',1,''string'',v6dboptions);'...
            'v6wname=''db1'';'...
        'case 3;'...
            'set(h6paramwave,''visible'',''on'',''value'',1,''string'',v6symoptions);'...
            'v6wname=''sym2'';'...
        'case 4;'...
            'set(h6paramwave,''visible'',''on'',''value'',1,''string'',v6coifoptions);'...
            'v6wname=''coif1'';'...
        'case 5;'...
            'set(h6paramwave,''visible'',''on'',''value'',1,''string'',v6bioroptions);'...
            'v6wname=''bior1.1'';'...
        'case 6;'...
            'set(h6paramwave,''visible'',''on'',''value'',1,''string'',v6rbiooptions);'...
            'v6wname=''rbio1.1'';'...
        'case 7;'...
            'v6wname=''meyr'';'...
        'case 8;'...
            'set(h6paramwave,''visible'',''on'',''value'',1,''string'',v6gausoptions);'...
            'v6wname=''gaus1'';'...
        'case 9;'...
            'set(h6paramwave,''visible'',''off'',''value'',1);'...
            'v6wname=''mexh'';'...
        'case 10;'...
            'set(h6paramwave,''visible'',''off'',''value'',1);'...
            'v6wname=''morl'';'...
    'end;'...
    'set(h6sinaltxt,''string'',strcat(''Sinal:'',v6wname));'...
    'set([h6convescalavalue h6verescalavalue],''string'',''1'');'...
    'eval(f6convesfr_fcn);'...
    'switch get(h6escalapredef,''value'');'...
        'case 1;'...
            'eval(f6newescala_fcn);'...
     'end;'...
     'v6escmaxok=centfrq(v6wname)/((1/fs)*deltaf1);'...
     'v6escminok=centfrq(v6wname)/0.5;'...
     'set(h6escalamin,''string'',num2str(v6escminok));'...
     'set(h6escalamax,''string'',num2str(v6escmaxok));'];

v6waveoptions={'Haar','Daubechies','Symlets','Coiflets','Biorthogonal','R_Biorthogonal','Meyer','Gaussian','Mexican','Morlet'};
v6dboptions={'db1','db2','db3','db4','db5','db6','db7','db8','db9','db10'};
v6bioroptions={'1.1','1.3','1.5','2.2','2.4','2.6','2.8','3.1','3.3','3.5','3.7','3.9','4.4','5.5','6.8'};
v6rbiooptions=v6bioroptions;
v6symoptions={'2','3','4','5','6','7','8'};
v6coifoptions={'1','2','3','4','5'};
v6gausoptions={'1','2','3','4','5','6','7','8'};

h6tipowave=uicontrol('style','popup',...
    'backgroundcolor','white',...
    'fontname','arial',...
    'enable','off',...
    'fontsize',9,...
    'units','normalized',...
    'position',[0.83,0.705,0.105,0.07],...
    'string',v6waveoptions,...
    'callback',f6tipowave_fcn);

f6param_fcn=['v6param=get(h6paramwave,''value'');'...
    'switch get(h6tipowave,''value'');'...
        'case 2;'...
            'v6wname=strcat(''db'',num2str(v6param));'...
        'case 3;'...
            'v6wname=strcat(''sym'',num2str(v6param+1));'...
        'case 4;'...
            'v6wname=strcat(''coif'',num2str(v6param));'...
        'case 5;'...
            'v6wname=strcat(''bior'',v6bioroptions{v6param});'...
        'case 6;'...
            'v6wname=strcat(''rbio'',v6bioroptions{v6param});'...
        'case 8;'...
            'v6wname=strcat(''gaus'',num2str(v6param));'...
    'end;'...
    'set(h6sinaltxt,''string'',strcat(''Sinal:'',v6wname));'...
    'set([h6convescalavalue h6verescalavalue],''string'',''1'');'...
    'eval(f6convesfr_fcn);'...
    'switch get(h6escalapredef,''value'');'...
        'case 1;'...
            'eval(f6newescala_fcn);'...
     'end;'...
     'v6escmaxok=centfrq(v6wname)/((1/fs)*deltaf1);'...
     'v6escminok=centfrq(v6wname)/0.5;'...
     'set(h6escalamin,''string'',num2str(v6escminok));'...
     'set(h6escalamax,''string'',num2str(v6escmaxok));'];

h6paramwave=uicontrol('style','popup',...
    'backgroundcolor','white',...
    'fontname','arial',...
    'visible','off',...
    'fontsize',9,...
    'units','normalized',...
    'position',[0.938,0.705,0.038,0.07],...
    'string',v6dboptions,...
    'callback',f6param_fcn);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ESCALAS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h6frame3=uicontrol('style','frame',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.825,0.48,0.155,0.247]);

h6escalalabel=uicontrol('style','text',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.83,0.69,0.05,0.023],...
    'fontname','arial',...
    'fontsize',10,...
    'HorizontalAlignment','left',...
    'FontWeight','bold',...
    'string','ESCALA');   

f6definirescala_fcn=['set([h6escalapredef h6escaladelta h6escalatetha h6escalalpha h6escalabetha h6escalagamma],''value'',0);'...
    'set([h6escaladelta h6escalatetha h6escalalpha h6escalabetha h6escalagamma],''enable'',''off'');'...
    'set([h6escalamintxt h6escalamin h6escalamaxtxt h6escalamax],''enable'',''on'')';];

h6definirescala=uicontrol('style','radio',...
    'fontname','arial',...
    'enable','off',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'fontsize',9,...
    'units','normalized',...
    'value',1,...
    'position',[0.83,0.65,0.05,0.03],...
    'string','Manual',...
    'callback',f6definirescala_fcn);

f6checkescala_fcn=['v6escmin=str2num(get(h6escalamin,''string''));'...
    'v6escint=str2num(get(h6escalaint,''string''));'...
    'v6escmax=str2num(get(h6escalamax,''string''));'...
    'if v6escminok-v6escmin>0.001;'...
        'msgbox(''A escala m�nima correspode a uma pseudo-frquencia maior que fs/2'',''Erro de defini��o'',''warn'');'...
        'set(h6escalamin,''string'',sprintf(''%5.2f'',v6escminok));'...
        'set(h6escalamax,''string'',sprintf(''%5.2f'',v6escmaxok));'...
        'set(h6escalamin,''string'',sprintf(''%5.2f'',v6escminok));'...
        'return;'...
    'end;'...
    'if v6escmin<0 | v6escmin>v6escmax;'...
        'beep;'...
        'msgbox(''A escala m�nima deve ser positiva e menor que a escala maxima'',''Erro de defini��o'',''warn'');'...
        'set(h6escalamin,''string'',sprintf(''%5.2f'',v6escminok));'...
        'set(h6escalamax,''string'',sprintf(''%5.2f'',v6escmaxok));'...
        'set(h6escalamin,''string'',sprintf(''%5.2f'',v6escminok));'...
        'return;'...
    'end;'...
    'if v6escint>v6escmax-v6escmin | v6escint<0;'...
        'beep;'...
        'msgbox(''O intervalo deve ser positiva e menor que a diferenca entre a escala minia e maxima'',''Erro de defini��o'',''warn'');'...
        'set(h6escalamin,''string'',sprintf(''%5.2f'',v6escminok));'...
        'return;'...
    'end;'...
    'v6escminok=v6escmin;'...
    'v6escintok=v6escint;'...
    'v6escmaxok=v6escmax;'...
    'v6freqmaxtxt=sprintf(''%5.2f'',centfrq(v6wname)/((1/fs)*v6escmin));'...
    'v6freqmintxt=sprintf(''%5.2f'',centfrq(v6wname)/((1/fs)*v6escmax));'...
    'set(h6frqinttext,''string'',strcat(''Intervalo de pseudo-freq��ncias [Hz]:'',''['',v6freqmintxt,'':'',v6freqmaxtxt,'']''));'];

h6escalamintxt=uicontrol('style','text',...
    'enable','off',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'fontname','arial',...
    'fontsize',9,...
    'HorizontalAlignment','left',...
    'units','normalized',...
    'position',[0.833,0.605,0.033,0.02],...
    'string','Minima');

h6escalamin=uicontrol('style','edit',...
    'enable','off',...
    'backgroundcolor','white',...
    'fontname','arial',...
    'fontsize',9,...
    'units','normalized',...
    'position',[0.87,0.6,0.04,0.03],...
    'string',sprintf('%5.2f',v6escminok),...
    'callback',f6checkescala_fcn);

h6escalainttxt=uicontrol('style','text',...
    'enable','off',...
    'fontname','arial',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'fontsize',9,...
    'HorizontalAlignment','left',...
    'units','normalized',...
    'position',[0.833,0.56,0.033,0.02],...
    'string','Int.');

h6escalaint=uicontrol('style','edit',...
    'enable','off',...
    'backgroundcolor','white',...
    'fontname','arial',...
    'fontsize',9,...
    'units','normalized',...
    'position',[0.87,0.555,0.04,0.03],...
    'string','1',...
    'callback',f6checkescala_fcn);

h6escalamaxtxt=uicontrol('style','text',...
    'enable','off',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'fontname','arial',...
    'fontsize',9,...
    'HorizontalAlignment','left',...
    'units','normalized',...
    'position',[0.833,0.515,0.033,0.02],...
    'string','Maxima');

h6escalamax=uicontrol('style','edit',...
    'enable','off',...
    'backgroundcolor','white',...
    'fontname','arial',...
    'fontsize',9,...
    'units','normalized',...
    'position',[0.87,0.51,0.04,0.03],...
    'string',sprintf('%5.2f',v6escmaxok),...
    'callback',f6checkescala_fcn);

f6escalapredef_fcn=['set(h6definirescala,''value'',0);'...
    'set([h6escaladelta h6escalatetha h6escalalpha h6escalabetha h6escalagamma],''value'',0,''enable'',''on'');'...
    'set(h6escaladelta,''value'',1);'...
    'set([h6escalamintxt h6escalamin h6escalamaxtxt h6escalamax],''enable'',''off'');'...
    'v6rf1=deltaf1;'...
    'v6rf2=deltaf2;'...
    'eval(f6newescala_fcn);'];

f6newescala_fcn=['v6escmaxok=centfrq(v6wname)/((1/fs)*v6rf1);'...
    'v6escminok=centfrq(v6wname)/((1/fs)*v6rf2);'...
    'set(h6escalamin,''string'',sprintf(''%5.2f'',v6escminok));'...
    'set(h6escalamax,''string'',sprintf(''%5.2f'',v6escmaxok));'];

h6escalapredef=uicontrol('style','radio',...
    'enable','off',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'fontname','arial',...
    'fontsize',9,...
    'units','normalized',...
    'position',[0.91,0.65,0.069,0.03],...
    'string','Por Ritmos',...
    'callback',f6escalapredef_fcn);

f6ritmo_fcn=['switch v6rit;'...
        'case 1;'...
            'set([h6escalatetha h6escalalpha h6escalabetha h6escalagamma],''value'',0);'...
        'case 2;'...
            'set([h6escaladelta  h6escalalpha h6escalabetha h6escalagamma],''value'',0);'...
        'case 3;'...
            'set([h6escaladelta h6escalatetha  h6escalabetha h6escalagamma],''value'',0);'...
        'case 4;'...
            'set([h6escaladelta h6escalatetha h6escalalpha  h6escalagamma],''value'',0);'...
        'case 5;'...
            'set([h6escaladelta h6escalatetha h6escalalpha h6escalabetha],''value'',0);'...
    'end;'];

f6escalad_fcn=['v6rit=1;'...
    'eval(f6ritmo_fcn);'...
    'v6rf1=deltaf1;'...
    'v6rf2=deltaf2;'...
    'eval(f6newescala_fcn);'...
    'set(h6verescala,''enable'',''off'');'...
    'set(h6frqinttext,''string'',strcat(''Intervalo de pseudo-freq��ncias [Hz]:'',''['',num2str(deltaf1),'':'',num2str(deltaf2),'']''));'];

h6escaladelta=uicontrol('style','radio',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'fontname','arial',...
    'enable','off',...
    'fontsize',9,...
    'units','normalized',...
    'position',[0.92,0.61,0.05,0.03],...
    'string','Delta',...
    'callback',f6escalad_fcn);

f6escalat_fcn=['v6rit=2;'...
    'eval(f6ritmo_fcn);'...
    'v6rf1=thetaf1;'...
    'v6rf2=thetaf2;'...
    'eval(f6newescala_fcn);'...
    'set(h6verescala,''enable'',''off'');'...
    'set(h6frqinttext,''string'',strcat(''Intervalo de pseudo-freq��ncias [Hz]:'',''['',num2str(thetaf1),'':'',num2str(thetaf2),'']''));'];

h6escalatetha=uicontrol('style','radio',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'fontname','arial',...
    'enable','off',...
    'fontsize',9,...
    'units','normalized',...
    'position',[0.92,0.58,0.05,0.03],...
    'string','Tetha',...
    'callback',f6escalat_fcn);

f6escalaa_fcn=['v6rit=3;'...
    'eval(f6ritmo_fcn);'...
    'v6rf1=alphaf1;'...
    'v6rf2=alphaf2;'...
    'eval(f6newescala_fcn);'...
    'set(h6verescala,''enable'',''off'');'...
    'set(h6frqinttext,''string'',strcat(''Intervalo de pseudo-freq��ncias [Hz]:'',''['',num2str(alphaf1),'':'',num2str(alphaf2),'']''));'];

h6escalalpha=uicontrol('style','radio',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'fontname','arial',...
    'fontsize',9,...
    'enable','off',...
    'units','normalized',...
    'position',[0.92,0.55,0.05,0.03],...
    'string','Alpha',...
    'callback',f6escalaa_fcn);

f6escalab_fcn=['v6rit=4;'...
    'eval(f6ritmo_fcn);'...
    'v6rf1=bethaf1;'...
    'v6rf2=bethaf2;'...
    'eval(f6newescala_fcn);'...
    'set(h6verescala,''enable'',''off'');'...
    'set(h6frqinttext,''string'',strcat(''Intervalo de pseudo-freq��ncias [Hz]:'',''['',num2str(bethaf1),'':'',num2str(bethaf2),'']''));'];

h6escalabetha=uicontrol('style','radio',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'fontname','arial',...
    'fontsize',9,...
    'enable','off',...
    'units','normalized',...
    'position',[0.92,0.52,0.05,0.03],...
    'string','Betha',...
    'callback',f6escalab_fcn);

f6escalag_fcn=['v6rit=5;'...
    'eval(f6ritmo_fcn);'...
    'v6rf1=gammaf1;'...
    'v6rf2=gammaf2;'...
    'eval(f6newescala_fcn);'...
    'set(h6verescala,''enable'',''off'');'...
    'set(h6frqinttext,''string'',strcat(''Intervalo de pseudo-freq��ncias [Hz]:'',''['',num2str(gammaf1),'':'',num2str(gammaf2),'']''));'];

h6escalagamma=uicontrol('style','radio',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'fontname','arial',...
    'fontsize',9,...
    'enable','off',...
    'units','normalized',...
    'position',[0.92,0.49,0.05,0.03],...
    'string','Gamma',...
    'callback',f6escalag_fcn);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CONVERSOR%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h6frame5=uicontrol('style','frame',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.815,0.31,0.175,0.083]);

h6conversorlabel=uicontrol('style','text',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.82,0.36,0.08,0.023],...
    'fontname','arial',...
    'fontsize',10,...
    'HorizontalAlignment','left',...
    'FontWeight','bold',...
    'string','CONVERSOR');   

f6convfrqes_fcn=['v6pseudofreq=str2num(get(h6pseudofreqvalue,''string''));'...
    'if v6pseudofreq<0;'...
        'beep;'...
        'msgbox(''A frequecia deve ser positiva'',''Erro de defini��o'',''warn'');'...
        'set(h6pseudofreqvalue,''string'',v6pseudofreqok);'...
        'return;'...
    'end;'...
    'v6esc=centfrq(v6wname)/((1/fs)*v6pseudofreq);'...
    'v6pseudofreqok=sprintf(''%5.2f'',v6pseudofreq);'...
    'set(h6convescalavalue,''string'',sprintf(''%5.2f'',v6esc));'];

h6pseudofreqvalue=uicontrol('style','edit',...
    'backgroundcolor','white',...
    'enable','off',...
    'fontname','arial',...
    'fontsize',9,...
    'units','normalized',...
    'position',[0.945,0.32,0.04,0.03],...
    'string','127.50',...
    'callback',f6convfrqes_fcn);

h6pseudofreq=uicontrol('style','text',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'fontname','arial',...
    'fontsize',9,...
    'enable','off',...
    'HorizontalAlignment','left',...
    'units','normalized',...
    'position',[0.905,0.325,0.04,0.02],...
    'string','Ps_freq');

f6convesfr_fcn=['v6escala=str2num(get(h6convescalavalue,''string''));'...
    'if v6escala<0;'...
        'beep;'...
        'msgbox(''A escala deve ser positiva'',''Erro de defini��o'',''warn'');'...
        'set(h6convescalavalue,''string'',v6escalaok);'...
        'return;'...
    'end;'...
    'v6psf=centfrq(v6wname)/((1/fs)*v6escala);'...
    'v6escalaok=sprintf(''%5.2f'',v6escala);'...
    'set(h6pseudofreqvalue,''string'',sprintf(''%5.2f'',v6psf));'];

h6convescalavalue=uicontrol('style','edit',...
    'backgroundcolor','white',...
    'enable','off',...
    'fontname','arial',...
    'fontsize',9,...
    'units','normalized',...
    'position',[0.862,0.32,0.03,0.03],...
    'string','2',...
    'callback',f6convesfr_fcn);

h6convescala=uicontrol('style','text',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'fontname','arial',...
    'enable','off',...
    'fontsize',9,...
    'HorizontalAlignment','left',...
    'units','normalized',...
    'position',[0.825,0.325,0.03,0.02],...
    'string','Escala');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VER COEFICIENTES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h6frame6=uicontrol('style','frame',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.815,0.193,0.175,0.112]);

h6vercoeflabel=uicontrol('style','text',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.82,0.273,0.15,0.023],...
    'fontname','arial',...
    'fontsize',10,...
    'HorizontalAlignment','left',...
    'FontWeight','bold',...
    'string','GRAFICAR COEFICIENTES');

h6verescalaradio=uicontrol('style','radio',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'fontname','arial',...
    'fontsize',9,...
    'enable','off',...
    'HorizontalAlignment','left',...
    'units','normalized',...
    'position',[0.82,0.24,0.05,0.02],...
    'string','Escala',...
    'callback','set(h6vertemporadio,''value'',0);set(h6vertempovalue,''enable'',''off'');set(h6verescalavalue,''enable'',''on'');');

f6checkveresc_fcn=['v6veresc=str2num(get(h6verescalavalue,''string''));'...
    'if v6veresc<v6verescok(1) | v6veresc>v6verescok(2);'...
        'beep;'...
        'msgbox(''A escala nao esta no intervalo calculado'',''Erro de defini��o'',''warn'');'...
        'set(h6verescalavalue,''string'',sprintf(''%5.2f'',v6verescok(1)));'...
        'return;'...
    'end;',...
    'set(h6convescalavalue,''string'',get(h6verescalavalue,''string''));'...
    'eval(f6convesfr_fcn);'];

h6verescalavalue=uicontrol('style','edit',...
    'backgroundcolor','white',...
    'fontname','arial',...
    'fontsize',9,...
    'enable','off',...
    'units','normalized',...
    'position',[0.88,0.235,0.04,0.03],...
    'string','1',...
    'callback',f6checkveresc_fcn);

h6vertemporadio=uicontrol('style','radio',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'fontname','arial',...
    'fontsize',9,...
    'enable','off',...
    'HorizontalAlignment','left',...
    'units','normalized',...
    'position',[0.82,0.205,0.06,0.02],...
    'string','Tempo[s]',...
    'callback','set(h6verescalaradio,''value'',0);set(h6verescalavalue,''enable'',''off'');set(h6vertempovalue,''enable'',''on'');');

f6checkvertempo_fcn=['v6vertempo=str2num(get(h6vertempovalue,''string''));'...
    'if v6vertempo>v6treg | v6vertempo<0;'...
        'beep;'...
        'msgbox(''O tempo deve ser positivo e menor ou igual que o tempo de registro'',''Erro de defini��o'',''warn'');'...
        'set(h6vertempovalue,''string'',''1'');'...
        'return;'...
    'end;'];

h6vertempovalue=uicontrol('style','edit',...
    'backgroundcolor','white',...
    'fontname','arial',...
    'fontsize',9,...
    'enable','off',...
    'units','normalized',...
    'position',[0.88,0.2,0.04,0.03],...
    'string','1',...
    'callback',f6checkvertempo_fcn);

h6verescala=uicontrol('style','pushbutton',...
    'units','normalized',...
    'enable','off',...
    'fontname','arial',...
    'fontsize',9,...
    'string','Ver',...
    'position',[0.925,0.21,0.06,0.05],...
    'callback','set(h6verescala,''enable'',''off'');vercoefcwt');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VISUAULIZAR%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h6frame7=uicontrol('style','frame',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.815,0.02,0.175,0.165]);

h6visualizarlabel=uicontrol('style','text',...
    'backgroundcolor',[0.93 0.93 0.93],...
    'units','normalized',...
    'position',[0.82,0.15,0.08,0.023],...
    'fontname','arial',...
    'fontsize',10,...
    'HorizontalAlignment','left',...
    'FontWeight','bold',...
    'string','VISUALIZAR');   

h6zoom=zoom;

f6postzoom_fcn=['v6cax=gca;'...
    'switch v6cax;'...
        'case h6axescwt;'...
            'v6elim=get(h6axescwt,''xlim'');'...
            'if v6elim(2)>v6treg*fs;'...
                'v6elim(2)=v6treg*fs;'...
            'end;'...
            'v6templim=round(v6elim./fs);'...
            'set(h6axessignal,''xlim'',v6templim);'...
        'case h6axessignal;'...
            'v6tlim=get(h6axessignal,''xlim'');'...
            'if v6elim(2)>v6treg;'...
                'v6elim(2)=v6treg;'...
            'end;'...
            'v6esclim=round(v6tlim.*fs);'...
            'set(h6axescwt,''xlim'',v6esclim);'...
    'end;'];

f6zoom_fcn=['switch get(h6zoombutton,''value'');'...
    'case 1;'...
        'set(h6zoom,''enable'',''on'',''actionpostcallback'',f6postzoom_fcn);'...
    'case 0;'...
        'set(h6zoom,''enable'',''off'');'...
    'end;'];

h6zoombutton=uicontrol('style','toggle',...
    'units','normalized',...
    'enable','off',...
    'fontname','arial',...
    'fontsize',9,...
    'string','Zoom',...
    'position',[0.822,0.09,0.075,0.05],...
    'callback',f6zoom_fcn);

f6colorbar_fcn=['switch get(h6colorbar,''value'');'...
    'case 1;'...
        'axes(h6axescwt);'...
        'v6cb=colorbar(''southoutside'',''fontsize'',8,''fontname'',''arial'');'...
    'case 0;'...
        'delete(v6cb);'...
    'end;'];

h6colorbar=uicontrol('style','toggle',...
    'units','normalized',...
    'enable','off',...
    'fontname','arial',...
    'fontsize',9,...
    'string','Colorbar',...
    'position',[0.907,0.09,0.075,0.05],...
    'callback',f6colorbar_fcn);

f6limpar_fcn=['v6reiniciarqtn=questdlg(''Deseja reiniciar o modulo?'',''Sair'',''Sim'',''N�o'',''Sim'');'...
    'switch strcmp(v6reiniciarqtn,''Sim'');'...
        'case 1;'...
            'delete(v6plotsig);'...
            'set(h6tipowave,''value'',1);'...
            'set(h6paramwave,''value'',1,''visible'',''off'');'...
            'set([h6calcular h6colorbar h6zoombutton h6escalapredef h6escaladelta h6escalatetha h6escalabetha h6escalagamma h6escalalpha],''enable'',''off'');'...
            'set([h6limpar h6verescala h6escalamintxt h6escalamin h6escalainttxt h6escalaint h6escalamaxtxt h6escalamax],''enable'',''off'');'...
            'set([h6tipowave h6convescalavalue h6convescala h6pseudofreq h6pseudofreqvalue h6escalapredef h6definirescala],''enable'',''off'');'...
            'set([h6verescalaradio h6vertemporadio],''enable'',''off'',''value'',0);'...
            'set([h6verescalavalue h6vertempovalue],''string'',''1'',''enable'',''off'');'...
            'set(h6pseudofreqvalue,''string'',''127.50'');'...
            'set([h6escalamin h6escalaint h6convescalavalue],''string'',''1'');'...
            'set(h6frqinttext,''string'',''Intervalo de pseudo-freq��ncias [Hz]:[1.99:127.50]'');'...
            'delete(h6axescwt);'...
            'h6axescwt=axes(''units'',''normalized'',''position'',[0.056,0.09,0.74,0.59],''fontsize'',9,''box'',''on'');'...
            'grid on;'...
            'ylabel(''Escala'',''fontsize'',9,''fontname'',''arial'');'...
            'xlabel(''Tempo [s]'',''fontsize'',9,''fontname'',''arial'');'...
            'set(h6sinaltxt,''string'',''Sinal:'');'...
     'end;'];

h6limpar=uicontrol('style','pushbutton',...
    'units','normalized',...
    'enable','off',...
    'fontname','arial',...
    'fontsize',9,...
    'string','Reset',...
    'position',[0.856,0.03,0.1,0.05],...
    'callback',f6limpar_fcn);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%MENU%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h6menuarquivo=uimenu('label','Arquivo');

f6errorsignal_fcn=['beep;'...
        'msgbox(''O arquivo nao tem formato compativel'',''Arquivo invalido'',''warn'');'...
        'v6errorfile=1;'];

f6selecionar_fcn=['[v6signalext,v6filepath]=uigetfile(''*.ascii'',''Escolha o arquivo de registro'');'...
        'switch ischar(v6signalext);'...
            'case 0;'...
                'return;'...
        'end;'...
        'v6file=strcat(v6filepath,v6signalext);'...
        'eval(''load(v6file)'',f6errorsignal_fcn);'...
        'if v6errorfile==1;'...
            'v6errorfile=0;'...
            'return;'...
        'end;'...
        'h6msnimport=msgbox(''...importando sinal...'',''Espere'',''warn'');'...
        'figure(h6cwt);'...
        'v6signalname=v6signalext(1:length(v6signalext)-6);'...
        'set(h6sinaltxt,''string'',strcat(''Sinal:'',v6signalname));'...
        'v6signal=((eval(v6signalname)+fa)*fb)-fc;'...
        'v6t=0:1/fs:(length(v6signal)-1)/fs;'...
        'v6treg=max(v6t);'...
        'v6tregstr=sprintf(''%6.2f'',v6treg);'...
        'axes(h6axescwt);'...
        'xlabel(strcat(''Tempo [s]'','' ['',''0:'',v6tregstr,'']''));'...
        'axes(h6axessignal);'...
        'v6plotsig=plot(v6t,v6signal);',...
        'grid on;'...
        'axis tight;',...
        'ylabel(''Amplitude [uV]'');'...
        'set([h6calcular h6escalamintxt h6escalamin h6escalainttxt h6escalaint h6escalamaxtxt h6escalamax],''enable'',''on'');'...
        'set([h6tipowave h6convescalavalue h6convescala h6pseudofreq h6pseudofreqvalue h6escalapredef h6definirescala],''enable'',''on'');'...
        'delete(h6msnimport);'];

h6selecionar=uimenu(h6menuarquivo,'label','Selecionar sinal','callback',f6selecionar_fcn);
h6sair=uimenu(h6menuarquivo,'label','Sair','callback','close(h6cwt);clear h6* f6* v6*;cwt_enable=0;');

h6menuver=uimenu('label','Ver');
h6vercolormap=uimenu(h6menuver,'label','Escala de cor CWT','enable','off');
h6colorpink=uimenu(h6vercolormap,'label','Pink','callback','colormap(h6axescwt,''pink'');');
h6colorcool=uimenu(h6vercolormap,'label','Cool','callback','colormap(h6axescwt,''cool'');');
h6colorgray=uimenu(h6vercolormap,'label','Gray','callback','colormap(h6axescwt,''gray'');');
h6colorhot=uimenu(h6vercolormap,'label','Hot','callback','colormap(h6axescwt,''hot'');');
h6colorjet=uimenu(h6vercolormap,'label','Jet','callback','colormap(h6axescwt,''jet'');');
h6colorbone=uimenu(h6vercolormap,'label','Bone','callback','colormap(h6axescwt,''bone'');');
h6colorcooper=uimenu(h6vercolormap,'label','Copper','callback','colormap(h6axescwt,''copper'');');
h6colorhsv=uimenu(h6vercolormap,'label','HSV','callback','colormap(h6axescwt,''hsv'');');
h6colorautumn=uimenu(h6vercolormap,'label','Autumn','callback','colormap(h6axescwt,''autumn'');');
h6colorspring=uimenu(h6vercolormap,'label','Spring','callback','colormap(h6axescwt,''spring'');');
h6colorwinter=uimenu(h6vercolormap,'label','Winter','callback','colormap(h6axescwt,''winter'');');
h6colorsummer=uimenu(h6vercolormap,'label','Summer','callback','colormap(h6axescwt,''summer'');');

h6menuexportar=uimenu('label','Exportar');

