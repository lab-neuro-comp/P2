function saveToFile(where, what)
fp = fopen(where, 'w');
fprintf(fp, '%s', what);
fclose(fp);
