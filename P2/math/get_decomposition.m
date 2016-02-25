function [data] = get_decomposition(decomposition, bookkeeping)
% @param   decomposition  vector containing the last approximations and the details
% @param   bookkeeping    where the signals on the decomposition vector are
% @return  a cellstr containing all approximations followed by all details
approximations = {};
details = {};
data = {};

% get details
limit = length(bookkeeping)-1;
offset = bookkeeping(1);
approximations{length(approximations)+1} = decomposition(1:offset);
for n = 2:limit
    where = bookkeeping(n) + offset - 1;
    details{length(details)+1} = decomposition(offset:where);
    offset = where;
end

% get approximations
% TODO: debug this
for s = 1:(length(details)-1)
    sc = approximations{s};
    wc = details{s};
    approximation = [];
    for n = 1:length(wc)
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
