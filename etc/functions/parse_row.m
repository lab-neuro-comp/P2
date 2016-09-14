% # About
%
% In the specified file, the header follows this convention:
%
%     Sujeito, Teste, Fragmento, DCS_Mnemônico, int1, int2,...
%
% that means we have to get only the 4th, 5th and 6th rows.
% Do not forget to convert int1 and int2 to integers.
%

function [file_name, beginning, ending] = parse_row(row)
	[sujeito, row] = strtok(row, ',');
	[teste, row] = strtok(row, ',');
	[fragmento, row] = strtok(row, ',');
	[dsc, row] = strtok(row, ',');
	[int1, row] = strtok(row, ',');
	[int2, row] = strtok(row, ',');

	file_name = dsc;
	beginning = str2num(int1);
	ending = str2num(int2);
end