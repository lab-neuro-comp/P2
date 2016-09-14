function estudo=novoestudo(nomeestudo, arqpars)
%criar um novo estudo, recebe uma planilha como parametro (caminho completo do arquivo dataset | condiçao | sujeito) 

%Definiçao da localizaçao dos arquivos
%localorigem = 'C:\Users\Ana Garcia\Documents\UnB\flavia\';
%localdestino = 'C:\Users\Ana Garcia\Documents\UnB\flavia\';
%localorigem = 'C:\AnaCog\Unb\Soraya\';
%localdestino = 'C:\AnaCog\Unb\Soraya\RegistrosEEG\Tratados\';

localorigem = 'C:\AnaCog\Unb\Stress\Dados2015\Registros\';
localdestino = 'C:\AnaCog\Unb\Stress\Dados2015\Registros\Tratados\';

nomeestudo='estudostress';

arqpars=strcat(localorigem,'arqspar.xls');

arqnf=strcat(localdestino, 'arqnotfound', '.txt');

estudo=nomeestudo;

tarefa = 'IGT';
arqestudo = strcat(estudo,'.study');

% Open eeglab:
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab; 
% Set memory options:  
%pop_editoptions( 'option_storedisk', 1, 'option_savetwofiles', 1, 0, 'option_computeica', 1, 'option_scaleicarms', 0, 'option_rememberfolder', 1); 

% saves a file 'eeg_options.m' to your current working directory
% Initialize EEGLAB/STUDY variables:
STUDY = []; CURRENTSTUDY = 0; ALLEEG=[]; EEG=[]; CURRENTSET=[];

% Abrir o arquivo
[N,T]=xlsread(arqpars);

disp(N);
disp(T);

fidnf=fopen(arqnf,'w');

%Iniciar varredura para leitura dos datasets
for i=1:size(T)
 arqset=T(i,1);
 condicao= T(i,2);
 sujeito= T(i,3);
 sessao= T(i,4)
 grupo= T(i,5);

%disp (strcat (condicao, char(sujeito)));
%sessao=char(substring(sessao, 2))
arqset=strcat(localdestino, char(arqset), '.set')

 if exist(char(arqset))== 2 
 
    [STUDY ALLEEG] = std_editset( STUDY, ALLEEG,'name', estudo, 'task', tarefa, 'commands',{{'index',i,'load',char(arqset)}, {'subject',char(sujeito)}, {'condition', char(condicao)}, {'session', char(sessao)}, {'group', char(grupo)}}, 'filename', arqestudo, 'filepath', localdestino);

 else
     disp('Arquivo não encontrado.');
     fprintf(fidnf,'%s\n', char(arqset));
 end;

end;

fclose(fidnf);
