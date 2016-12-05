function [ints_table] = ler_arq_ints(filepath)
% Reads the XLS file given in filepath and turns it into a cell array, relating
% each line to one analysis.
%
% It is expected each column represent one data to be used:
%
% 1. EDF file
% 2. Subject identification
% 3. Condition (that is, the test that is being performed, for example)
% 4. Classification (for example, their gender)
% 5. int1, the lower bound for interval cut
% 6. int2, the upper bound for interval cut
%
[numeric, txt, raw] = xlsread(filepath);
ints_table = { };
[y x] = size(raw);
y = 1;
for m = 2:length(raw)
	if ~isequal(class(raw{m, 1}), class(NaN))
		% Include stuff to ints_table
		for n = 1:x
			ints_table{y, n} = raw{m, n};
		end
		y = y+1;
	end
end