function n=lerarqseeg(arqseeg)
%arqeeg formato idsujeito;nomearqeeg
clc
%Defini�ao da localiza�ao dos arquivos
localorigem = 'C:\Users\t\Documents\UnB\RegistrosPiloto\Registros\edfascii\cortes\eeg\';
localdestino = 'C:\Users\t\Documents\UnB\RegistrosPiloto\Registros\edfascii\cortes\eeg\medidas\';

n = 0;
% Prompt user and get the name of the input file.
disp('Iniciar a leitura do arquivo de arquivos');

%if arqseeg==null 
%Solicitar entrada de arquivo
%    arqseeg = input('Informe o nome do arquivo de arquivos eeg (idsujeito nomearqeeg): ','s');
%end;
arqseeg='C:\Users\t\Documents\UnB\RegistrosPiloto\Registros\edfascii\arqeeg21.xls';

% Abrir o arquivo
[N,T]=xlsread(arqseeg);

arq1=strcat(localdestino, 'eeg', 'var', '.txt');
%abre arquivo para cabecalho sujeito fragmento  deriv Ampm
fid=fopen(arq1,'a');
fprintf(fid,'%s\n', 'sujeito fragmento deriv Ampm');

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

fa=4096;
fb=0.0610426077402027;
fc=250;
fs=200;

%Iniciar varredura para calculo do eeg
for i=1:size(T)
 sujeito=N(i,1);
 arq= T(i,2);
 frag= T(i,3);
 drv= T(i,4);
 
 %Define o nome dos arquivos de eeg
 arq=strcat(localorigem, char(arq));
 ampseeg=0;
 
 %eegrfunc(arqeeg)
 if exist(arq)==2 
     ampseeg=load(arq);
 end;
 
 if size(ampseeg)>0 
     %prepara m�dia R
     
    ampseeg=((ampseeg+fa)*fb)-fc;
    specdata=abs(fft(ampseeg.*hanning(length(ampseeg))))./length(ampseeg);
    
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
     
     DIM=size(ampseeg)

     numA=DIM(1,2)
     Ampm = mean(ampseeg)
     
%       %salva em arquivo sujeito fragmento numA eegm eegsd eegvar 
%       fprintf(fid,'%s %s %s %f\n', num2str(sujeito), char(frag), char(drv), Ampm);
      
%salva em arquivo sujeito fragmento drv media desviopadrao mediana maximo
%minimo deltapower tethapower alphapower bethapower gammapower powtotal
fprintf(fid,'%s %s %s %f %f %f %f %f %f %f %f %f %f %f\n', num2str(sujeito), char(frag), char(drv), mean(ampseeg), std(ampseeg),median(ampseeg),max(ampseeg),min(ampseeg),deltapower,tethapower,alphapower,bethapower,gammapower,powtotal);     
 end;
  
end;

fclose(fid);