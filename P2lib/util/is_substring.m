function [result] = is_substring(haystack, needle)
% Checks if the `needle` string is a substring of `haystack`
%
result = ~isempty(regexp(haystack, needle));
