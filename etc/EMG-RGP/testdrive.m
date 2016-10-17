%% testdrive: Fast tests for separateGSR
function testdrive(sourcefolder)
% Fast tests for separateGSR

% Get EDF files from source folder
directory = dir(sourcefolder);
allfiles = {};
for n = 1:length(directory)
    allfiles{end+1} = directory(n).name;
end
files = { };
for n = 1:length(allfiles)
    filepath = strcat(sourcefolder, allfiles{n});
    if findstr(filepath, '.edf')
        files{end+1} = filepath;
    end
end

% Applying separateGSR function'
fprintf('-- Files:\n');
for n = 1:length(files)
    fprintf('--- # %s\n', files{n});
    separateGSR(files{n})
end
