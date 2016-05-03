function save_constants(constants)
fp = fopen('constants.config', 'w');
keys = constants.keySet().toArray();

for index = 1:length(keys)
    key = keys(index);
    fprintf(fp, '%s=%s\n', key, constants.get(key));
end

fclose(fp);
