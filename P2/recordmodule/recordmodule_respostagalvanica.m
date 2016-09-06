function recordmodule_respostagalvanica(entrada)
%Abaixo bota-se o nome dos dois arquivos os quais
%quer-se filtrar ( separar a resposta galvânica
%do EMG)
%<authour> joaopauloc.souza@outlook.com
celula=importdata(strcat(entrada,'.txt'));%<- .txt
m = dlmread(strcat(entrada,'.ascii'));%<- ascii

%Este programa dará como resposta o gráfico do sinal
%Em função do tempo
%======================================================
%Código para conseguir a freq de amostragem a partir do
%aarquivo de texto
texto=char(celula)
a0=find(texto(8,:)==':');
a1=find(texto(8,:)=='H');
valor=texto(8,a0+1:a1-1);
fs=str2num(valor);
%C�digo para trocar as virgulas por pontos
b0=find(texto(9,:)==',');
for i=1:length(b0)
texto(9,b0(i))='.';
end
%C�digo para conseguir o primeiro n�mero da f�rmula
a0=find(texto(9,:)=='+');
a1=find(texto(9,:)==')');
valor=texto(9,a0+1:a1-1);
c0=str2num(valor);
%C�digo para conseguir o ultimo n�mero
a0=find(texto(9,:)=='-');
valor=texto(9,a0+1:end);
c1=str2num(valor);
%C�digo para conseguir o segundo n�mero
a0=find(texto(9,:)=='*');
a1=find(texto(9,:)=='-');
valor=texto(9,a0+1:a1-1);
c2=str2num(valor);
%Para abrir o arquivo
m=(m+c0)*c2-c1;
%Construir o espectro de freq
Y=fft(m);
Ay=abs(Y);
%Para achar a freq da resposta galv�nica
for i=floor(length(Ay)/2):length(Ay)
    if Ay(i)>3e+04
        a=i;
        break
    end
end
w=linspace(-(fs/2),(fs/2),length(m));
b=w(a);
%Para construir o filtro
%Especifica��es
Fs =fs;
filtertype = 'FIR';
Fpass = b;
Fstop = b+2;
Rp = 0.1;
Astop = 80;
%
LPF=dsp.LowpassFilter('SampleRate',Fs,...
                             'FilterType',filtertype,...
                             'PassbandFrequency',Fpass,...
                             'StopbandFrequency',Fstop,...
                             'PassbandRipple',Rp,...
                             'StopbandAttenuation',Astop);
NUM=tf(LPF);
x=filter(NUM,1,m);
%construir o eixo do tempo
t=linspace(0,(1/fs)*length(m),length((m)));
%Para plotar
figure
plot(t,x)
