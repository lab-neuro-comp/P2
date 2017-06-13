function [msgHandle] = confirm_window(checkValue, operation, pop, msgHandle)

if isequal(checkValue, 1)
	if isequal(pop, 1)
		msgHandle = msgbox(operation);
	elseif isequal(pop, 0)
		close(msgHandle);
	end
end
