function set_scales_for_wavelets(hObject, handles, wavetype, fmin)

fs = str2num(handles.constants.get('fs'));
maxscale = centfrq(wavetype)/((1/fs)*fmin);
minscale = centfrq(wavetype)/0.5;
set(handles.EditMin, 'String', sprintf('%5.2f',minscale));
set(handles.EditMax, 'String', sprintf('%5.2f',maxscale));