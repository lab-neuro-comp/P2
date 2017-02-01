%% Chops a signal based on a lower and upper bounds percentages
function [outlet] = subSignal(inlet, lowerbound, upperbound)
limit = length(inlet);
from = floor(lowerbound * limit);
to = floor(upperbound * limit);
outlet = inlet(from:to);
