function protolize()
% TODO Add doc

% TODO Add edf.jar to MATLAB's javaclasspath
addpath(strcat(pwd, filesep, 'P2'));
addpath(strcat(pwd, filesep, 'P2lib'));
addpath(strcat(pwd, filesep, 'P2lib', filesep, 'math'));
addpath(strcat(pwd, filesep, 'P2lib', filesep, 'util'));
javaaddpath(strcat(pwd, filesep, 'P2lib', filesep, 'edf.jar'));
cd P2
protolize2
