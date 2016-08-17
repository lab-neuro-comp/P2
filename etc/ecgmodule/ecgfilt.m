function ecgfilt(ecgfile, fcp, fcs, fs, Ap, As )

if exist (ecgfile)==2

   x=load(ecgfile);

    % Design IIR filter that meets these specification:

    % Passband cutoff frequencies
    if (exist('fcp') ~= 1);  fcp=40; end;
    % Stopband cutoff frequencies
    if (exist('fcs') ~= 1);  fcs=150; end;
    % Sampling rate
    if (exist('fs') ~= 1);  fs=2000; end;
    % Attenuations
    if (exist('Ap') ~= 1);  Ap=3;  end;
    if (exist('As') ~= 1);  As=80;  end;

    Wp=[fcp/(fs/2)];
    Ws=[fcs/(fs/2)];

    % Filter order
    [N, Wn] = buttord(Wp, Ws, Ap, As);
    % Filter coefficients
    [B,A] = butter(N,Wn,'low')

    y=filter(B,A,x)

    subplot(2,1,1)
    plot(x)
    title('original')
    subplot(2,1,2)
    plot(y)
    title('filtrado')

    [pathstr, filename, ext, versn] = fileparts(ecgfile);

    ecgfilefilt = strcat(pathstr, '\', filename, 'f', ext);

    save (ecgfilefilt, 'y', '-ASCII');
else
    disp('Arquivo inv�lido.');

end;
