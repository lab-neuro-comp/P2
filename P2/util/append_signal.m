function [newsig] = append_signal(oldsig, to_append)
newsig = oldsig;

for it = to_append
    newsig(length(newsig)+1) = it;
end
