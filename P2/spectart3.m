s1=load('C:\Documents and Settings\Sergio Andres Conde\Desktop\TSSTModule\Datos\s3\S3 Processados\s3f8edit.ascii');
s2=load('C:\Documents and Settings\Sergio Andres Conde\Desktop\TSSTModule\Datos\s2\S2 Processados\s2f8edit.ascii');
s3=load('C:\Documents and Settings\Sergio Andres Conde\Desktop\TSSTModule\Datos\s4\S4 Processados\s4f8edit.ascii');

color='jet';

[y,f,t,p]=spectrogram(s1,1280,50,[],256);
t1=t-100;
subplot(1,3,1)
surf(t1,f,10*log10(abs(p)),'EdgeColor','none');   
axis xy; axis tight; colormap(color); view(0,90);
xlabel('Time [s]');
ylabel('Frequency [Hz]');
c1=colorbar('SouthOutside','YTicklabel','dB');
set(c1,'fontsize',8)
xlim([0 240])

[y,f,t,p]=spectrogram(s2,1280,50,[],256);
t2=t-140;
subplot(1,3,2)
surf(t2,f,10*log10(abs(p)),'EdgeColor','none');   
axis xy; axis tight; colormap(color); view(0,90);
xlabel('Time [s]');
ylabel('Frequency [Hz]');
c2=colorbar('SouthOutside');
set(c2,'fontsize',8)
xlim([0 240])

[y,f,t,p]=spectrogram(s3,1280,50,[],256);
t3=t-60;
subplot(1,3,3)
surf(t3,f,10*log10(abs(p)),'EdgeColor','none');   
axis xy; axis tight; colormap(color); view(0,90);
xlabel('Time [s]');
ylabel('Frequency [Hz]');
c3=colorbar('SouthOutside');
set(c3,'fontsize',8)
xlim([0 240])

