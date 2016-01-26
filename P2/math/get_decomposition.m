function [data] = get_decomposition(decomposition, bookkeeping)
approximations = {};
details = {};
data = {};

% get details
limit = length(bookkeeping)-1;
offset = bookkeeping(1);
approximations{length(approximations)+1} = decomposition(1:offset);
for n = 2:limit
    where = bookkeeping(n) + offset;
    details{length(details)+1} = decomposition(offset:where);
    offset = where;
end

% get approximations
% TODO: debug this
limit = length(details);
for s = 1:limit
    sc = approximations{s};
    wc = details{s};
    approximation = [];
    for n = min(length(sc), length(wc))
        approximation(length(approximation)+1) = (sc(n)-wc(n))/2;
        approximation(length(approximation)+1) = (sc(n)+wc(n))/2;
    end
    approximations{length(approximations)+1} = approximation;
end

% wrap up
limit = length(approximations);
for d = 1:limit
    data{length(data)+1} = approximations{limit-d+1};
end
limit = length(details);
for d = 1:limit
    data{length(data)+1} = details{limit-d+1};
end
length(approximations)
length(details)
length(data)

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
