%% convert_csv2ascii: converts an EDF+ file to ASCII files
function [status, cmdout] = convert_csv2ascii(inlet, how)
csvfile = generate_name(inlet, '.csv');
[status, cmdout] = system(sprintf('"%s\\edfp2ascii\\%s" "%s"', ...
	                              cd, ...
	                              get_operation(how), ...
	                              csvfile));
delete(csvfile);
function [outlet] = get_operation(inlet)
if isequal(inlet, true)
	outlet = 'csv2multiple';
else
	outlet = 'csv2single';
end

