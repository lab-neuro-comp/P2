function [newsig] = append_signal(oldsig, to_append)
% Creates a new signal containing both arrays appended.
newsig = oldsig;

for it = to_append
    if isequal(length(it), 1)
        newsig(length(newsig)+1) = it;
    else
        newsig = append_signal(newsig, it);
    end
end
