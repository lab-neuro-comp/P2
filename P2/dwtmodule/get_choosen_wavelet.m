function [wavelet] = get_choosen_wavelet(handles)
families = cellstr(get(handles.PopupWaveletKind, 'String'));
kinds = cellstr(get(handles.PopupWaveletVar, 'String'));
wavelet_family = families{get(handles.PopupWaveletKind, 'Value')};
wavelet_kind = kinds{get(handles.PopupWaveletVar, 'Value')};
wavelet = get_choosen_wavecode(wavelet_family, wavelet_kind);

function [wavecode] = get_choosen_wavecode(family, kind)
% Wavelet Families | Wavelets
%
% Daubechies: 'db1' or 'haar', 'db2', ... ,'db10', ... , 'db45'
% Coiflets: 'coif1', ... , 'coif5'
% Symlets: 'sym2', ... , 'sym8', ... ,'sym45'
% Fejer-Korovkin filters: 'fk4', 'fk6', 'fk8', 'fk14', 'fk22'
% Discrete Meyer: 'dmey'
% Biorthogonal: 'bior1.1', 'bior1.3', 'bior1.5'
% 				'bior2.2', 'bior2.4', 'bior2.6', 'bior2.8'
% 				'bior3.1', 'bior3.3', 'bior3.5', 'bior3.7'
% 				'bior3.9', 'bior4.4', 'bior5.5', 'bior6.8'
% Reverse Biorthogonal: 'rbio1.1', 'rbio1.3', 'rbio1.5'
% 						'rbio2.2', 'rbio2.4', 'rbio2.6', 'rbio2.8'
% 						'rbio3.1', 'rbio3.3', 'rbio3.5', 'rbio3.7'
% 						'rbio3.9', 'rbio4.4', 'rbio5.5', 'rbio6.8'

wavecode = 'haar';

switch family
case 'Daubechies'
	wavecode = kind;
case 'Coiflets'
	wavecode = ['coif' kind];
case 'Biorthogonal'
	wavecode = ['bior' kind];
case 'R Biorthogonal'
	wavecode = ['rbio' kind];
end
