function [y] = get_yielding(handles)
bacon = cellstr(get(handles.PopupYield, 'String'));
y = bacon{get(handles.PopupYield, 'Value')};
