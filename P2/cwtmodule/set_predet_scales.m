function set_predet_scales(hObject, handles, wavetype, fmin, fmax)

fs = str2num(handles.constants.get('fs'));
maxscale = centfrq(wavetype)/((1/fs)*fmin);
minscale = centfrq(wavetype)/((1/fs)*fmax);
set(handles.EditMin, 'String', sprintf('%5.2f',minscale));
set(handles.EditMax, 'String', sprintf('%5.2f',maxscale));
set(handles.EditInt, 'String', '1');