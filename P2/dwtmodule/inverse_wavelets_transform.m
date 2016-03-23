function [signal] = inverse_wavelets_transform(approximations, details, transform)
limit = length(approximations);
signal = anti_trans(idwt(approximations{limit}, details{limit}, transform), ...
                    approximations, details, limit-1, transform);

function [signal] = anti_trans(signal, apps, dtls, level, trans)
% TODO: fix this loop. the signal and the current detail must have the same size
if level > 0
    signal = anti_trans(idwt(signal, dtls{level}, trans), apps, dtls, level-1, trans);
end
