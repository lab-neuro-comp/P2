clear
close all
clc

fs=200;

ecg=load('C:\Users\t\Documents\UnB\RegistrosPiloto\Registros\edfascii\cortes\ecg\S21DMTS.ascii');
% ecg=-1*ecg1(6000:12000);
dev2_ecg=[0;diff(diff(ecg));0];
quad_dev2_ecg=dev2_ecg.^2;

level1=prctile(quad_dev2_ecg,97);
level2=prctile(ecg,90);

for i=1:length(quad_dev2_ecg)
    if quad_dev2_ecg(i)<level1
        quad_dev2_ecg(i)=0;
    end
end
r_start=0;
r_seg=0;
i_rm=1;
time_axis=0:1/fs:(length(ecg)-1)/fs;
faxis=0:fs/(length(ecg-1)):fs;

for i=1:length(quad_dev2_ecg)
    if quad_dev2_ecg(i)>0
        r_start=1;
        r_seg=r_seg+1;
    else
        if r_start==1
            delta=i-(r_seg);
            r_matrix(i_rm)=ecg(delta);
            yaxis_r(i_rm)=time_axis(delta);
            if r_matrix(i_rm)>level2
                i_rm=i_rm+1;
            end
            r_start=0;
            r_seg=0;
         end
    end
end

if r_matrix(length(r_matrix))<level2
    r_matrix=r_matrix(1:length(r_matrix)-1);
    yaxis_r=yaxis_r(1:length(yaxis_r)-1);
end

vhr=diff(yaxis_r);
figure
plot(yaxis_r,r_matrix,'or')
hold on
plot(time_axis,ecg)
grid
axis([0 max(time_axis) min(ecg) max(ecg)])


figure
plot(vhr)
axis([0 length(vhr) min(vhr) max(vhr)])

figure
faxis=0:fs/(length(vhr)-1):fs;
vhrf=abs(fft(vhr));
stem(faxis(2:length(faxis)),vhrf(2:length(vhrf)))
