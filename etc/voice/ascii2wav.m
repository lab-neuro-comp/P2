function ascii2wav(inputname)
data = [];
fp = fopen(inputname);
line = fgetl(fp);
while ischar(line)
    data(length(data)+1) = str2num(line);
    line = fgetl(fp);
end
fclose(fp);
wavwrite(data, 44100);
