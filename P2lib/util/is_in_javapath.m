function [result] = is_in_javapath(filename)
% Checks if the given jarfile is in javaclasspath
result = false;
javapath = javaclasspath('-all');

for n = 1:length(javapath)
  if is_substring(javapath, filename)
    result = true;
  end
end
