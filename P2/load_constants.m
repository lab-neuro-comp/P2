%% load_constants: get the values stored in the constants.config file
function [constants] = load_constants()
constants = java.util.HashMap;
fp = fopen(strcat(cd, '/constants.config'));
stuff = fgetl(fp);
while ischar(stuff)
	things = split_string(stuff, '=');
	key = things{1};
	value = things{2}; 
	constants.put(key, value);
	stuff = fgetl(fp);
end
fclose(fp);