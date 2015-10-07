% Foksiyon, Verilen iki noktanin birbirlerine gore koordinat duzlemine
% hangi alanda oldugunu hesaplar.
function area = determinePointArea(X)
    
    f = X(1,:);
    s = X(2,:);
    
    s(1) = 0 - f(1) + s(1);
    s(2) = 0 - f(2) + s(2);
  
    if s(1) >  0 && s(2) >= 0  
        area = 1;
    end
    if s(1) <= 0 && s(2) > 0
        area = 2;
    end
    if s(1) <  0 && s(2) <= 0
        area = 3;
    end
    if s(1) >= 0 && s(2) < 0
        area = 4;
    end