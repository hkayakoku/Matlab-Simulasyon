% Fonksiyon iki nokta arasýndaki eðim ve uzaklýk deðerlerini bulur ve bunu
% bileþenlerine ayýrýr.

function [gravX  , gravY] = calculateGravValues(X)
% ilk deðerler alýndý.
f = X(1,:);
% ikinci deðerler alýndý.
s = X(2,:);

% index(1) X koordinatý
% index(2) Y koordinatý
% index(3) Kütle deðerleri

% Hesaplamalar yapiliyor.



% 1 Kutle cekim Formulu uygulaniyor. (M1 * M2 ) / d^2
gravForce = ( f(3) * s(3) )/(pdist([f(1) , f(2) ; s(1) , s(2) ],'euclidean').^2);

% Ýki Nokta Arasindaki Egim Hesaplaniyor.
slope = calculateSlope(X);
area = determinePointArea(X);

if area == 1 factorX = 1;factorY = 1; end
if area == 2 factorX = -1; factorY = 1; end
if area == 3 factorX = -1; factorY = -1; end
if area == 4 factorX = 1; factorY = -1; end

gravX = (gravForce * cosd(slope) * factorX);
gravY = (gravForce * sind(slope) * factorY);

    