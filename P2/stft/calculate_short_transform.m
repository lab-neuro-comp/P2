function [spectrum] = calculate_transform(signal, window, windowsize)
global fs

switch window
case 'Gaussian'
    windowfunction = @gausswin;
case 'Blackman'
    windowfunction = @blackman;
case 'Hann'
    windowfunction = @hann;
case 'Kaiser'
    windowfunction = @kaiser;
otherwise
    windowfunction = @hamming;
end

windowsize = floor(windowsize*fs);
spectrum = calcstft(signal, windowfunction(windowsize), windowsize);
