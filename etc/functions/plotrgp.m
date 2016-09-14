
fa=32768;
fb=0.250003814755474;
fc=8192;
fs=200;

ampsrgp=load('C:\Users\t\Documents\UnB\Pesquisa\Tratados\asciiA\cortados\dmts\74DNMTS44f4.ascii');

%ampsrgp=((ampsrgp+fa)*fb)-fc;

plot(ampsrgp);