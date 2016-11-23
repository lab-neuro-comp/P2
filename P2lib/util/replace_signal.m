function [newsig] = replace_signal(oldsig, value)
% Creates a new signal with a sole value.
%
%     [newsig] = replace_signal(oldsig, value);
%
% Returns a new signal of the same length of `oldsig` but full of `value`.
%
limit = length(oldsig);
newsig = zeros(1, limit);

for n = 1:limit
    newsig(n) = value;
end
