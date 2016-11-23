function [newsig] = constrain_signal(oldsig, upperbound, lowerbound)
newsig = [];

for val = oldsig
    it = val;
    if val > upperbound
        it = upperbound;
    elseif val < lowerbound
        it = lowerbound;
    end
    newsig(length(newsig)+1) = it;
end
