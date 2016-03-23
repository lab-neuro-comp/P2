function [apps dtls] = wavelets_transform(signal, level, transform)
[apps dtls] = trans_loop(signal, {}, {}, 1, level, transform);

function [apps dtls] = trans_loop(signal, apps, dtls, level, limit, trans)
if level <= limit
    [app dtl] = dwt(signal, trans);
    [apps dtls] = trans_loop(app, push_cell(apps, app), push_cell(dtls, dtl), ...
                             level + 1, limit, trans);
end
