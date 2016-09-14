function n=criarArqsEvents()
clc
more off

%Definiçao da localizaçao dos arquivos
localorigem = 'C:\Users\t\Documents\UnB\Pesquisa\Tratados\edfA\R\';
localdestino = 'C:\Users\t\Documents\UnB\Pesquisa\Tratados\edfA\R\data\evtvals\';

% Arquivo com intevalos : SUJEITO	Teste	Fragmento	Nome    int1	int2 
arqints=strcat('C:\Users\t\Documents\UnB\Pesquisa\Tratados\','arqsintsDMTSEventocompleto.xls');

% Abrir o arquivo
[A,T]=xlsread(arqints);

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
 
 arq1=strcat(localdestino, char(sujeito), char(teste), '.txt');
 
 if exist(arq1)==2
    fid=fopen(arq1,'a');
 else
    fid=fopen(arq1,'w');
    fprintf(fid,'%s\n', 'type estimulo escolha resposta latency duration');
 end;
          %salva em arquivo sujeito fragmento numA rgpm rgpsd rgpvar, SCL, SCR 
   %fprintf(fid,'%s %s %s %s %f %f\n', char(modelo), char(estimulo), char(escolha), char(resposta), latencia, duracao);
   fprintf(fid,'%s\t%f\t%f\t%s\t%s\t%s\n', char(modelo), latencia, duracao, char(estimulo), char(escolha), char(resposta));
   
   
  fclose(fid);
end;
disp('Fim.');