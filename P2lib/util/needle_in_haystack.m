function [index] = needle_in_haystack(haystack, needle)
% Finds a string in a group of strings.
%
%     [index] = needle_in_haystack(haystack, needle)
%
% Return the index of the `needle` string in the `haystack` cell array of
% strings. If the string is not present, index will return as -1.
%
index = 1;
while index <= length(haystack)
    if isequal(haystack{index}, needle)
        return
    else
        index = index + 1;
    end
end

if index > length(haystack)
    index = -1;
end
