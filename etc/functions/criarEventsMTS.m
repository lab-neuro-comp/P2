function n=criarEvents()
clc
more off

%Definiçao da localizaçao dos arquivos
localorigem = 'C:\Users\t\Documents\UnB\Pesquisa\Tratados\edfA\R\';
localdestino = 'C:\Users\t\Documents\UnB\Pesquisa\Tratados\edfA\R\data\epocas\';

% Arquivo com intevalos : SUJEITO	Teste	Fragmento	Nome    int1	int2 
arqints=strcat('C:\Users\t\Documents\UnB\Pesquisa\Tratados\','arqsintsDMTSEventos.xls');

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
 int1 = A(i,1);
 int2 = A(i,2);

 
 disp(strcat(sujeito,teste));
 
 EEG = pop_loadset( 'filename', char(arqset), 'filepath', localorigem );
 
 %EEG = pop_editeventvals( EEG, 'delete', 0);
 
 if strcmpi(teste,'DMTS')
    EEG = pop_editeventfield( EEG, 'indices',  1:48, 'typeinfo',{'DMTSModelo'});
    
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    
    EEG.event
    
    EEG = pop_selectevent( EEG, 'event',[4 8 12 16 21 25 29 34 36 39 43 48] ,'renametype','DMTSgeometrica','deleteevents','off');
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
%     indevt = {4, 8, 12, 16, 21, 25, 29, 34, 36, 39, 43, 48}
%     for i=1:length(indevt)
%         pop_editeventvals(EEG, 'insert', {n} ,'changefield',{n,'type','DMTSgeometrica'})
%         [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
%     end;
    
    
    EEG = pop_selectevent( EEG, 'event',[2 7 10 15 19 23 28 32 38 42 44 47] ,'renametype','DMTSnegativa','deleteevents','off');
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
%     indevt = {2, 7, 10, 15, 19, 23, 28, 32, 38, 42, 44, 47}
%     for i=1:length(indevt)
%         pop_editeventvals(EEG, 'insert',{indevt(i),[],[],[]},'changefield',{indevt(i),'type','DMTSnegativa'})
%         [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
%     end;

    EEG = pop_selectevent( EEG, 'event',[3 5 9 13 18 24 26 30 33 37 41 46] ,'renametype','DMTSneutra','deleteevents','off');
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
%     indevt = {3, 5, 9, 13, 18, 24, 26, 30, 33, 37, 41, 46}
%     for i=1:length(indevt)
%         pop_editeventvals(EEG, 'insert',{indevt(i),[],[],[]},'changefield',{indevt(i),'type','DMTSneutra'})
%         [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
%     end;    
        
    EEG = pop_selectevent( EEG, 'event',[1 6 11 14 17 20 22 27 31 35 40 45] ,'renametype','DMTSpositiva','deleteevents','off');
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
%     indevt = {1, 6, 11, 14, 17, 20, 22, 27, 31, 35, 40, 45}
%     for i=1:length(indevt)
%         pop_editeventvals(EEG, 'insert',{indevt(i),[],[],[]},'changefield',{indevt(i),'type','DMTSpositiva'})
%         [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
%     end;
 else
    EEG = pop_editeventfield( EEG, 'indices',  '1:48', 'typeinfo',{'DNMTSModelo'});
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    
    EEG = pop_selectevent( EEG, 'event',[1 5 11 16 20 22 24 36 40 43 45 47] ,'renametype','DNMTSgeometrica','deleteevents','off');
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
%     indevt = {1, 5, 11, 16, 20, 22, 24, 36, 40, 43, 45, 47}
%     for i=1:length(indevt)
%         pop_editeventvals(EEG, 'insert',{indevt(i),[],[],[]},'changefield',{indevt(i),'type','DNMTSgeometrica'})
%         [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
%     end;
    
    EEG = pop_selectevent( EEG, 'event',[3 7 9 12 18 21 25 27 31 33 38 44] ,'renametype','DNMTSnegativa','deleteevents','off');
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
%     indevt = {3, 7, 9, 12, 18, 21, 25, 27, 31, 33, 38, 44}
%     for i=1:length(indevt)
%         pop_editeventvals(EEG, 'insert',{indevt(i),[],[],[]},'changefield',{indevt(i),'type','DNMTSnegativa'})
%         [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
%     end;
    
    EEG = pop_selectevent( EEG, 'event',[4 8 13 15 19 26 30 32 35 39 42 46] ,'renametype','DNMTSneutra','deleteevents','off');
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
%     indevt = {4, 8, 13, 15, 19, 26, 30, 32, 35, 39, 42, 46}
%     for i=1:length(indevt)
%         pop_editeventvals(EEG, 'insert',{indevt(i),[],[],[]},'changefield',{indevt(i),'type','DNMTSneutra'})
%         [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
%     end;
    
    EEG = pop_selectevent( EEG, 'event',[2 6 10 14 17 23 28 29 34 37 41 48] ,'renametype','DNMTSpositiva','deleteevents','off');
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
%     indevt = {2, 6, 10, 14, 17, 23, 28, 29, 34, 37, 41, 48}
%     for i=1:length(indevt)
%         pop_editeventvals(EEG, 'insert',{indevt(i),[],[],[]},'changefield',{indevt(i),'type','DNMTSpositiva'})
%         [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
%     end;
 end 

EEG = pop_saveset( EEG, 'savemode','resave');
 
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
 
end

disp('Fim.');