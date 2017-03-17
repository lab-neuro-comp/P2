function [emgm, emgsd, emgvar, emgrms, emgrmsN, powtotal] = emgfunc(emg)

% This step is just necessary because of the way EEGLab exports the ASCII
% file. To make this function general, upload the next line on the main file
ampsemg = emg(2,:)

[g,DIM] = size(ampsemg);

%ampsemg=((ampsemg+fa)*fb)-fc; 
emgm = mean(ampsemg);
emgsd = std(ampsemg);

for j = 1:DIM
    ampsemgN(j)=(ampsemg(j)-emgm)/emgsd;
end;
    
% TODO Check why transposing the matrix is necessary
ampsemgN = ampsemgN.';

emgm = mean(ampsemgN);
emgsd = std(ampsemgN);
emgvar = var(ampsemgN);
emgrms = sqrt(sum(ampsemgN.*conj(ampsemgN))/size(ampsemgN,1));
emgrmsN = norm(ampsemgN)/sqrt(length(ampsemgN));

%pxx=abs(fft(x,n)).^2/n 
specdata = abs(fft(ampsemgN.*hamming(length(ampsemgN))))./length(ampsemgN);
 
powtotal = 0;
for i6 = 1:length(specdata)/2
    powtotal = powtotal + specdata(i6)^2;
end
