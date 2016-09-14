
% %Criar os datasets
% criarDatasets();
% 
% %Criar os ICA
% gerarICA();


%Definiçao da localizaçao dos arquivos
localorigem = 'C:\Pesquisadores\TreinoCognitivo\EEG\tratados\';
localdestino = 'C:\Pesquisadores\TreinoCognitivo\EEG\icados\';

% Arquivo com intevalos : SUJEITO	Teste	Fragmento	Nome    int1	int2 
arqints=strcat('C:\Pesquisadores\TreinoCognitivo\','arqints.xls');

arqloc='C:\Programas\locs21UP.ced';
ref=24
freq=1000;

% Abrir o arquivo
[A,T]=xlsread(arqints);

% Open eeglab:
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab; 

%Iniciar varredura para corte de intervalos
for i=1:size(A)
 sujeito=T(i+1,1);
 teste= T(i+1,2);
 set = T(i+1,3);
 int1 = A(i,1);
 int2 = A(i,2);
 freq = A(i,3);
 iniciais = T(i+1, 4);
 
    
     nomeset= strcat(teste, '-', set);

     arqset = strcat(localorigem, nomeset, '.set');
    
     if exist(char(arqset))==2
         
           
        EEG = pop_loadset('filename',arqset);
        EEG = eeg_checkset( EEG ); 
        
        %[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve', [1:i], 'study',0); 
        EEG = eeg_checkset( EEG ); 

        %EEG = pop_runica( EEG, 'key', 'val' );
        EEG = pop_runica(EEG, 'icatype','runica','concatcond','off','options',{'extended' 1});
        
        arqset = strcat(localdestino, nomeset, '.set');
        
        [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1, 'overwrite', 'on', 'savenew', char(arqset));
        [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

        
        EEG = pop_saveset( EEG, 'savemode','resave');
        [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

     end;    
        
 end;

disp('Fim.');