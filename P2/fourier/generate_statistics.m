function [text] = generate_statistics(spectrum, signalname, constants)
fs = str2num(constants.get('fs'));
deltaf1 = str2num(constants.get('deltaf1'));
deltaf2 = str2num(constants.get('deltaf2'));
thetaf1 = str2num(constants.get('thetaf1'));
thetaf2 = str2num(constants.get('thetaf2'));
alphaf1 = str2num(constants.get('alphaf1'));
alphaf2 = str2num(constants.get('alphaf2'));
betaf1 = str2num(constants.get('betaf1'));
betaf2 = str2num(constants.get('betaf2'));
gammaf1 = str2num(constants.get('gammaf1'));
gammaf2= str2num(constants.get('gammaf2'));
signalinterval = length(spectrum) / fs;
deltapot = calculate_power(spectrum, deltaf1, deltaf2, fs);
thetapot = calculate_power(spectrum, thetaf1, thetaf2, fs);
alphapot = calculate_power(spectrum, alphaf1, alphaf2, fs);
betapot = calculate_power(spectrum, betaf1, betaf2, fs);
gammapot = calculate_power(spectrum, gammaf1, gammaf2, fs);
total = 0;
for n = 1:length(spectrum)/2
    total = total + spectrum(n).^2;
end

text = {...
	['Signal: ' signalname];...
	['Interval: ' num2str(signalinterval)];...
    ['Delta: ' num2str(deltapot)];...
    ['Theta: ' num2str(thetapot)];...
    ['Alpha: ' num2str(alphapot)];...
    ['Beta: ' num2str(betapot)];...
    ['Gamma: ' num2str(gammapot)];...
	['Total: ' num2str(total)]};
