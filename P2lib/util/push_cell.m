%% Adds something to the end of a cell array
function [stuff] = push_cell(stuff, item)
stuff{end+1} = item;
