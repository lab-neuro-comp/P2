function [emgm, emgsd, emgvar, emgrms, emgrmsN, powtotal] = emgfunc(ampsemg)

[g,DIM] = size(ampsemg);

%ampsemg=((ampsemg+fa)*fb)-fc; 
emgm = mean(ampsemg);
emgsd = std(ampsemg);

for j = 1:DIM
    ampsemgN(j)=(ampsemg(j)-emgm)/emgsd;
end;
    
emgm = mean(ampsemgN);
emgsd = std(ampsemgN);
emgvar = var(ampsemgN);
emgrms = sqrt(sum(ampsemgN.*conj(ampsemgN))/size(ampsemgN,1));
emgrmsN = norm(ampsemgN)/sqrt(length(ampsemgN));

%pxx=abs(fft(x,n)).^2/n 
specdata = abs(fft(ampsemgN.*hanning(length(ampsemgN))))./length(ampsemgN);
 
powtotal = 0;
for i6 = 1:length(specdata)/2
    powtotal = powtotal + specdata(i6)^2;
end
