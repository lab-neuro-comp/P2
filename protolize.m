function protolize()
% TODO Add doc

protopath = which('protolize.m');
protopath = protopath(1:end-length('protolize.m'));

addpath(protopath);
addpath(strcat(protopath, 'P2'));
addpath(strcat(protopath, 'P2lib'));
addpath(strcat(protopath, 'P2lib', filesep, 'biomed'));
addpath(strcat(protopath, 'P2lib', filesep, 'functional'));
addpath(strcat(protopath, 'P2lib', filesep, 'math'));
addpath(strcat(protopath, 'P2lib', filesep, 'util'));
javaaddpath(strcat(protopath, 'P2lib', filesep, 'edf.jar'));

cd (strcat(protopath, 'P2'));
protolize2
