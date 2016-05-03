function n=lerarqsrgp(pasta)
%arqecg formato idsujeito;nomearqecg
clc
clc
%Definiçao da localizaçao dos arquivos
localorigem = 'C:\Users\t\Documents\UnB\Pesquisa\Tratados\asciiA\cortados\'; 
localdestino = 'C:\Users\t\Documents\UnB\Pesquisa\Analises\';

localorigem = strcat(localorigem, char(pasta), '\')

n = 0;

registro='RGP';

%localorigem = strcat(localorigem, registro, '\');
localdestino = strcat(localdestino, registro, '\data\');

arqsrgp=strcat('C:\Users\t\Documents\UnB\Pesquisa\Tratados\arqsints', char(pasta),'.xls');

% Prompt user and get the name of the input file.
disp('Iniciar a leitura do arquivo de arquivos');

% Abrir o arquivo
[N,T]=xlsread(arqsrgp);

arq1=strcat(localdestino, registro, char(pasta), 'trials', '.txt');
arq2=strcat(localdestino, registro, char(pasta), 'notfound', '.txt');
%abre arquivo para cabecalho sujeito fragmento numA rgpm rgpsd rgpvar SCL SCR

fid=fopen(arq1,'w');
fprintf(fid,'%s\n', 'sujeito	fragmento	numA	rgpm	rgpsd	rgpvar	SC	SCR');

fidnf=fopen(arq2,'w');

%Physical value uV = (ASCII+32768)*0,250003814755474-8192
fa=32768;
fb=0.250003814755474;
fc=8192;
fs=2000;

int1=0
int2=1

%Ajusta o intervalo a amostragem
int1=int1*fs;
int2=int2*fs;

if int1==0
   int1=1
end;

%Iniciar varredura para calculo do rgp
%for i=2:size(T)
for i=1:size(N)
 sujeito=T(i+1,1);
 arq= T(i+1,2);
 frag= T(i+1,3);
 tentativa= N(i,1);
 
 %Define o nome dos arquivos de rgp
 %arq=strcat(localorigem, registro, char(frag), '.ascii');
 arq=strcat(localorigem, char(arq));
  
 disp (arq);
 %rgprfunc(arqrgp)
 if exist(arq)== 2 
     ampsrgp=load(arq);

     %ampsrgp=((ampsrgp+fa)*fb)-fc;

     if size(ampsrgp)>0 
         %prepara média R

         DIM=size(ampsrgp)
         
         if DIM(1)>=int2 
         %Extrai os dados no intervalo de dados
           % ampsrgp=ampsrgp(int1:int2,:);
          end;
         
         numA=DIM(1,2)
         rgpm=mean(ampsrgp)
         rgpsd=std(ampsrgp)
         for j=1:DIM
             ampsrgpN(j)=(ampsrgp(j)-rgpm)/rgpsd
         end;
         
         rgpm=mean(ampsrgpN)
         rgpsd=std(ampsrgpN)
         rgpvar=var(ampsrgpN)

         sclmin= min(ampsrgpN)
         sclmax = max(ampsrgpN)
         
         %(Lykken et al., 1966) 
         %SCL=(sclobserved-sclmin)/(sclmax-sclmin) 
         SCL = (rgpm-sclmin)/(sclmax-sclmin)
         % SCR=sclobserved/sclmax
         SCR = rgpm /sclmax

          %salva em arquivo sujeito fragmento tentativa rgpm rgpsd rgpvar, SCL, SCR 
          fprintf(fid,'%s\t%s\t%d\t%f\t%f\t%f\t%f\t%f\n', char(sujeito), char(frag), tentativa, rgpm, rgpsd, rgpvar, SCL, double(SCR));
      end;    
 else
     disp('Arquivo não encontrado.');
     fprintf(fidnf,'%s\n', arq);
 end;
  
end;

fclose(fid);
fclose(fidnf);

disp('Done.');