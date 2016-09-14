clear
close all
clc

fs=256;

localorigem = 'C:\Users\t\Documents\UnB\RegistrosPiloto\Registros\cortes\';
arquivo='S21DMTSECG.ascii';

arquivo = strcat(localorigem,arquivo); 

ecg1=load(arquivo);
%ecg1=load('sergio(1).ascii');
ecg=-1.*ecg1(6000:7100)/length(ecg1);
dev2_ecg=[0;0;diff(diff(ecg))];
quad_dev2_ecg=dev2_ecg.^2;
level=prctile(quad_dev2_ecg,99);

for i=1:length(quad_dev2_ecg)
    if quad_dev2_ecg(i)<level
        quad_dev2_ecg(i)=0;
    end
end
r_start=0;
r_seg=0;
iy_rm=1;

for i=1:length(quad_dev2_ecg)
    if quad_dev2_ecg(i)>0
        r_start=1;
        r_seg=r_seg+1;
    else
        if r_start==1
            delta=i-(round(r_seg+1))
            r_matrix(delta)=ecg(delta);
            r_start=0;
            r_seg=0;
            
        end
    end
end 
    
    
    
time_axis=0:1/fs:(length(ecg)-1)/fs;
subplot(2,1,1)
plot(r_matrix,'or')
%axis([0 time_axis(length(time_axis)) min(ecg) max(ecg)])
hold
plot(ecg)
grid
%axis([0 time_axis(length(time_axis)) min(ecg) max(ecg)])
%subplot(3,1,2)

subplot(2,1,2)
stem(r_matrix)
grid
axis([0 length(quad_dev2_ecg) 0 max(ecg)])

%axis([0 time_axis(length(time_axis)) min(ecg) max(ecg)])
