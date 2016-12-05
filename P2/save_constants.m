function save_constants(constants)
% Save the constants variable to its own file. It is noteworthy that this
% constants variable is a Java Hashmap obtained from the load_constants function
% that extracts its data from the constants.config file.
%
fp = fopen('constants.config', 'w');
keys = constants.keySet().toArray();

for index = 1:length(keys)
    key = keys(index);
    fprintf(fp, '%s=%s\n', key, constants.get(key));
end

fclose(fp);
