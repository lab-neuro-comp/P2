function FourierRecognition(testcase, density, windowsize)
% Recognizes where the voice in a WAV file begins based on the chosen density 
% and window size using the windowed Fourier transform.

% performing analysis
[recording, samplerate, nbits] = wavread(testcase);
limit = length(recording);
tic
outlet = recognize_voice(recording, hamming(windowsize), windowsize);
fprintf('%s: <%.5f>\n', testcase, mean(outlet) + std(outlet));
% TODO Apply threshold logic to this outlet variable
toc

% plotting results
figure;
plot(1:length(outlet), outlet);

% --- WINDOWED FOURIER TRANSFORM ----------------------------------------------
function [presence] = recognize_voice(signal, window, windowsize)
% Recognizes if there is a voice signal for each window using the FFT
limit = length(signal);
presence = [];

% maybe I should use file structures? If that is the case, work with queues
% and incorporate the padding logic.
n = 1;
while n < limit - windowsize
    % analyzing each window
    term = [];
    for m = 1:windowsize
        if n + m < limit
            term(m) = window(m) * signal(n+m);
        else
            return
        end
    end
    presence(n+1) = contains_voice(term);
    n = n + windowsize;
end

% --- SPECTRUM ANALYSIS -------------------------------------------------------
function [result] = contains_voice(window)
% Indicates if there is a voice
result = mean(abs(real(fft(window))));

% --- FILE IO -----------------------------------------------------------------
% TODO Export file