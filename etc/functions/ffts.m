
i = 0:63; n=i (1:32) ;
t = n*1/(0.00025*64) ;
sq1 = square (i*2*pi*500/4000,25) ;
amp1 = fft_spectrum (sq1,64) ;
sq2 = square(i*2*pi*500/4000, 50) ;
amp2 = fft_spectrum(sq2, 64) ;
sin1 = sin(i*2*pi*500/4000) ;
amp3 = fft_spectrum (sin1, 64) ;
subplot (3,1,1) ; plot (t, amp1) ;
xlabel ('A.       Frequency in Hz - - ->') ; ylabel ('Amplitude - - ->') ;
subplot (3,1,2) ;  plot (t, amp2) ;
xlabel ( 'B.       Frequency in Hz - - ->') ; ylabel ('Amplitude - - ->') ;
subplot (3,1,3) ; plot (t, amp3) ;
xlabel ('C.          Frequency in Hz - - ->'); ylabel('Amplitude - - ->') ;
