function [csv] = notes2csv(edf)
% Convets the annotations on the EDF file to a CSV table
%

annotations = [ ];
csv = [ ];
fileName = char(edf.getFile());

% Checking annotations existence
try
	annotations = edf.getAnnotations();
	annotations = cell(annotations);
catch exception
	return
end


% Creating record pseudoannotation
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

% Creating samplingrate pseudoannotation
samplingRate = edf.getSamplingRate();
samplingRateLine = sprintf('%s;samplingrate;%s', fileName, num2str(samplingRate));

% Creating a line for each annotation
lines = { recordLine samplingRateLine };
for m = 1:length(annotations)
	annotation = annotations{m};

	% Getting momentTime
	n = 1;
	momentString = '';
	while ~isequal(annotation(n), ' ')
		momentString = [ momentString annotation(n) ];
		n = n + 1;
	end
	momentTime = str2num(momentString);
	currentTime = momentTime + startDate;
	currentTimeString = datestr(currentTime, 'yyyy-mm-ddTHH:MM:SSZ');

	% Getting annotation itself
	note = annotation(n:end);

	% Building table line
	currentLine = sprintf('%s;%s;%s', fileName, note, currentTimeString);
	lines{end+1} = currentLine;
end

% Compiling lines into a single string
csv = freduce(@(box, it) sprintf('%s%s\n', box, it), '', lines);
