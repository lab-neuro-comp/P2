function rgpfunc(ampsrgp)

DIM = size(ampsrgp);
numA = DIM(1,2);

rgpm = mean(ampsrgp);
rgpsd = std(ampsrgp);

for j = 1:numA
	ampsrgpN(j) = (ampsrgp(j)-rgpm)/rgpsd;
end;

rgpm = mean(ampsrgpN)
rgpsd = std(ampsrgpN)
rgpvar = var(ampsrgpN)

sclmin = min(ampsrgpN)
sclmax = max(ampsrgpN)

%(Lykken et al., 1966) 
%SCL=(sclobserved-sclmin)/(sclmax-sclmin) 
SCL = (rgpm-sclmin)/(sclmax-sclmin)
% SCR=sclobserved/sclmax
SCR = rgpm /sclmax
