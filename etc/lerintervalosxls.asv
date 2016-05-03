function n=lerintervalosxls(rec)
%arqints formato idsujeito;teste;horainicio;horafim

%Definiçao da localizaçao dos arquivos
%localorigem = 'C:\AnaCog\UnB\pesquisa\Registros\ascii\';
%localorigem = 'C:\AnaCog\Unb\Stress\Dados2014\ascii\';
%localorigem = 'C:\AnaCog\Unb\Soraya\RegistrosEEG\ascii\';
%localdestino = 'C:\AnaCog\UnB\pesquisa\Registros\ascii\Cortados\';
%localdestino = 'C:\AnaCog\Unb\Stress\Dados2014\ascii\cortes\';
%localdestino = 'C:\AnaCog\Unb\Soraya\RegistrosEEG\ascii\cortes\';

localorigem = 'C:\AnaCog\Unb\Stress\Dados2015\Registros\ascii\';
localdestino = 'C:\AnaCog\Unb\Stress\Dados2015\Registros\cortes\';


registro=rec;


%localdestino = strcat(localdestino, registro, '\');

n = 0;

% Prompt user and get the name of the input file.
disp('Iniciar a leitura do arquivo de intervalos');

%Solicitar entrada de arquivo
%arqints = input('Informe o nome do arquivo de intervalos com o caminho (idsujeito teste horainicio horafim): ','s');
%arqints='C:\Users\t\Documents\UnB\RegistrosPiloto\Registros\arqints.xls';

%arqints=strcat('C:\AnaCog\UnB\pesquisa\Registros\','arqints.xls');
%arqints=strcat('C:\AnaCog\Unb\Stress\Dados2014\','arqint.xls');

arqints=strcat('C:\AnaCog\Unb\Stress\Dados2015\','arqsint.xls');

%Solicitar taxa de amostragem
%namostra = input('Informe a taxa de amostragem : ');
namostra=2000;

% Abrir o arquivo
[A,T]=xlsread(arqints);

%Iniciar varredura para corte de intervalos
for i=1:size(A)
 sujeito=T(i+1,1);
 teste= T(i+1,2); 
 fragmento = T(i+1,3);
 arq = T(i+1,4);
 int1 = A(i,1);
 int2 = A(i,2);
 
 
 %Define o nome dos arquivos de dados
 arq1=strcat(localorigem, char(sujeito), char(registro),'.ascii');
 arq2=strcat(localdestino, char(sujeito), char(registro), char(teste));
 
  disp(arq1);
  disp(arq2);

  if exist(arq1)==2
     %cortarascii(namostragem,arqorigem,arqdestino,int1,int2)
   cortarascii(namostra,arq1,arq2,(int1/1000),(int2/1000));
      
 end;
 
  arq2=strcat(arq2,'.ascii');
  
 if exist(arq2)==2
    %ecgfilt(arq2, 30, 90, 2000, 4, 20);
 end;
 
end;
disp('Done.');


     