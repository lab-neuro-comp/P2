function [spectrum] = calcstft(signal, window, winsize)
limit = length(signal);
spectrum = zeros(limit, winsize);

for n = 1:limit
    fa = n - floor(winsize/2); % where signal begins
    fz = n + floor(winsize/2); % where signal ends
    wa = 1; % where window begins
    wz = winsize; % where window ends
    if fa <= 0
        wa = wa + fa;
        fa = 1;
    elseif fz > limit
        wz = fz - wz;
        fz = limit;
    end

    term = signal(fa:fz) * window(wa:wz)
    spectrum(:,n) = real(fft(term));
end
