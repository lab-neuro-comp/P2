function [csv] = notes2csv(edf)
% Convets the annotations on the EDF file to a CSV table
%

annotations = [ ];
csv = [ ];

% Checking annotations existence
try
	annotations = edf.getAnnotations();
catch exception
	return
end

% Temporarily generating annotations format
csv = freduce(@(box, it) sprintf('%s- %s\n', box, it), '', cell(annotations));
fileName = char(edf.getFile());

% TODO Create record pseudoannotation
startDate = edf.getHeader().get('startdate');
startTime = edf.getHeader().get('starttime');
dateRaw = split_string(char(startDate), '.');
timeRaw = split_string(char(startTime), '.');
timestamp = sprintf('20%s-%s-%s %s:%s:%s', ...
                    dateRaw{3}, dateRaw{2}, dateRaw{1}, ...
					timeRaw{1}, timeRaw{2}, timeRaw{3});
startDate = datenum(timestamp, 'yyyy-mm-dd HH:MM:SS');
timestamp = datestr(startDate, 'yyyy-mm-ddTHH:MM:SSZ');
recordLine = sprintf('%s;record;%s', fileName, timestamp);
fprintf('notes2csv! %s\n', recordLine);

% TODO Create samplingrate pseudoannotation
samplingRate = edf.getSamplingRate();
samplingRateLine = sprintf('%s;samplingrate;%s', fileName, num2str(samplingRate));
fprintf('notes2csv! %s\n', samplingRateLine);

% TODO Create a line for each annotation
