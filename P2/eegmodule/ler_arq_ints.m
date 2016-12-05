function [ints_table] = ler_arq_ints(filepath)
% Reads the XLS file given in filepath and turns it into a matrix, relating
% each line to one analysis.
%
% It is expected each column represent one data to be used:
%
% 1. EDF file
% 2. Subject identification
% 3. Condition (that is, the test that is being performed, for example)
% 4. Classification (for example, their gender)
% 5. int1, the lower bound for interval cut
% 6. int2, the upper bound for interval cut
%
ints_table = [];
[numeric, txt, raw] = xlsread(filepath);
ints_table = raw;
