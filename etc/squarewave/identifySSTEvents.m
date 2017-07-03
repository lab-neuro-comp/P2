function [images sounds] = identifySSTEvents(edfFile, csvFile)
% Identifies the main events of a SST test execution containing a DC signal for
% marking events.
%
% Two tables are genereted from this function:
% - The first one is an array of cells containing the moment when an image
% appeared; a boolean telling if the user answered that moment correctly or
% not; and how long the user took to answer that trial.
% - The second one is an array of cells identifying the trials with sound. They
% list when the sound happenned; the direction of the arrow; if subject got
% got that trial right; and the answer latency.
%
images = [ ];
sounds = [ ];

% Reading EDF file
recording = br.unb.biologiaanimal.edf.EDF(edfFile);
% TODO Get DC signal

% Reading CSV file
results = csv2cell(csvFile);
% TODO Extract important data from the E-prime generated table.

% Relating datasets
% TODO Finish this monster
