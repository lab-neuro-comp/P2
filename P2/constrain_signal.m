function [newsig] = constrain_signal(oldsig, ceiling, floor)
newsig = [];

for val = oldsig
    it = val;
    if val > ceiling
        it = ceiling;
    elseif val < ceiling
        it = floor;
    else
        it = val;
    end
    newsig(length(newsig)+1) = it;
end
