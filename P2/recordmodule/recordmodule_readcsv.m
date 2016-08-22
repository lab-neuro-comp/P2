function [filelist fslist intslist] = recordmodule_readcsv(inputfile)
filelist = { };
fslist = { };
intslist = { };

existence = exist(inputfile, 'file');
if existence == 2
    fp = fopen(inputfile, 'r');
    index = 1;
    line = fgetl(fp); % reading header
    line = fgetl(fp); % reading first line
    while ischar(line) % reading remaining lines
        raw = split_string(line, sprintf('\t'));
        filelist{index} = raw(1);
        fslist{index} = str2num(raw(2));
        intslist{index} = [str2num(raw(3)) str2num(raw(4))];
        index = index + 1; % hehe
        line = fgetl(fp);
    end

    fclose(fp);
end
