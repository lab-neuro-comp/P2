
function cjan=corrjan(s1,s2,jan)

x(:,1)=s1;
x(:,2)=s2;
k=1;
n=1;

for i=jan:jan:length(s1)
    corrmx=corrcoef(x(k:i,:));
    k=k+jan;
    cjan(n)=corrmx(1,2);
    n=n+1;
end

figure
plot(cjan)