function [down, up] = moses(inlet, boundary)
% Divides the signal into two other thresholded signals:  the `up` part is
% basically the signal above the `boundary`
down = [ ];
up = [ ];
for it = inlet
	if it >= boundary
		up(end+1) = it;
		down(end+1) = boundary;
	else
		up(end+1) = boundary;
		down(end+1) = it;
	end
end
