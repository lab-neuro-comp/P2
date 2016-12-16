function confirm_window(checkValue, operation)

if isequal(checkValue, 1)
	h = msgbox(operation);
	waitfor(h);
	drawnow
end
