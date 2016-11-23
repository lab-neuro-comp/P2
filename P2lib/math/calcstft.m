function [spectrum] = calcstft(signal, window, winsize)
% Calculates the short time Fourier transform
%
%     [spectrum] = calcstft(signal, window, winsize)
%
% Returns a matrix where each line is the windowed Fourier transform of the
% `signal` on which the `window` is centered on the line index.
limit = length(signal);
padding = floor(winsize/2); % half window
signal = signal_with_padding(signal, padding);
spectrum = zeros(limit, winsize);

for n = 1:limit
    term = [];
    beginning = n + padding;
    for m = 1:winsize
        term(m) = window(m) * signal(beginning+m);
    end
    tfft = real(fft(term));
    for m = 1:winsize
        spectrum(n, m) = tfft(m);
    end
end

function [newsignal] = signal_with_padding(signal, padding)
limit = length(signal);
newsignal = zeros(2*padding + limit);
for n = 1:limit
    newsignal(n+padding) = signal(n);
end
