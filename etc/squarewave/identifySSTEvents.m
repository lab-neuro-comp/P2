function identifySSTEvents(edfFile, csvFile)
% Identify the main events of a SST test execution containing a DC signal for
% marking events.
%

% Reading EDF file
recording = br.unb.biologiaanimal.edf.EDF(edfFile);
% TODO Get DC signal

% Reading CSV file
results = csv2cell(csvFile);
% TODO Extract important data from the E-prime generated table.

% Relating datasets
% TODO Finish this monster
