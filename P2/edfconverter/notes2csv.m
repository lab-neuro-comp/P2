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

% TODO Create record pseudoannotation
% TODO Create samplingrate pseudoannotation
% TODO Create a line for each annotation
