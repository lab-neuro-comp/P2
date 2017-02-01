%% Stores data on memory
function saveData(where, what)
fp = fopen(where, 'w');
for n = 1:length(what)
	fprintf(fp, '%.3f\n', what(n));
end
fclose(fp);
