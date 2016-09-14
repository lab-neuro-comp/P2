
% Sampling frequency 

Fs = 1024; 


% Time vector of 1 second 

t = 0:1/Fs:1; 


% Create a sine wave of 200 Hz.

x = sin(2*pi*t*200); 


% Use next highest power of 2 greater than or equal to length(x) to calculate FFT.
nfft= 2^(nextpow2(length(x))); 


% Take fft, padding with zeros so that length(fftx) is equal to nfft 

fftx = fft(x,nfft); 


% Calculate the numberof unique points
NumUniquePts = ceil((nfft+1)/2); 


% FFT is symmetric, throw away second half 

fftx = fftx(1:NumUniquePts); 


% Take the magnitude of fft of x and scale the fft so that it is not a function of the length of x

mx = abs(fftx)/length(x); 


% Take the square of the magnitude of fft of x. 

mx = mx.^2; 


% Since we dropped half the FFT, we multiply mx by 2 to keep the same energy.
% The DC component and Nyquist component, if it exists, are unique and should not be multiplied by 2.


if rem(nfft, 2) % odd nfft excludes Nyquist point
  mx(2:end) = mx(2:end)*2;
else
  mx(2:end -1) = mx(2:end -1)*2;
end


% This is an evenly spaced frequency vector with NumUniquePts points. 

f = (0:NumUniquePts-1)*Fs/nfft; 


% Generate the plot, title and labels. 

plot(f,mx); 
title('Power Spectrum of a 200Hz Sine Wave'); 
xlabel('Frequency (Hz)'); 
ylabel('Power'); 