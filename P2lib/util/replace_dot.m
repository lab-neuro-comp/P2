function [timestring] = replace_dot(time)
% TODO Add documentation

temp = {};
timestring = [];

temp = num2str(time);
temp = split_string(temp, '.');
if length(temp) == 1
	temp{2} = '0';
end
timestring = char(strcat(temp{1}, ',', temp{2}));
