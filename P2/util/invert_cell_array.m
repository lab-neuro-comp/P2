function [newcell] = invert_cell_array(oldcell)
newcell = {};
limit = length(oldcell);

for n = 1:limit
    newcell{n} = oldcell{limit-n+1};
end
