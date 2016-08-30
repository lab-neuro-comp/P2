function [filelist fslist cutlist intslist] = recordmodule_readcsv(inputfile)
filelist = { };
fslist = { };
cutlist = { };
intslist = { };

existence = exist(inputfile, 'file');
if existence == 2
    fp = fopen(inputfile, 'r');
    index = 1;
    line = fgetl(fp); % reading header
    line = fgetl(fp); % reading first table line
    while ischar(line) % reading remaining lines
        raw = split_string(line, sprintf('\t'));
        % String structure:
        % filepath    fs    cut    int1    int2
        filelist{index} = raw{1};
        fslist{index} = str2num(raw{2});
        cutlist{index} = raw{3};
        intslist{index} = [str2num(raw{4}) str2num(raw{5})];
        index = index + 1; % hehe
        line = fgetl(fp);
    end
    fclose(fp);
end
