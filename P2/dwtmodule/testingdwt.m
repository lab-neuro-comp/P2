% --- Testing the dwt transform ---
function testingdwt()
global fs
addpath('./dal');
addpath('./util');
addpath('./dwtmodule');
fs = 128;
trans = 'haar';
[signal name] = getfile();
[apps dtls] = wavelets_transform(signal, 3, trans);
child = inverse_wavelets_transform(apps, dtls, trans);
standard_plot(child);
