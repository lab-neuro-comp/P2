function emgfilt(emgfile, d, fc, fs )

if exist (emgfile)==2
    
   x=load(emgfile);
   
    % Design IIR filter that meets these specification: 

    % Passband cutoff frequencies 
    if (exist('fcp') ~= 1)  fcp=40; end;  
    % Stopband cutoff frequencies 
    if (exist('fcs') ~= 1)  fcs=120; end;
    % Sampling rate 
    if (exist('fs') ~= 1)  fs=2000; end;
    % Attenuations 
    if (exist('Ap') ~= 1)  Ap=3;  end;
    if (exist('As') ~= 1)  As=60;  end;

    Wp=[fcp/(fs/2)]; 
    Ws=[fcs/(fs/2)]; 

    % Filter order 
    [N, Wn] = buttord(Wp, Ws, Ap, As); 
    % Filter coefficients 

    [B,A] = butter(N,Wn,'low') 

    % Filter coefficients 
    % butter-worth filter of xth order, d=duration, cut-off frequency of fc Hz, fs=sample rate 
    
%     %x=4
%     Wn=d*fc/fs
%     [B,A] = butter(x,Wn,'low') 

    y=filter(B,A,x);  %Filters the variable X using parameters b and a. (note: b and a are produced by the function butter) 
    
    %y=x;
    
    %y=detrend(y);     %Removes any linear trend from the input matrix X. 
    
    t = [1/fs:1/fs:d];
    %y=cumtrapz(t,y);   %Integrates the input variable X with respect to t 
  
    %y=abs(y)              %Y = |X|

    subplot(2,1,1) 
    plot(x)
    title('original')
    subplot(2,1,2) 
    plot(y)
    title('filtrado')    
    
    [pathstr, filename, ext, versn] = fileparts(emgfile);
    
    emgfilefilt = strcat(pathstr, '\filtrados\', filename, 'f', ext);
    
    save (emgfilefilt, 'y', '-ASCII');
else
    disp('Arquivo inválido.');
    
end;