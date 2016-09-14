function n=lerarqsrgp(arqsrgp)
%arqecg formato idsujeito;nomearqecg
clc
%Definiçao da localizaçao dos arquivos
localorigem = 'C:\Users\t\Documents\Unb\Noseafix\Dados\Analises\eeg\data\';
localdestino = 'C:\Users\t\Documents\Unb\Noseafix\Dados\Analises\medidas\';
n = 0;
% Prompt user and get the name of the input file.
disp('Iniciar a leitura do arquivo de arquivos');

%if arqsecg==null 
%Solicitar entrada de arquivo
%    arqsecg = input('Informe o nome do arquivo de arquivos rgp (idsujeito nomearqrgp): ','s');
%end;
arqseeg='C:\Users\t\Documents\Unb\Noseafix\Dados\Analises\eeg\data\arqseeg1.xls';

% Abrir o arquivo
[N,T]=xlsread(arqseeg);

arq1=strcat(localdestino, 'eeg', 'var', '.txt');
disp(arq1);
%abre arquivo para cabecalho sujeito fragmento numA rgpm rgpsd rgpvar SCL SCR

fid=fopen(arq1,'a');

fprintf(fid,'%s\n', 'sujeito condicao tempo Fp1	F3	C3	P3	O1	F7	T3	T5	Fp2	F4	C4	P4	O2	F8	T4	T6	Fz	Cz	Pz	Fpz	Oz	ECG	RGP	');


%Iniciar varredura para calculo do rgp
for i=1:size(T)
 arq=T(i,1);
 sujeito= T(i,2);
 condicao= T(i,3);
 
 %Define o nome dos arquivos de rgp
 arq=strcat(localorigem, char(arq));

 if exist(arq)==2 

     arqeegdata = importdata(arq, '\t',2)

 end;
 
 
 if size(arqeegdata)>0 
     %prepara média R
     
     DIM=size(arqeegdata)

     numA=DIM(1,2)
     
    plot(arqeegdata.data(:,1),arqeegdata.data(:,2))  
    plot(arqeegdata.data(:,1),arqeegdata.data(:,3))  
    plot(arqeegdata.data(:,1),arqeegdata.data(:,4))  
    plot(arqeegdata.data(:,1),arqeegdata.data(:,5))  
    plot(arqeegdata.data(:,1),arqeegdata.data(:,6))  
    plot(arqeegdata.data(:,1),arqeegdata.data(:,7))  
    plot(arqeegdata.data(:,1),arqeegdata.data(:,8))  
    plot(arqeegdata.data(:,1),arqeegdata.data(:,9))  
    plot(arqeegdata.data(:,1),arqeegdata.data(:,10)) 
    plot(arqeegdata.data(:,1),arqeegdata.data(:,11)) 
    plot(arqeegdata.data(:,1),arqeegdata.data(:,12)) 
    plot(arqeegdata.data(:,1),arqeegdata.data(:,13)) 
    plot(arqeegdata.data(:,1),arqeegdata.data(:,14)) 
    plot(arqeegdata.data(:,1),arqeegdata.data(:,15)) 
    plot(arqeegdata.data(:,1),arqeegdata.data(:,16)) 
    plot(arqeegdata.data(:,1),arqeegdata.data(:,17)) 
    plot(arqeegdata.data(:,1),arqeegdata.data(:,18)) 
    plot(arqeegdata.data(:,1),arqeegdata.data(:,19)) 
    plot(arqeegdata.data(:,1),arqeegdata.data(:,20)) 
    plot(arqeegdata.data(:,1),arqeegdata.data(:,21)) 
    plot(arqeegdata.data(:,1),arqeegdata.data(:,22)) 

     
        tempo = mean(arqeegdata.data(:,1)) 
        Fp1 = mean(arqeegdata.data(:,2))   
        F3 = mean(arqeegdata.data(:,3))    
        C3 = mean(arqeegdata.data(:,4))    
        P3 = mean(arqeegdata.data(:,5))    
        O1 = mean(arqeegdata.data(:,6))    
        F7 = mean(arqeegdata.data(:,7))    
        T3 = mean(arqeegdata.data(:,8))    
        T5 = mean(arqeegdata.data(:,9))    
        Fp2 = mean(arqeegdata.data(:,10))  
        F4 = mean(arqeegdata.data(:,11))   
        C4 = mean(arqeegdata.data(:,12))   
        P4 = mean(arqeegdata.data(:,13))   
        O2 = mean(arqeegdata.data(:,14))   
        F8 = mean(arqeegdata.data(:,15))   
        T4 = mean(arqeegdata.data(:,16))   
        T6 = mean(arqeegdata.data(:,17))   
        Fz = mean(arqeegdata.data(:,18))   
        Cz = mean(arqeegdata.data(:,19))   
        Pz = mean(arqeegdata.data(:,20))   
        Fpz = mean(arqeegdata.data(:,21))  
        Oz = mean(arqeegdata.data(:,22))   
        ECG = mean(arqeegdata.data(:,23))  
        RGP = mean(arqeegdata.data(:,24))  
     
     
      %salva em arquivo sujeito fragmento numA rgpm rgpsd rgpvar, SCL, SCR 
      fprintf(fid,'%s %s %f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f\n', char(sujeito), char(condicao), tempo, Fp1,F3,C3,P3,O1,F7,T3,T5,Fp2,F4,C4,P4,O2,F8,T4,T6,Fz,Cz,Pz,Fpz,Oz,ECG,RGP);
     
     
 end;
  
end;

fclose(fid);