% --- add something to the end of a cell array ---
function [stuff] = push_cell(stuff, item)
stuff{length(stuff)+1} = item;
