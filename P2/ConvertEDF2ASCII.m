%% ConvertEDF2ASCII: Converts EDF+ files to ASCII files
function [ok] = ConvertEDF2ASCII(filename, ismultiple)
addpath([cd '\edfp2ascii']);
translate_edf2ascii(filename, ismultiple);