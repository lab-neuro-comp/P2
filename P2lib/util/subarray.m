% --- creates a subarray ---
function [outlet] = subarray(inlet, beginning, ending)
outlet = [];
for where = beginning:ending
    outlet(length(outlet)+1) = inlet(where);
end
