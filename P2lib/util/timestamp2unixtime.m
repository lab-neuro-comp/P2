function [unixtime] = timestamp2unixtime(timestamp)
% converts a string in the YYYY-MM-DDTHH:MM:SSZ format to a unix time interger.

year = ;
date = java.util.Date(year, month, day, hours, minutes, seconds);
