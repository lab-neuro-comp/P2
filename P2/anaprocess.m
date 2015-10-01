clear
clc
path='C:\Documents and Settings\Sergio Andres Conde\Desktop\dados ana\cortes\rgp\';

% front={'F3A1','F4A2','F7A1','F7A2','FZA1'};
% prefront={'Fp1A1','Fp2A2','FpzA2'};
% central={'C3A1','C4A2','CzA2'};
% ox={'O1A1','O2A2','OzA2'};
% 
% test={'DMTS','DNMTS'};

file='S21DMTS.ascii';

signal=load(strcat(path,file));
signal=((signal+32768)*0.250003814755474-8192);
% reacc(length(signal))=0;
% modpos(length(signal))=0;
% modneg(length(signal))=0;
% modgeo(length(signal))=0;
% modneut(length(signal))=0;
% estpos(length(signal))=0;
% estneg(length(signal))=0;
% estgeo(length(signal))=0;
% estneut(length(signal))=0;
t=0:1/200:(length(signal)-1)/200;
% [testnumeric,teststring]=xlsread('C:\Documents and Settings\Sergio Andres Conde\Desktop\analisegrafica','a2:g1153');

load testnumeric
load teststring
imodpos=1;
imodneg=1;
imodgeo=1;
imodneut=1;
iestpos=1;
iestneg=1;
iestgeo=1;
iestneut=1;
ireac=1;


for i=1:46
    k=i;
    indicemod=round(testnumeric(i,3)*200)+1;
    switch teststring{i,6}
        case 'positiva'
            modpos(imodpos)=signal(indicemod);
            tmodpos(imodpos)=t(indicemod);
            imodpos=imodpos+1;
        case 'negativa'
            modneg(imodneg)=signal(indicemod);
            tmodneg(imodneg)=t(indicemod);
            imodneg=imodneg+1;
        case 'geometrica'
            modgeo(imodgeo)=signal(indicemod);
            tmodgeo(imodgeo)=t(indicemod);
            imodgeo=imodgeo+1;
        case 'neutra'
            modneut(imodneut)=signal(indicemod);
            tmodneut(imodneut)=t(indicemod);
            imodneut=imodneut+1;
    end
    indicesti=round(testnumeric(i,4)*200)+1;
    switch teststring{i,7}
        case 'positiva'
            estpos(iestpos)=signal(indicesti);
            testpos(iestpos)=t(indicesti);
            iestpos=iestpos+1;
        case 'negativa'
            estneg(iestneg)=signal(indicesti);
            testneg(iestneg)=t(indicesti);
            iestneg=iestneg+1;
        case 'geometrica'
            estgeo(iestgeo)=signal(indicesti);
            testgeo(iestgeo)=t(indicesti);
            iestgeo=iestgeo+1;
        case 'neutra'
            estneut(iestneut)=signal(indicesti);
            testneut(iestneut)=t(indicesti);
            iestneut=iestneut+1;
    end
    indicereac=round(testnumeric(i,5)*200)+1;
    reacc(ireac)=signal(indicereac);
    treacc(ireac)=t(indicereac);
    ireac=ireac+1;
    
end

plot(t,signal)
hold on
s=stem(tmodneg,modneg,'kv','linewidth',2,'markersize',8);
stem(tmodpos,modpos,'k+','linewidth',2,'markersize',8);
stem(tmodgeo,modgeo,'kd','linewidth',2,'markersize',8);
stem(tmodneut,modneut,'ko','linewidth',2,'markersize',8);
stem(testneg,estneg,'gv','linewidth',2,'markersize',8);
stem(testpos,estpos,'g+','linewidth',2,'markersize',8);
stem(testgeo,estgeo,'gd','linewidth',2,'markersize',8);
stem(testneut,estneut,'go','linewidth',2,'markersize',8);
stem(treacc,reacc,'r*','linewidth',2,'markersize',8);

axis tight 
grid on