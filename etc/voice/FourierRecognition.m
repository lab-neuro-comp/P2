function FourierRecognition(testcase, density, windowsize)
% Recognizes where the voice in a WAV file begins based on
% the chosen density and window size using the 
% windowed Fourier transform
[recording, samplerate, nbits] = wavread(testcase);
limit = length(recording);
outlet = recognize_voice(recording, hamming(windowsize), windowsize);
figure;
plot(1:length(outlet), outlet);
% Note: the usable voice frequency ranges from 300Hz to 3400Hz, approximately

% --- WINDOWED FOURIER TRANSFORM ----------------------------------------------
function [presence] = recognize_voice(signal, window, windowsize)
% Recognizes if there is a voice signal for each window using
limit = length(signal);
presence = [];

% maybe I should use file structures?
% if that is the case, work with queues and incorporate the padding logic
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
    tfft = real(fft(term));
    presence(n+1) = contains_voice(tfft);
    n = n + windowsize;
end

% --- SPECTRUM ANALYSIS -------------------------------------------------------
function [result] = contains_voice(window)
% Indicates if there is a voice
result = mean(window);

% --- FILE IO -----------------------------------------------------------------
% TODO Export file