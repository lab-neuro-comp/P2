function [ok] = write_signal(signal, filename)
ok = true;
fp = fopen(filename, 'w');
for it = signal
    fprintf(fp, '%.6f\n', it);
end
fclose(fp);
