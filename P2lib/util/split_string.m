function [outlet] = split_string(inlet, delim)
% Splits a string into a delimiter string.
%
%     [outlet] = split_string(inlet, delim);
%
% Creats a cell array `outlet` with the separated strings from `inlet` by
% `delim`.
outlet = tokenizeString(inlet, delim);

function [tokens] = tokenizeString(string,delimeter)
tokens = {};
while not(isempty(string))
    [tokens{end+1},string] = strtok(string,delimeter);
end
