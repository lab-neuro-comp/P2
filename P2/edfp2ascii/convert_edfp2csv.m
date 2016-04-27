%% convert_edfp2csv: Converts an EDF+ file to a 
%% CSV channels file and a TXT annotations files
function [status, cmdout] = convert_edfp2csv(inputfile)
[status, cmdout] = system(sprintf('"%s\\edfp2ascii\\edfp2notes" "%s"', ...
	                              cd, ...
	                              inputfile));
fp = fopen(generate_name(inputfile, '.txt'), 'w');
fprintf(fp, '%s\n', cmdout);
fclose(fp);

[status, cmdout] = system(sprintf('"%s\\edfp2ascii\\edfp2csv" "%s"', cd, inputfile));
fp = fopen(generate_name(inputfile, '.csv'), 'w');
fprintf(fp, '%s\n', cmdout);
fclose(fp);
