function how_many_plots(handles, many)
% Changes the number of plots and scale them to fit in their panel.
% handles handles to GUIDE's structs
% many    how many plots we want
plots = handles.plots;

for p = plots % disable every plot
    set(p, 'Visible', 'off');
end

if isequal(many, 1) % enable and scale just the necessary number
    set(plots(1), 'Visible', 'on');
    set(plots(1), 'Position', [0.1 0.1 0.8 0.8]);
else
    position = get(handles.PanelPlot, 'Position');
    xposition = position(1);
    yposition = position(2);
    panelwidth = position(3);
    panelheight = position(4);

    moo = 0.1;
    width = (1-moo) * panelwidth;
    height = (1-2*moo) * panelheight * (1-moo) / many;
    padding = moo * (1-2*moo) * panelheight / (many-1);
    xmargin = moo * panelwidth;
    ymargin = moo * panelheight;

    x = xmargin;
    for index = 1:many
        y = ymargin + (many-index) * (height+padding);
        p = plots(index);

        set(p, 'Visible', 'on');
        set(p, 'FontSize', 8);
        set(p, 'Position', [x y width height]);
    end
end
