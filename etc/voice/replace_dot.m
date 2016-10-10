function [timestring] = replace_dot(time)

temp = {};
timestring = [];

temp = num2str(time);
temp = split_string(temp, '.');
timestring = char(strcat(temp(1), ',', temp(2)));
