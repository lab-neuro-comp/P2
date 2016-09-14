function n=lerarqfilter()
%arqints formato idsujeito;teste;horainicio;horafim

pasta='dmts'

%Definiçao da localizaçao dos arquivos
localorigem = 'C:\Users\t\Documents\UnB\Pesquisa\edf\toascii\';
localdestino = 'C:\Users\t\Documents\UnB\Pesquisa\Analises\';

localorigem= 'C:\Users\t\Documents\UnB\Pesquisa\Tratados\asciiA\cortados\';

localorigem = strcat(localorigem, char(pasta),'\')

n = 0;

% Prompt user and get the name of the input file.
disp('Iniciar a leitura do arquivo de intervalos');

%Solicitar entrada de arquivo
%arqints = input('Informe o nome do arquivo de intervalos com o caminho (idsujeito teste horainicio horafim): ','s');
%arqints='C:\Users\t\Documents\UnB\RegistrosPiloto\Registros\arqints.xls';

arqints=strcat('C:\Users\t\Documents\UnB\Pesquisa\Tratados\','arqsints', char(pasta),'.xls');

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
 tentativa = T(i+1,4);
 tempo = A(i,1);
 
 disp(strcat('Filtrando: ',arq));
 
 fc=30;

 %Define o nome dos arquivos de dados
 arq=strcat(localorigem, char(arq));

 if exist(arq)==2
    %ecgfilt(arq2, 30, 90, 2000, 4, 20);
    emgfilt(arq, tempo, fc, namostra );
 end;
 
end;
disp('Done.');


     