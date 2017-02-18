function [ints_table] = ler_arq_ints(filepath)
% Reads the XLS file given in filepath and turns it into a cell array, relating
% each line to one analysis.
%
% It is expected each column represent one data to be used:
%
% 1. Subject
% 2. Test
% 3. Fragment
% 4. Subject's Initials
% 5. int1, the lower bound for interval cut
% 6. int2, the upper bound for interval cut
% 7. Sampling Rate
% 8. Session
% 9. EDF file
%

[numeric, txt, raw] = xlsread(filepath);
ints_table = { };
[height x] = size(raw);
y = 1;
for m = 2:height
	if ~isequal(class(raw{m, 1}), class(NaN))
		% Include stuff to ints_table
		for n = 1:x
			ints_table{y, n} = raw{m, n};
		end
		y = y+1;
	end
end