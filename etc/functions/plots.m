% amprgp=load('C:\Users\t\Documents\UnB\Pesquisa\Tratados\asciiA\cortados\dmts\75DNMTS44rgp.ascii');
% %subplot(4,1,1);
% plot(amprgp);
% title ('RGP');

% ampemg=load('C:\Users\t\Documents\UnB\Pesquisa\Tratados\asciiA\cortados\dmts\74DNMTS44EMC.ascii');
% 
% %subplot(4,1,2);
% plot(ampemg);
% title ('EMC');
% 
% 
ampecg=load('C:\Users\Ana Garcia\Documents\UnB\pesquisa\Registros\Caio.ascii');
fs=2000;
%subplot(4,2,1);
t=0:1/fs:(length(ampecg)-1)/fs;
ampecg = fwht(ampecg);
plot(ampecg);
title ('ECG');
% % 
% ampeeg=load('C:\Users\t\Documents\UnB\Pesquisa\Tratados\asciiA\cortados\dmts\74DNMTS44f4.ascii');
% 
% %subplot(4,2,2);
% plot(ampeeg);
% title ('EEG');

% x1 = ecg(512);                    % Single ecg wave
% x = repmat(x1,1,8);
% x = x + 0.1.*randn(1,length(x));  % Noisy ecg signal
% y = fwht(x);                      % Fast Walsh-Hadamard transform
% figure('Color','white');
% subplot(2,1,1);
% plot(x);
% xlabel('Sample index');
% ylabel('Amplitude');
% title('ECG Signal');
% subplot(2,1,2);
% plot(abs(y))
% xlabel('Sequency index');
% ylabel('Magnitude');
% title('WHT Coefficients');