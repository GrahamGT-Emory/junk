function [Xr,Hinv] = LSoracle(Xte,Yte)

Xn = normal(Xte);
Hinv = Xn'*pinv(Yte)';
Xr = (Hinv*Yte')'; 

end
