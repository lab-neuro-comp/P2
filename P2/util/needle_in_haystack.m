function [index] = needle_in_haystack(haystack, needle)
index = 1;
while index <= length(haystack)
    if isequal(haystack{index}, needle)
        return
    else
        index = index + 1;
    end
end
