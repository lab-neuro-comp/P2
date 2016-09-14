
% %Criar os datasets
% criarDatasets();
% 
% %Criar os ICAs
% gerarICA();


%Definiçao da localizaçao dos arquivos
%localorigem = 'C:\Users\t\Documents\UnB\Pesquisa\edf\';
%localdestino = 'C:\Users\t\Documents\UnB\Pesquisa\Tratados\edfB\';

%localorigem = 'C:\AnaCog\Unb\Stress\Dados2014\edfs\';
%localdestino = 'C:\AnaCog\Unb\Stress\Dados2014\edfs\Tratados\';

localorigem = 'C:\AnaCog\Unb\thiago\Thiago EEG\';
localdestino = 'C:\AnaCog\Unb\thiago\Thiago EEG\Tratados\';

%localorigem = 'C:\AnaCog\Unb\Soraya\RegistrosEEG\';
%localdestino = 'C:\AnaCog\Unb\Soraya\RegistrosEEG\Tratados\';

% Arquivo com intevalos : SUJEITO	Teste	Fragmento	Nome    int1	int2 
%arqints=strcat('C:\Users\t\Documents\UnB\Pesquisa\Tratados\','arqsints1.xls');
%arqints=strcat('C:\AnaCog\Unb\Stress\Dados2014\','arqint.xls');
%arqints=strcat('C:\AnaCog\Unb\Soraya\','_arqsint.xls');
arqints=strcat('C:\AnaCog\Unb\thiago\Thiago EEG\','eegemg.xls');


%arqloc='C:\Users\t\Documents\MATLAB\locs21UP.ced';
%arqloc='C:\AnaCog\Unb\Programas\locs23UP.ced';
arqloc='C:\AnaCog\Unb\thiago\locschan.ced'


arqnf=strcat(localdestino, 'arqnotfound', '.txt');

freq=1000;

fidnf=fopen(arqnf,'w');

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
 
 arqset = strcat(localdestino, char(sujeito), char(teste), '.set');
 
 arqedf = strcat(localorigem, char(arqedf),'.edf')

 %corte = [int1/1000 int2/1000]; 
 corte = [int1 int2]; 
 
 disp(corte);
 %disp(getfiletype(char(arqedf)));
 
 if exist(char(arqedf))==2
     
     %pop_biosig(filename, varargin);
     EEG = pop_biosig(char(arqedf), 'blockrange', corte, 'rmeventchan', 'off');

     [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1, 'setname', char(arqset),'overwrite', 'on');

     %pop_select(INEEG, 'key1', value1, 'key2', value2 ...);
     EEG = pop_select (EEG, 'nochannel', [24]); 

     [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1, 'setname', char(arqset),'overwrite', 'on');

     %pop_reref( EEG, ref, 'key', 'val' ...);
     %EEG = pop_reref( EEG, 23);
     EEG = pop_reref( EEG, [32 33]);

     [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1, 'overwrite', 'on', 'savenew', char(arqset));

     EEG = pop_chanedit(EEG,'load', arqloc);
     %EEG.chanlocs = readlocs( filename, 'key', 'val', ... );
     %EEG.chanlocs = readlocs( arqloc,'filetype','chanedit');

     EEG = pop_saveset( EEG, 'savemode','resave');
     [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

     EEG = eeg_checkset( EEG );

     %EEG = pop_resample( EEG, freq);
     %[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

     EEG = pop_editset( EEG, 'subject', sujeito);
     [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

     %EEG = pop_runica( EEG, 'key', 'val' );
     EEG = pop_runica(EEG, 'icatype', 'runica', 'dataset', 1 ,'options', {'extended' 1}, 'chanind', [1 21] ,'concatenate','off');         

     [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

     EEG = pop_saveset( EEG, 'savemode','resave');
     [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
 else
     disp('Arquivo não encontrado.');
     fprintf(fidnf,'%s\n', arqedf);
 end;
end;

disp('Fim.');