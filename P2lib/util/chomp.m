%% chomp: Removes trailing whitespace on strings
function [outlet] = chomp(inlet)
outlet = chomp_upper(chomp_lower(inlet));

function [outlet] = chomp_lower(inlet)
outlet = chomp_lower_loop(inlet, 1);
function [outlet] = chomp_lower_loop(inlet, index)
if isequal(length(inlet), 0)
    outlet = '';
elseif index <= length(inlet)
    if is_whitespace(inlet(index))
        outlet = chomp_lower_loop(inlet, index+1);
    else
        outlet = inlet(index:length(inlet));
    end
else
    outlet = '';
end

function [outlet] = chomp_upper(inlet)
outlet = chomp_upper_loop(inlet, length(inlet));
function [outlet] = chomp_upper_loop(inlet, index)
if isequal(length(inlet), 0)
    outlet = '';
elseif index > 0
    if is_whitespace(inlet(index))
        outlet = chomp_upper_loop(inlet, index-1);
    else
        outlet = inlet(1:index);
    end
else
    outlet = '';
end

function [result] = is_whitespace(it)
result = isequal(it, sprintf(' ')) ...
       | isequal(it, sprintf('\t')) ...
       | isequal(it, sprintf('\n')) ;
