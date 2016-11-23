function [signal] = inverse_wavelets_transform(approximations, details, transform)
limit = length(approximations);
signal = anti_trans(idwt(approximations{limit}, details{limit}, transform), ...
                    approximations, details, limit-1, transform);

function [signal] = anti_trans(signal, apps, dtls, level, trans)
if level > 0
    [signal dtl] = resize_if_needed(signal, dtls{level});
    signal = anti_trans(idwt(signal, dtl, trans), apps, dtls, level-1, trans);
end

function [signal dtl] = resize_if_needed(signal, dtl)
if length(signal) > length(dtl)
    signal = signal(1:length(dtl));
elseif length(dtl) > length(signal)
    dtl = dtl(1:length(signal));
end
