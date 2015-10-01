function savefigure(xdata,ydata,color,xlim,ylim,xname,yname,figtitle)
savefigconfirm
plot(xdata,ydata,color)
axis([xlim ylim])
grid on
xlabel(xname)
ylabel(yname)
title(figtitle)

