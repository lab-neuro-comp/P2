function n=convedftoascii(reg, canal)
%Trata registros
%convedftoascii('ECG', '22')

disp(char(reg));
disp(char(canal));
%Definiçao da localizaçao dos arquivos
localorigem = 'C:\Pesquisadores\TreinoCognitivo\EEG\edf\';
localdestino = 'C:\Pesquisadores\TreinoCognitivo\ECG\ASCII\';

% Arquivo com intevalos : SUJEITO	Teste	Fragmento	Nome    int1	int2 
arqspar=strcat('C:\Pesquisadores\TreinoCognitivo\','arqints.xls');

arqedfanterior=''

% Abrir o arquivo
[A,T]=xlsread(arqspar);
canal=char(canal);
espaco=blanks(1);
%Iniciar varredura para corte de intervalos
for i=1:size(T)
 sujeito=T(i,1);
 teste= T(i,2); 
 fragmento= T(i,3); 
 nome = T(i,4);
 
 arqedf = strcat(nome, '-',fragmento,'.edf');
 
 disp(arqedf);
 
 arqedf = strcat(localorigem, arqedf);
 
 arqasc = strcat(localdestino, char(nome), '-', char(fragmento), '-', char(reg),'.ascii');
 arqsig = strcat(localdestino, char(nome), '-', char(fragmento), '-', char(reg),'.txt');
 
 %corte = [int1 int2]; 
 
 %disp(corte);
 disp(char(arqedf));
 
 %pars = strvcat(arqedf, ' '); 
 %canal=' 22 ';
 if ( exist(char(arqedf))==2 && strcmp(arqedf, arqedfanterior)== 0 )
    
    comando = strcat('C:\Programas\EDFToASCII', espaco, char(arqedf), espaco, ' @ ' , espaco, arqsig, espaco, arqasc, espaco,' /BATCH');

    comando =strrep(comando,'C:\', ' C:\');
    comando =strrep(comando,'e:\', ' e:\');
    comando = strrep(comando,'@', canal);

    disp(comando);

    dos (comando);

    arqedfanterior=arqedf;
 end;
end;

disp(char('teste') & char('b'));

disp('Fim.');