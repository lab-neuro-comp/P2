function saveCsv(where, horizontalTags, verticalTags, data)
% Creates a CSV file with tags for your data.
%
fp = fopen(where, 'w');

% Building first line
fprintf(fp, ' ');
for m = 1:length(horizontalTags)
	fprintf(fp, ';\t%s', horizontalTags{m});
end
fprintf(fp, '\n');

% Building following lines
horizontalLimit = length(horizontalTags);
verticalLimit = length(verticalTags);
for n = 1:verticalLimit
	fprintf(fp, '%s', verticalTags{n});
	for m = 1:horizontalLimit
		fprintf(fp, ';\t%s', brazilian_format(data{m, n}));
	end
	fprintf(fp, '\n');
end

fclose(fp);
