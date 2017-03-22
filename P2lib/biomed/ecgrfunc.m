function [vhr, vhrf] = ecgrfunc(ecg, fs)

dev2_ecg = [0;diff(diff(ecg));0];
quad_dev2_ecg = dev2_ecg.^2;

level1 = prctile(quad_dev2_ecg, 97);
level2 = prctile(ecg, 90);

for i = 1:length(quad_dev2_ecg)
    if quad_dev2_ecg(i) < level1
        quad_dev2_ecg(i) = 0;
    end
end

r_start = 0;
r_seg = 0;
i_rm = 1;
time_axis = 0:1/fs:(length(ecg)-1)/fs;
faxis = 0:fs/(length(ecg-1)):fs;

for i = 1:length(quad_dev2_ecg)
    if quad_dev2_ecg(i) > 0
        r_start = 1;
        r_seg = r_seg+1;
    elseif r_start == 1
        delta = i-(r_seg);
        r_matrix(i_rm) = ecg(delta);
        yaxis_r(i_rm) = time_axis(delta);
        if r_matrix(i_rm) > level2
            i_rm = i_rm+1;
        end
        r_start = 0;
        r_seg = 0;
    end
end

if r_matrix(length(r_matrix)) < level2
    r_matrix = r_matrix(1:length(r_matrix)-1);
    yaxis_r = yaxis_r(1:length(yaxis_r)-1);
end

vhr=diff(yaxis_r);
vhrf=abs(fft(vhr));
