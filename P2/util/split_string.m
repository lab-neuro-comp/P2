function [outlet] = split_string(inlet, delim)
outlet = tokenizeString(inlet, delim);

function [tokens] = tokenizeString(string,delimeter)
tokens = {};
while not(isempty(string))        
    [tokens{end+1},string] = strtok(string,delimeter);        
end
