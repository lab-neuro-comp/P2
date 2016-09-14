function n=calceegdata(sujeito,fragmento,arreletrode,derivacao)
%arqeeg formato idsujeito;nomearqeeg
clc
%Definiçao da localizaçao dos arquivos
localorigem = 'C:\Users\t\Documents\UnB\Pesquisa\eegdata\';
localdestino = 'C:\Users\t\Documents\UnB\Pesquisa\Analises\eeg\';

n = 0;
% Prompt user and get the name of the input file.
disp('Iniciar a leitura do arquivo de arquivos');
arq=strcat(localdestino, char(derivacao),'.data');

%abre arquivo para cabecalho sujeito fragmento  deriv media desviopadrao
%mediana maximo minimo deltapower tethapower alphapower bethapower gammapower powtotal
if exist(arq)==2 
    fid=fopen(arq,'a');
else
    fid=fopen(arq,'a');
    fprintf(fid,'%s\n', 'sujeito fragmento deriv Ampm Ampstd Ampmed AmpMax AmpMin deltapower tethapower alphapower bethapower gammapower powtotal');
end;

deltaf1=0.5;
deltaf2=3.5;
tethaf1=3.5;
tethaf2=7;
alphaf1=8;
alphaf2=13;
bethaf1=15;
bethaf2=24;
gammaf1=30;
gammaf2=70;

fa=32768;
fb=0.200808728160525;
fc=6580;
fs=200;


%Iniciar varredura para calculo do eeg
%for i=1:size(T)
 sujeito=sujeito;
 arrdrv= arreletrode;
 frag= fragmento;
 drv= derivacao;
 
 %Define o nome dos arquivos de eeg
 
 ampseeg=0;
 
 %eegrfunc(arqeeg)
 %if exist(arq)==2 
 %    ampseeg=load(arq);
 %end;
 
 if size(arrdrv)>0 
     %prepara média R
     
    %ampseeg=((ampseeg+fa)*fb)-fc;
    specdata=abs(fft(arrdrv.*hanning(length(arrdrv))))./length(arrdrv);
    
    %Inicio de calculo dos ritmos
    deltap1=round(deltaf1*length(specdata)/fs);
    deltap2=round(deltaf2*length(specdata)/fs);
    deltapower=0;
    for i1=deltap1:deltap2
        deltapower=deltapower+specdata(i1)^2;
    end
    
    tethap1=round(tethaf1*length(specdata)/fs);
    tethap2=round(tethaf2*length(specdata)/fs);
    tethapower=0;
    for i2=tethap1:tethap2
        tethapower=tethapower+specdata(i2)^2;
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
     
     DIM=size(arrdrv)

     numA=DIM(1,2)
     
      
    %salva em arquivo sujeito fragmento drv media desviopadrao mediana maximo minimo deltapower tethapower alphapower bethapower gammapower powtotal
    fprintf(fid,'%s %s %s %f %f %f %f %f %f %f %f %f %f %f\n', char(sujeito), char(frag), char(drv), mean(arrdrv), std(arrdrv),median(arrdrv),max(arrdrv),min(arrdrv),deltapower,tethapower,alphapower,bethapower,gammapower,powtotal);     

 end;
  
%end;

fclose(fid);