classdef pref
    properties(Constant)
        
        %% Panel:
        panelWeight = 35 % Koordinat duzleminde X ekseninin max uzunlugu
        panelHeight = 22 % Koordinat duzleminde Y ekseninin max uzunlugu
        
        %% RobotSekli:
        circleRadius = 0.5 % Robot icin olusturulacak Þeklin Buyuklugu
        
        %% Gruplama:
        groupRadius = 3 % Robotlarin Grup Olusturabilmesini saglayacak kapsama alani
        gravLimit = 0.78 % Robotlarin birbirlerine yaklasarak sahip olabilecekleri maksimum cekim degeri
        groupCount = 3  % Grup Basi Robot Sayisia
        
        %% Robot
        robotMass = 2 * 1 % her bir robotun ilk ba?ta sahip oldu?u k?tlesi
        robotGroupedMass = -0.85 % robotlar Grupland?ktan sonraki itim k?tlesi
        robotRadius = 2     % Random ekleme s?ras?nda robot i?in eklenmesi istenmeyen alan yar??ap?
        %% Cisim
        cisimMass = 2 * -0.12 % her bir cisimin ilk ba?ta sahip oldu?u k?tlesi
        cisimRadius = 2     % Random ekleme s?ras?nda cisim i?in eklenmesi istenmeyen alan yar??ap?
        %% Hedef
        hedefMass = 3 * 1             % her bir hedefin ilk ba?ta sahip oldu?u k?tlesi
        hedefMassNotGrouped  = -1.50  % Hedef Nesnesinin gruplanmam?? robotlar i?in olu?turulan k?tle de?eri
        hedefRadius = 2               % Random ekleme s?ras?nda hedef i?in eklenmesi istenmeyen alan yar??ap?
        %% A??rl?k Merkezi
        merkezMass = 2 * 1 % her bir a??rl?k merkezinin ilk ba?ta sahip oldu?u k?tlesi.
        leaderMass = 3     % A??rl?k merkezi noktas? hesaplamada kullan?lan , lider robotun k?tle de?eri
        groupMemberMass = 1 % A??rl?k merkezi noktas? hesaplamada kullan?lan , ?ye robotun k?tle de?eri
        %% ?ekim S?n?r?
        distanceLimit = 3 % Robotlar?n Cisimlere Uygulayaca?? itme kuvvetinin ge?erli oldu?u uzakl?k
    end
end