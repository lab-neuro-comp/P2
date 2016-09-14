function n=criarDatasets()
%Criar datasets dos registros

%Definiçao da localizaçao dos arquivos
%localorigem = 'C:\Users\t\Documents\UnB\Pesquisa\edf\';
localorigem = 'C:\AnaCog\Unb\Stress\Dados2014\edfs\';
%localdestino = 'C:\Users\t\Documents\UnB\Pesquisa\Tratados\edfB\';
localdestino = 'C:\AnaCog\Unb\Stress\Dados2014\edfs\Tratados\';
% Arquivo com intevalos : SUJEITO	Teste	Fragmento	Nome    int1	int2 
% arqints=strcat('C:\Users\t\Documents\UnB\Pesquisa\Tratados\','arqsints1.xls');
arqints=strcat('C:\AnaCog\Unb\Stress\Dados2014\','arqint.xls');

%arqloc='C:\Users\t\Documents\MATLAB\locs21UP.ced';
arqloc='C:\AnaCog\Unb\Programas\locs21UP.ced';

% Abrir o arquivo
[A,T]=xlsread(arqints);

% Open eeglab:
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab; 

%Iniciar varredura para corte de intervalos
for i=1:size(A)
 sujeito=T(i+1,1);
 teste= T(i+1,2); 
 arqset = T(i+1,3);
 int1 = A(i,1);
 int2 = A(i,2);
 arqedf = T(i+1, 4)
 
 arqset = strcat(localdestino, strcat(char(sujeito),teste),'.set');
 
 arqedf = strcat(localorigem, arqedf,'.edf');

 corte = [int1/1000 int2/1000]; 
 
 disp(corte);
 disp(getfiletype(char(arqedf)));
 
 %pop_biosig(filename, varargin);
 EEG = pop_biosig(char(arqedf), 'blockrange', corte, 'rmeventchan', 'off');
 
 [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1, 'setname', char(arqset),'overwrite', 'on');
 
 %pop_select(INEEG, 'key1', value1, 'key2', value2 ...);
 EEG = pop_select (EEG, 'nochannel', [24]); 
 
 [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1, 'setname', char(arqset),'overwrite', 'on');
 
 %pop_reref( EEG, ref, 'key', 'val' ...);
 EEG = pop_reref( EEG, 23);
 
 [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1, 'overwrite', 'on', 'savenew', char(arqset));
 
 EEG = pop_chanedit(EEG,'load', arqloc);
 %EEG.chanlocs = readlocs( filename, 'key', 'val', ... );
 %EEG.chanlocs = readlocs( arqloc,'filetype','chanedit');
 
 EEG = pop_saveset( EEG, 'savemode','resave');
 [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);


end;

disp('Fim.');