function set_scales_for_wavelets(hObject, handles, wavetype)

fs = str2num(handles.constants.get('fs'));

if get(handles.RadioManual, 'Value')
	fmin = str2num(handles.constants.get('deltaf1'));
	maxscale = centfrq(wavetype)/((1/fs)*fmin);
	minscale = centfrq(wavetype)/0.5;
	set(handles.EditMin, 'String', sprintf('%5.2f', minscale));
	set(handles.EditMax, 'String', sprintf('%5.2f', maxscale));
elseif get(handles.RadioPredet, 'Value')
	if get(handles.RadioDelta, 'Value')
		fmin = str2num(handles.constants.get('deltaf1'));
		fmax = str2num(handles.constants.get('deltaf2'));
	elseif get(handles.RadioTheta, 'Value')
		fmin = str2num(handles.constants.get('thetaf1'));
		fmax = str2num(handles.constants.get('thetaf2'));
	elseif get(handles.RadioAlpha, 'Value')
		fmin = str2num(handles.constants.get('alphaf1'));
		fmax = str2num(handles.constants.get('alphaf2'));
	elseif get(handles.RadioBeta, 'Value')
		fmin = str2num(handles.constants.get('betaf1'));
		fmax = str2num(handles.constants.get('betaf2'));
	elseif get(handles.RadioGamma, 'Value')
		fmin = str2num(handles.constants.get('gammaf1'));
		fmax = str2num(handles.constants.get('gammaf2'));
	end
	maxscale = centfrq(wavetype)/((1/fs)*fmin);
	minscale = centfrq(wavetype)/((1/fs)*fmax);
	set(handles.EditMin, 'String', sprintf('%5.2f', minscale));
	set(handles.EditMax, 'String', sprintf('%5.2f', maxscale));
end
