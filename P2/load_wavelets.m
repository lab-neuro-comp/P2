%% load_wavelets: get the names stored in the waveletopts.config file
function [wavelets] = load_wavelets()
wavelets = java.util.HashMap;
fp = fopen(strcat(cd, '/waveletsopts.config'));
stuff = fgetl(fp);
while ischar(stuff)
	things = split_string(stuff, '=');
	key = things{1};
	value = things{2}; 
	wavelets.put(key, value);
	stuff = fgetl(fp);
end
fclose(fp);