function [ok] = write_signal(signal, filename)
fp = fopen(filename, 'w');
for it = signal
    fprintf(fp, '%d\n', it);
end
fclose(fp);
