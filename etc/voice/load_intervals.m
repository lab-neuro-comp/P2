function [intervals] = load_intervals(intervals_file, limit)
% Load the intervals file
inlet = fopen(intervals_file);
intervals = [];
it = fgetl(inlet);
while ischar(it)
    intervals(str2num(it)) = 1;
    it = fgetl(inlet);
end
intervals(limit) = 0;
fclose(inlet);