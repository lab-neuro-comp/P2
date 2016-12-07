function outlet = change_extension(inlet, ext)
% Changes the extension of the inlet string to the given ext extension.
% Example:
%
%     outlet = change_extension('README.md', 'txt')
%
% In this case, the outlet variable will be 'README.txt'. 飴
%
root_index = find_root_index(inlet, length(inlet));
outlet = strcat(inlet(1:root_index), ext);

function root = find_root_index(inlet, n)
if isequal(inlet(n), '.')
    root = n;
else
    root = find_root_index(inlet, n-1);
end
