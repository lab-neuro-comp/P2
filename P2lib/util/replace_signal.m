function [newsig] = replace_signal(oldsig, value)
limit = length(oldsig);
newsig = zeros(1, limit);

for n = 1:limit
    newsig(n) = value;
end
