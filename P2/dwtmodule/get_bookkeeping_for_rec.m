function [bookkeeping] = get_bookkeeping_for_rec(handles)
% extracts the bookkeeping needed for reconstruction
% from the handles for the signal decomposition and
% the current signal
inlet = handles.decomposition;
bookkeeping = [length(inlet{(length(inlet)/2)-1})];
n = length(inlet);
limit = length(inlet)/2;
while n >= limit
    bookkeeping(length(bookkeeping)+1) = length(inlet{n});
    n = n-1; % hehehe
end
bookkeeping(length(bookkeeping)+1) = length(handles.signal);
