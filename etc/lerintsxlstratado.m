function n=lerintxlstratado(arqints)
%arqints formato idsujeito;teste;horainicio;horafim

%Definiçao da localizaçao dos arquivos
%localorigem = 'C:\Users\t\Documents\UnB\Pesquisa\ascii\tratados\';
localorigem = 'F:\Unb\Dados\tratados\';
%localdestino = 'C:\Users\t\Documents\UnB\Pesquisa\ascii\tratados\cortados\';
localdestino = 'C:\Users\t\Documents\UnB\Pesquisa\Tratados\asciiA\cortados\dmts\'; 
registro='ECG'
n = 0;

% Prompt user and get the name of the input file.
disp('Iniciar a leitura do arquivo de intervalos');

%Solicitar entrada de arquivo
%arqints = input('Informe o nome do arquivo de intervalos com o caminho (idsujeito teste horainicio horafim): ','s');
%arqints='C:\Users\t\Documents\UnB\RegistrosPiloto\Registros\arqints.xls';
%arqints='C:\Users\t\Documents\UnB\Pesquisa\ascii\arqsints.xls';
arqints='C:\Users\t\Documents\UnB\Pesquisa\Tratados\arqsintsdmts.xls'

%Solicitar taxa de amostragem
%namostra = input('Informe a taxa de amostragem : ');
namostra=2000;

% Abrir o arquivo
[A,T]=xlsread(arqints);

%Iniciar varredura para corte de intervalos
for i=1:size(A)
 sujeito=T(i+1,1);
 teste= T(i+1,2); 
 arq = T(i+1,3);
 nome = A(i,1);
 int1 = A(i,2);
 int2 = A(i,3);
 
 %disp (sujeito);
 %disp (teste);
 %disp (arq);
 disp (nome);
 %disp(int1);
 %disp(int2);
 
 %Define o nome dos arquivos de dados
 arq1=strcat(localorigem, char(sujeito),'.ascii');
 arq2=strcat(localdestino, char(arq));

 disp(arq1);
 disp(arq2);
  
 %cortarascii(namostragem,arqorigem,arqdestino,int1,int2)
 cortarasciitratado(namostra,arq1,arq2,int1,int2);
 
end;