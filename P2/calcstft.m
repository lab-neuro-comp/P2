function [spectrum] = calcstft(signal, window, winsize)
limit = length(signal);
spectrum = zeros(limit, winsize); % TODO: add zero paddings!
halfwin = floor(winsize/2);

for n = 1:limit
    fa = n - halfwin; % where signal begins
    fz = n-1 + halfwin; % where signal ends
    wa = 1; % where window begins
    wz = winsize; % where window ends

    if fa <= 0
        wa = wa - fa + 1;
        fa = 1;
    elseif fz > limit
        wz = wz - limit;
        fz = limit;
    end

    fprintf('%d %d %d %d\n', fa, fz, wa, wz);
    term = window(wa:wz) * signal(fa:fz);
    spectrum(:,n) = real(fft(term));
end
