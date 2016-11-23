function [result] = iff(condition, trueclause, falseclause)
result = falseclause;
if condition
    result = trueclause;
end
