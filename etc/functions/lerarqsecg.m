function n=lerarqsecg(arqsecg)
%arqecg formato idsujeito;nomearqecg
clc
%Defini�ao da localiza�ao dos arquivos
localorigem = 'C:\Users\t\Documents\UnB\RegistrosPiloto\Registros\edfascii\cortes\ecg\';
localdestino = 'C:\Users\t\Documents\UnB\RegistrosPiloto\Registros\edfascii\cortes\ecg\medidas\';

n = 0;
% Prompt user and get the name of the input file.
disp('Iniciar a leitura do arquivo de arquivos');

%if arqsecg==null 
%Solicitar entrada de arquivo
%    arqsecg = input('Informe o nome do arquivo de arquivos ecg (idsujeito nomearqecg): ','s');
%end;
arqsecg='C:\Users\t\Documents\UnB\RegistrosPiloto\Registros\edfascii\arqsecg.xls';

% Abrir o arquivo
[N,T]=xlsread(arqsecg);


arq1=strcat(localdestino, 'ecg', 'vhr', '.txt');
%abre arquivo para cabecalho sujeito fragmento numR vhrm sdnn rmssd numF vhrfm 
fid1=fopen(arq1,'a');
fprintf(fid1,'%s\n', 'sujeito teste numR mvhr sdnn rmssd numF mvhrf');

     
%Iniciar varredura para calculo do ecg
for i=1:size(T)
 sujeito=T(i,1);
 arq= T(i,2);
 frag= T(i,3);
 
 %Define o nome dos arquivos de ecg
 arq=strcat(localorigem, char(arq));

 arq2=strcat(localdestino, 'ecg', char(sujeito), char(frag))
 
 %ecgrfunc(arqecg)
 [vhr, vhrf, resp]=ecgrfunc(arq);
 
 if resp == 1 
     %prepara m�dia R
     
     DIM=size(vhr)

     numR=DIM(1,2)
     vhrm = mean(vhr)
     sdnn=std(vhr)
     
     qvhr=0
     for j=1:numR
         qvhr=qvhr+vhr(j)^2
     end;
     
     rmssd=sqrt(qvhr/numR)
      
     %prepara m�dia
         DIM=size(vhrf);
         B=abs(((DIM(1,2)-1)/2)+1);

     numF =(B-1)  
     vhrfm=mean(vhrf(2:B))

     %salva em arquivo sujeito fragmento numR vhrm sdnn rmssd numF vhrfm 

     fprintf(fid1,'%s %s %d %f %f %f %d %f\n', char(sujeito), char(frag), numR, vhrm, sdnn, rmssd, numF, vhrfm);
     
     arq3=strcat(arq2,'vhr','.txt')
     
     fid=fopen(arq3,'a');
     fprintf(fid,'%f\n', vhr);
     fclose(fid);

     arq3=strcat(arq2,'vhrf','.txt')
     
     fid=fopen(arq3,'a');
     fprintf(fid,'%f\n', vhr);
     fclose(fid);

     
 else
     arq3=strcat(localdestino, 'ecg', 'corrigir', '.txt');
     fid=fopen(arq3,'a');
     fprintf(fid,'%s\n', arq);
     fclose(fid); 
     
 end;
  
end;

fclose(fid1);