%% deal_with_eeglab: performs a study with EEGLAB using the options available
function [ok] = deal_with_eeglab(inputfile, ...
                                 mustchop, ...
                                 newreference, ... 
                                 resamplerate, ...
                                 fs)
% inputfile     the path to the input file
% mustchop      must chop the signal to the desired
% newreference  the channel to be used on rerefering
% resamplerate  the new sample rate
% fs            the sampling rate used on this file

% declaring variables and starting EEGLAB
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab; 
table = csv_reader(inputfile);
ok = false;

% looping through every row
for n = 1:length(table)
    row = table{n};
    subject = chomp(row{1});
    testname = chomp(row{2});
    setfile = chomp(row{3});
    edffile = chomp(row{4});
    int1 = str2num(row{5});
    int2 = str2num(row{6});

    fprintf('---\n');
    fprintf('subject: %s\n', subject);
    fprintf('test: %s\n', testname);
    fprintf('file: %s\n', edffile);

    % TODO: add necessary if statements in Ana's part

    % % -- BEGIN ANA'S PART

    % %pop_biosig(filename, varargin);
    % EEG = pop_biosig(char(arqedf), 'blockrange', corte, 'rmeventchan', 'off');

    % [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1, 'setname', char(arqset),'overwrite', 'on');

    % %pop_select(INEEG, 'key1', value1, 'key2', value2 ...);
    % EEG = pop_select (EEG, 'nochannel', [24 25]); 

    % [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1, 'setname', char(arqset),'overwrite', 'on');

    % %pop_reref( EEG, ref, 'key', 'val' ...);
    % EEG = pop_reref( EEG, 23);

    % [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1, 'overwrite', 'on', 'savenew', char(arqset));

    % %pop_select(INEEG, 'key1', value1, 'key2', value2 ...);
    % EEG = pop_select (EEG, 'nochannel', [22]); 

    % [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1, 'setname', char(arqset),'overwrite', 'on');

    % EEG = pop_chanedit(EEG,'load', arqloc);
    % %EEG.chanlocs = readlocs( filename, 'key', 'val', ... );
    % %EEG.chanlocs = readlocs( arqloc,'filetype','chanedit');

    % EEG = pop_saveset( EEG, 'savemode','resave');
    % [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

    % EEG = eeg_checkset( EEG );

    % %EEG = pop_resample( EEG, freq);
    % %[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

    % EEG = pop_editset( EEG, 'subject', sujeito);
    % [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

    % %EEG = pop_runica( EEG, 'key', 'val' );
    % EEG = pop_runica(EEG, 'icatype', 'runica', 'dataset', 1 ,'options', {'extended' 1}, 'chanind', [1:21] ,'concatenate','off');         

    % [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

    % EEG = pop_saveset( EEG, 'savemode','resave');
    % [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

    % % -- END ANA'S PART
end

