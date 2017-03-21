function [emgm, emgsd, emgvar, emgrms, emgrmsN, powtotal] = emgfunc(ampsemg)

[g,DIM] = size(ampsemg);

%ampsemg=((ampsemg+fa)*fb)-fc; 
emgm = mean(ampsemg);
emgsd = std(ampsemg);

for k = 1:DIM
    ampsemgN(k)=(ampsemg(k)-emgm)/emgsd;
end;
    
% TODO Check why transposing the matrix is necessary
ampsemgN = ampsemgN.';

emgm = mean(ampsemgN);
emgsd = std(ampsemgN);
emgvar = var(ampsemgN);
emgrms = sqrt(sum(ampsemgN.*conj(ampsemgN))/size(ampsemgN,1));
emgrmsN = norm(ampsemgN)/sqrt(length(ampsemgN));

%pxx=abs(fft(x,n)).^2/n 
specdata = abs(fft(ampsemgN.*hanning(length(ampsemgN))))./length(ampsemgN);
 
powtotal = 0;
for m = 1:length(specdata)/2
    powtotal = powtotal + specdata(m)^2;
end
