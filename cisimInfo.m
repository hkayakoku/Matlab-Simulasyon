classdef cisimInfo
    % Her bir robot icin tutulacak butun degerler.
    properties
        %% Robot Info
        id  % Robotun Id'si
        x   % Robotun X koordinati
        y   % Robotun Y koordinati
        mass % Robotun Kütlesi
        
        %% Circle Info
        rectangleObj   % Robot nesnesinin adresinin tutulacagi degisken
        color       % Robotun random olarak atanan renk degeleri (R,G,B)
        textObj     % Robotun isimlendirilmesinde kullanilan text nesnesinin adresi
        
        %% Arrow Info
        lineInfo    % Kutle cekimde kullanilan cizgi nesnesinin adresi
        arrowInfo   % Ok nesnesinin adresi
        curveInfo   % Aci nesnesinin adresi
        
        %% Grav Info
        gravSlope   % Kutle cekim Algoritmasi Egim Degeri
        gravLength  % Kutle cekim Algoritmasi Uzunluk Degeri
    end
end