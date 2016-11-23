function [outlet] = join_strings(inlet, delim)
% Join strings using a delimiter.
%
%     [outlet] = join_strings(inlet, delim)
%
% `inlet` is a cell array with many strings that will become one sole string,
% separated by the `delim` string.
%
outlet = join_strings_loop(inlet{1}, inlet, delim, 2);

function [outlet]  = join_strings_loop(outlet, inlet, delim, index)
if index <= length(inlet)
    outlet = join_strings_loop(strcat(outlet, ...
                                      delim, ...
                                      inlet{index}), ...
                               inlet, ...
                               delim, ...
                               index+1);
end
