function [data] = get_decomposition(decomposition, bookkeeping)
% data = old_get_decomposition(decomposition, bookkeeping);

approximations = {};
details = {};
data = {};

% get details
limit = length(bookkeeping)-1;
offset = bookkeeping(1);
for n = 2:limit-1
    where = bookkeeping(n) + offset;
    details{length(details)+1} = decomposition(offset:where);
    offset = where;
end

% get approximations
% TODO: get approximations

% wrap up
for approximation = approximations
    data{length(data)+1} = approximation;
end
for detail = invert_cell_array(details);
    data{length(data)+1} = detail;
end

% ------------------------------------------------------------------------------
function [approximation] = old_get_decomposition(decomposition, bookkeeping)
limit = length(bookkeeping)-1;
approximation = {};
offset = 1;

for index = 2:limit
    where = offset + bookkeeping(index);
    chop = decomposition(offset:where);
    approximation{length(approximation)+1} = chop;
    offset = where;
end
