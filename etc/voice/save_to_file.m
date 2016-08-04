%% save_to_file: saves a variable to a file
function save_to_file(filename, data)
fp = fopen(filename, 'w');
for it = data
	fprintf(fp, '%.5f\n', it);
end	
fclose(fp);