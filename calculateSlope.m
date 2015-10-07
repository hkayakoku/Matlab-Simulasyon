% iki nokta arasindaki egimi hesaplar.
function slope = calculateSlope(X)

    f = X(1,:);
    s = X(2,:);
    
    degree = atand( ( s(2) - f(2) ) / (s(1) - f(1) ) );
    if degree < 0 
        degree = degree * -1;
    end
    slope = degree;