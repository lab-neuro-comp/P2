function [newsig] = replace_signal(oldsig, value)
newsig = [];

for it = oldsig
    newsig(length(newsig)+1) = value;
    % yeah i'm missing it
end
