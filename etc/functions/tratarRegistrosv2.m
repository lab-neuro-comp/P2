
% %Criar os datasets
% criarDatasets();
% 
% %Criar os ICA
% gerarICA();


%Definiçao da localizaçao dos arquivos
localorigem = 'I:\AnaCog\unb\pesquisa\edf\';
localdestino = 'C:\AnaCog\UnB\tese\Tratados\';

% Arquivo com intevalos : SUJEITO	Teste	Fragmento	Nome    int1	int2 
arqints=strcat('C:\AnaCog\UnB\tese\','arqintStroop.xls');

arqloc='C:\AnaCog\UnB\Programas\locs21UP.ced';
n=0;
freq=1000;
allcleandatasets = [];
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
 n=n+1;
 arqset = strcat(localdestino, arqset,'.set');
 
 arqedf = strcat(localorigem, arqedf,'.edf');

 corte = [int1 int2]; 
 
 disp(corte);
 disp(getfiletype(char(arqedf)));
 
 %pop_biosig(filename, varargin);
 EEG = pop_biosig(char(arqedf), 'blockrange', corte, 'rmeventchan', 'off');
 
 [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1, 'setname', char(arqset),'overwrite', 'on');
 
 %pop_select(INEEG, 'key1', value1, 'key2', value2 ...);
 EEG = pop_select (EEG, 'nochannel', [27]); 
 
 [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1, 'setname', char(arqset),'overwrite', 'on');
 
 %pop_reref( EEG, ref, 'key', 'val' ...);
 EEG = pop_reref( EEG, 26);
 
 [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,  'overwrite', 'off','savenew', char(arqset));
 
 EEG = pop_chanedit(EEG,'load', arqloc);
 %EEG.chanlocs = readlocs( filename, 'key', 'val', ... );
 %EEG.chanlocs = readlocs( arqloc,'filetype','chanedit');
 
 EEG = pop_saveset( EEG, 'savemode','resave');
 [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

 EEG = eeg_checkset( EEG );
  
 EEG = pop_resample( EEG, freq);
 [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
  
 EEG = pop_editset( EEG, 'subject', sujeito);
 [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
 
 disp(CURRENTSET);
 
 %EEG = pop_saveset( EEG, 'savemode','resave');
 %[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
 
end;

disp(CURRENTSET);

[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET, 'retrieve', [2 n] , 'study',0);

EEG = eeg_checkset( EEG );

%EEG = pop_runica( EEG, 'key', 'val' );
EEG = pop_runica(ALLEEG, 'icatype', 'runica', 'dataset', 1 ,'options', {'extended' 1}, 'chanind', [1:21] ,'concatcond', 'on');         
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

EEG = pop_saveset( EEG, 'savemode','resave');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

disp('Fim.');

% EEG = eeg_checkset( EEG );
% EEG = pop_editset(EEG);
% [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
% [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 13,'savenew','C:\\AnaCog\\UnB\\tese\\Tratados\\104ST.set','gui','off'); 
% EEG = eeg_checkset( EEG );
% EEG = pop_runica(EEG, 'icatype','runica','concatcond','on','options',{'extended' 1});
% [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
