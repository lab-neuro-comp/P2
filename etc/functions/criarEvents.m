function n=criarEvents()
clc
more off

%Definiçao da localizaçao dos arquivos
localorigem = 'C:\Users\t\Documents\UnB\Pesquisa\Tratados\edfA\R\';
localdestino = 'C:\\Users\\t\\Documents\\UnB\\Pesquisa\\Tratados\\edfA\\R\\data\\eventos\\';

% Arquivo com intevalos : SUJEITO	Teste	Fragmento	Nome    int1	int2 
arqints=strcat('C:\Users\t\Documents\UnB\Pesquisa\Tratados\','arqsintsDMTSevento100.xls');

% Abrir o arquivo
[A,T]=xlsread(arqints);

% Open eeglab:
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab; 
ALLEEG=[]; EEG=[]; CURRENTSET=[];

arqevt=''

%Iniciar varredura para corte de intervalos
for i=1:size(A)
 sujeito=T(i+1,1);
 teste= T(i+1,2); 
 arqset = T(i+1,3);
 resposta = T(i+1,4);
 modelo = T(i+1,5);
 estimulo = T(i+1,6);
 escolha = T(i+1,7);
 indice = A(i,1);
 latencia = A(i,3);
 int2 = A(i,4);
 duracao = A(i,5);

 evento = strcat(sujeito, teste, modelo);
 disp(evento);
  
 arqset = char(arqset);
 
 indice=indice+0
 disp(indice);
 
 latencia = latencia+0
 disp(latencia);
  
 EEG = pop_loadset( 'filename', char(arqset), 'filepath', localorigem );
 [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
 
 if ~strcmpi(arqset,arqevt)
    
    EEG = pop_editeventfield( EEG, 'indices',  '1:1', 'typeinfo',{'DMTSModelo'});
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET); 
    EEG = pop_editeventfield( EEG, 'indices',  '1:1',  'DMTSEstimulo',  '0');
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    EEG = pop_editeventfield( EEG, 'indices',  '1:1',  'DMTSEscolha',  '0');
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    EEG = pop_editeventfield( EEG, 'indices',  '1:1',  'DMTSResposta', '0');
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    
    EEG.event(1) = [];
    %EEG = pop_editeventvals(EEG,'delete',0,'delete',0,'delete',0,'delete',0,'delete',0);
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

    disp(arqset);  
    arqevt=arqset;
 end;
 
     EEG.event
 
    EEG = pop_editeventvals(EEG,'insert',{1 [] [] [] [] [] []},'changefield',{1 'latency' latencia},'changefield',{1 'type' modelo},'changefield',{1 'DMTSEstimulo' estimulo},'changefield',{1 'DMTSEscolha' escolha},'changefield',{1 'DMTSResposta' resposta});
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
 

    arqnovo=strcat(char(sujeito),char(teste));
    disp(arqnovo);
    
     EEG = pop_saveset( EEG, 'savemode','resave');

     EEG = pop_saveset( EEG, 'filename', strcat(char(sujeito),char(teste),'.set'),'filepath',localdestino);
     
     %[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);


    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

 
 %ALLEEG = pop_delset( ALLEEG, [1:1] );

end

disp('Fim.');
