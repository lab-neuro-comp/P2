function n=criarEpochs()
clc
more off

%Definiçao da localizaçao dos arquivos
localorigem = 'C:\Users\t\Documents\UnB\Pesquisa\Tratados\edfA\R\';
localdestino = 'C:\Users\t\Documents\UnB\Pesquisa\Tratados\edfA\R\data\epocas\';

% Arquivo com intevalos : SUJEITO	Teste	Fragmento	Nome    int1	int2 
arqints=strcat('C:\Users\t\Documents\UnB\Pesquisa\Tratados\','arqsintsDMTSepoch.xls');

% Abrir o arquivo
[A,T]=xlsread(arqints);

% Open eeglab:
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab; 
ALLEEG=[]; EEG=[]; CURRENTSET=[];
%Iniciar varredura para corte de intervalos
for i=1:size(A)
 sujeito=T(i+1,1);
 teste= T(i+1,2); 
 arqset = T(i+1,3);
 evento = T(i+1,4);
 int1 = A(i,1);
 int2 = A(i,2);
 duracao = A(i,2);
 tentativa = A(i,2);
 
 eventos = cell(strcat(teste,evento))
 
 %arqset = strcat(arqset,'.set');
 
 arqepoch = strcat(sujeito, teste, evento, char(tentativa));
 
 corte = [int1 int2]; 
 
 EEG = pop_loadset( 'filename', char(arqset), 'filepath', localorigem );
 
 if strcmpi(teste,'DMTS')
    %eventos = {'DMTSgeometrica' 'DMTSnegativa' 'DMTSneutra' 'DMTSpositiva'}
    EEG = pop_epoch( EEG, {'DMTSgeometrica' 'DMTSnegativa' 'DMTSneutra' 'DMTSpositiva'} , corte, 'newname', arqepoch , 'epochinfo', 'yes');
 else
    %eventos = {'DNMTSgeometrica' 'DNMTSnegativa' 'DNMTSneutra' 'DNMTSpositiva'}
    EEG = pop_epoch( EEG, {'DNMTSgeometrica' 'DNMTSnegativa' 'DNMTSneutra' 'DNMTSpositiva'} , corte, 'newname', arqepoch , 'epochinfo', 'yes');
    
 end;
 %EEG = pop_epoch( EEG, eventos , corte, 'newname', arqepoch , 'epochinfo', 'yes');
 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 

[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

EEG = pop_saveset( EEG, 'filename', strcat(arqepoch, '.set'),'filepath',localdestino);

[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
ALLEEG = pop_delset( ALLEEG, [1] );

end 

disp('Fim.');