function estudo=novoestudo(nomeestudo, arqpars)
%criar um novo estudo, recebe uma planilha como parametro (caminho completo do arquivo dataset | condiçao | sujeito) 

%Definiçao da localizaçao dos arquivos
localorigem = 'C:\Users\t\Documents\UnB\Pesquisa\Tratados\';
localdestino = 'C:\Users\t\Documents\UnB\Pesquisa\Analises\eeg\';

nomeestudo='stTrea50R';

arqpars=strcat(localorigem,'arqspar.xls');

arqnf=strcat(localdestino, 'arqnotfound', '.txt');
estudo=nomeestudo;

tarefa = 'TREA';
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

disp (strcat (condicao, char(sujeito)));

 if exist(char(arqset))== 2 
 
    [STUDY ALLEEG] = std_editset( STUDY, ALLEEG,'name', estudo, 'task', tarefa, 'commands',{{'index',i,'load',char(arqset)}, {'subject',char(sujeito)}, {'condition', char(condicao)}}, 'filename', arqestudo, 'filepath', localdestino);

 else
     disp('Arquivo não encontrado.');
     fprintf(fidnf,'%s\n', char(arqset));
 end;

end;

fclose(fidnf);
