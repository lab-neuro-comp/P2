function [out] = checkForOutputFolder(out)
% Checks if the given string is a folder. Returns the input if that's the case
% or if the directory can be created, or 0 if it is a file.
%
if isequal(exist(out, 'dir'), 7)
	%  Everything is ok!
elseif isequal(exist(out, 'file'), 2)
	out = 0;
else
	mkdir(out);
end
