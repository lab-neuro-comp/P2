function n=lereeglabdata25(arqsrgp)
%arqecg formato idsujeito;nomearqecg
clc
%Definiçao da localizaçao dos arquivos
localorigem = 'C:\Users\t\Documents\UnB\Pesquisa\eegdata\';
localdestino = 'C:\Users\t\Documents\UnB\Pesquisa\Analises\';

n = 0;
% Prompt user and get the name of the input file.
disp('Iniciar a leitura do arquivo de arquivos');

%if arqsecg==null 
%Solicitar entrada de arquivo
%    arqsecg = input('Informe o nome do arquivo de arquivos rgp (idsujeito nomearqrgp): ','s');
%end;
%arqseeg='C:\Users\t\Documents\Unb\Noseafix\Dados\Analises\eeg\data\arqseeg.xls';
arqseeg='C:\Users\t\Documents\UnB\Pesquisa\eegdata\arqseegdata.xls';

% Abrir o arquivo
[N,T]=xlsread(arqseeg);

arq1=strcat(localdestino, 'eeg\eeg', 'var', '.txt');

%abre arquivo para cabecalho sujeito fragmento numA rgpm rgpsd rgpvar SCL SCR
arqdataeletrode=['tmp';'Fp1';'F3 ';'C3 ';'P3 ';'O1 ';'F7 ';'T3 ';'T5 ';'Fp2';'F4 ';'C4 ';'P4 ';'O2 ';'F8 ';'T4 ';'T6 ';'Fz ';'Cz ';'Pz ';'Fpz';'Oz ';'ECG';'RGP';'EMC';'EMZ']
A = cellstr(arqdataeletrode)

if exist(arq1)==2 
    fid=fopen(arq1,'a');
else
    fid=fopen(arq1,'a');
    fprintf(fid,'%s\n', 'sujeito condicao tempo Fp1	F3	C3	P3	O1	F7	T3	T5	Fp2	F4	C4	P4	O2	F8	T4	T6	Fz	Cz	Pz	Fpz	Oz	ECG	RGP	EMGC	EMGZ');
    
end;

%Physical value uV = (ASCII+32768)*0,250003814755474-8192
fa=32768;
fb=0.250003814755474;
fc=8192;
fs=2000;

%Iniciar varredura para leitura dos arquivos
for i=1:size(T)
 arq=T(i,1);
 sujeito= T(i,2);
 condicao= T(i,3);
 
 %Define o nome dos arquivos de rgp
 arq=strcat(localorigem, char(arq));
 disp (strcat('Lendo -', arq));
 %rgprfunc(arqrgp)
 if exist(arq)==2 
   
   arqeegdata = importdata(arq, '\t',2)

 end;
 
 if size(arqeegdata)>0 
     %prepara média R
     
     DIM=size(arqeegdata)
     % disp(arqeegdata)
     
 for i=2:22    
     
     numA=DIM(1,2)
     
     %arqdataeletrode=char(arqeegdata.colheaders(0,i));
     disp(strcat('Preparando cálculo de -', A(i)));
     
     %calceegdata(sujeito,fragmento,arreletrode,derivacao)
     calceegdata(sujeito,condicao,arqeegdata.data(:,i),A(i))
     
     %plot(arqeegdata.data(:,1),arqeegdata.data(:,2));  
     
 end;     
      %salva em arquivo sujeito condicao tempo Fp1	F3	C3	P3	O1	F7	T3  T5	Fp2	F4	C4	P4	O2	F8	T4	T6	Fz	Cz	Pz	Fpz	Oz	ECG	RGP	EMGC	EMGZ
      fprintf(fid,'%s %s %f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f	%f\n', char(sujeito), char(condicao), mean(arqeegdata.data(:,1)), mean(arqeegdata.data(:,2)), mean(arqeegdata.data(:,3)), mean(arqeegdata.data(:,4)), mean(arqeegdata.data(:,5)), mean(arqeegdata.data(:,6)), mean(arqeegdata.data(:,7)), mean(arqeegdata.data(:,8)), mean(arqeegdata.data(:,9)), mean(arqeegdata.data(:,10)), mean(arqeegdata.data(:,11)), mean(arqeegdata.data(:,12)), mean(arqeegdata.data(:,13)), mean(arqeegdata.data(:,14)), mean(arqeegdata.data(:,15)), mean(arqeegdata.data(:,16)), mean(arqeegdata.data(:,17)), mean(arqeegdata.data(:,18)), mean(arqeegdata.data(:,19)), mean(arqeegdata.data(:,20)), mean(arqeegdata.data(:,21)), mean(arqeegdata.data(:,22)), mean(arqeegdata.data(:,23)), mean(arqeegdata.data(:,24)), mean(arqeegdata.data(:,25)), mean(arqeegdata.data(:,26)));
      
      arqecg=strcat(localdestino, 'ecg\ecg', char(condicao), char(sujeito), '.ascii');
      fidecg=fopen(arqecg,'w');
      fprintf(fidecg,'%f\n', arqeegdata.data(:,23));
      fclose(fidecg)
      
      arqrgp=strcat(localdestino, 'rgp\rgp', char(condicao), char(sujeito), '.ascii');
      fidrgp=fopen(arqrgp,'w');
      fprintf(fidrgp,'%f\n', arqeegdata.data(:,24));
      fclose(fidrgp)

      arqemg=strcat(localdestino, 'emg\emg', char(condicao), char(sujeito), '.ascii');
      fidemg=fopen(arqemg,'w');
      fprintf(fidemg,'%f	%f\n', arqeegdata.data(:,25), arqeegdata.data(:,26));
      fclose(fidemg)

      
 end;
  
end;

fclose(fid);