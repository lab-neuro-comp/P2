
function points=calclimits(signal)

h=hist(signal,100);

figure;
subplot(3,1,1);
bar(h)
grid on
axis tight
limh=std(h)+mean(h);
k=1;
n=1;
for i=1:length(h)
    if h(i)>limh
        inth(k)=i;
        newh(i)=h(i);
        k=k+1;
    else
        newh(i)=0;
    end
    if h(i)>max(h)*0.4
        h60(i)=h(i);
        int60(n)=i;
        n=n+1;
    else
        h60(i)=0;
    end
end
subplot(3,1,2);
bar(newh)
axis tight
grid on

subplot(3,1,3);
bar(h60)
axis tight
grid on

inter=min(signal):(max(signal-min(signal)))/99:max(signal);

l1loko=inter(inth(1));
l2loko=inter(inth(k-1));
points(1,1)=l1loko;
points(1,2)=l2loko;

l160=inter(int60(1));
l260=inter(int60(n-1));
points(2,1)=l160;
points(2,2)=l260;

limed1=prctile(signal,25)-1.5*iqr(signal);
limed2=prctile(signal,75)+1.5*iqr(signal);
points(3,1)=limed1;
points(3,2)=limed2;

l1=mean(signal)-2*std(signal);
l2=mean(signal)+2*std(signal);
points(4,1)=l1;
points(4,2)=l2;
