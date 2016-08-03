function ascii2wav(source)
outlet = [];
fp = fopen(source, 'r');
line = fgetl(fp);
n = 1;
while ischar(line)
    outlet(n) = str2num(line);
    line = fgetl(fp);
    n = n + 1;
end
fclose(fp);
wavwrite(outlet, 44100, strcat(source, '.wav'));
