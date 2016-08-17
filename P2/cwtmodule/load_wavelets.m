function [wavelets] = load_wavelets()
constants = java.util.HashMap;
fp = fopen(strcat(cd, '/cwtmodule/wavelet_options.config'));
stuff = fgetl(fp);
while ischar(stuff)
	things = split_string(stuff, '=');
	key = things{1};
	value = things{2}; 
	constants.put(key, value);
	stuff = fgetl(fp);
end
fclose(fp);