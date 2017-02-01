%% Stores data on memory
function saveData(where, what)
fp = fopen(where, 'wb');
fwrite(fp, what, 'real*4');
fclose(fp);
