function n=criarEvents()
clc
more off

%Definiçao da localizaçao dos arquivos
localorigem = 'C:\Users\t\Documents\UnB\Pesquisa\Tratados\edfA\R\';
localdestino = 'C:\\Users\\t\\Documents\\UnB\\Pesquisa\\Tratados\\edfA\\R\\data\\eventos\\';

% Arquivo com intevalos : SUJEITO	Teste	Fragmento	Nome    int1	int2 
arqints=strcat('C:\Users\t\Documents\UnB\Pesquisa\Tratados\','arqsintsDMTSeventos.xls');

% Abrir o arquivo
[A,T]=xlsread(arqints);

% Open eeglab:
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab; 
ALLEEG=[]; EEG=[]; CURRENTSET=[];

arqevt=''

    arq1=strcat('C:\Users\t\Documents\UnB\Pesquisa\Tratados\edfA\R\data\evento\', 'numevts', '.txt');
    fid=fopen(arq1,'a');

%Iniciar varredura para corte de intervalos
for i=1:size(A)
 sujeito=T(i+1,1);
 teste= T(i+1,2); 
 arqset = T(i+1,3);
 int1 = A(i,1);
 int2 = A(i,2);

 
 arqset = char(arqset);
 
 
 EEG = pop_loadset( 'filename', char(arqset), 'filepath', localorigem );
 [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

   disp('evento original:');
    
    disp(EEG.event);
    
    disp(length(EEG.event));
    
    
    numevt=length(EEG.event)
    %for i=1:length(EEG.event) 
        %EEG.event = [];
    %end;


    fprintf(fid,'%s\t%f\t%f\t%f\t%s\n', char(sujeito), numevt, int1, int2, char(arqset));

    
%     [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
%     EEG = pop_saveset( EEG, 'savemode','resave');
%     [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
% 
%     disp('evento limpo:');
%     EEG.event

    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    


end;

fclose(fid);

disp('Fim.');
