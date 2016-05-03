function n=lerintervalos(arqints)
%arq formato idsujeito;teste;horainicio;horafim
%int sujeito=0;
% char teste="";
% double int1 = 0.0;
% double int2 = 0.0;

n = 0;
% Prompt user and get the name of the input file.
disp('Iniciar a leitura do arquivo de intervalos');
%disp(arqints);

%Solicitar entrada de arquivo
%arqints = input(' ','s');
%Arquivo parateste
%arqints='C:\Users\t\Documents\_arqintstab.txt'
%arqints='C:\Users\t\Documents\_arqintsfixa.txt'
arqints='C:\Users\t\Documents\Unb\Noseafix\Dados\Analises\NFints.txt'
%arqints='C:\Users\t\Documents\_arqintsptovrg.txt';
%arqints='C:\Users\t\Documents\arqints.xls';

% Abrir o arquivo
[fid,msg]=fopen(arqints,'rt');

% Verificar sucesso da abertura
if fid < 0
% Erro!
    disp(msg);
else
% Sucesso!
    n=1;
    %fscanf(fid,'%d%s%f%f',sujeito,teste,int1,int2);
    
    [in, count] = fscanf(fid,'%d %s %f %f',[n, 4]);
     
    while ~feof(fid)
        sujeito=in(1)
        teste=in(2); 
        int1 = in(3);
        int2 = in(4);
        
        %n=n+1;
        % Busca o próximo
        [in,count] = fscanf(fid,'%d%s%f%f\n',[n 4]);
    end;
end;    
% Close the file
fclose(fid);
    
% printf('Arq = %s \n', in);
   
plot (in)    