function ascii2wav(source)
data = load(source);
wavwrite(data, 44100, strcat(source, '.wav'));
