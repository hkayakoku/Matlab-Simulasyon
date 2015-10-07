classdef robotInfo
    % Her bir robot icin tutulacak butun degerler.
    properties
        %% Robot Info
        id  % Robotun Id'si
        x   % Robotun X koordinati
        y   % Robotun Y koordinati
        mass % Robotun Kütlesi
        
        %% Circle Info
        circleObj   % Robot nesnesinin adresinin tutulacagi degisken
        color       % Robotun random olarak atanan renk degeleri (R,G,B)
        textObj     % Robotun isimlendirilmesinde kullanilan text nesnesinin adresi
        
        %% Arrow Info
        lineInfo    % Kutle cekimde kullanilan cizgi nesnesinin adresi
        arrowInfo   % Ok nesnesinin adresi
        curveInfo   % Aci nesnesinin adresi
        
        %% Grav Info
        gravSlope   % Kutle cekim Algoritmasi Egim Degeri
        gravLength  % Kutle cekim Algoritmasi Uzunluk Degeri
        
        %% Group Info
        groupID     % Robotun Hangi Gruba ait oldugunu gosterir. Ýnitial: 0
        isLeader    % Robotun Gruba ait Liderlik Bilgisinin Olup Olmadigini Belirtir.
                    % 0 : Henüz Grup Atamasý yapýlmamýþ. idle
                    % 1 : Grubun Lideri
                    % -1 : Grup atamasý yapýlmýþ ve seçili robot grup
                    % lideri deðil.
                    
       groupedMass  % Robotlarýn gruplandýktan sonraki kütleleri
                    % 0 : initial deðer. ( robotlar gruplandýklarýný buradan
                    % anlayacak )
       %% Mass Center Info
       centerOfMassValue % robotun gruplama olduktan sonra aðýrlýk merkezi hesaplamasýnda kullanýlacak kütle deðeri
    end
end