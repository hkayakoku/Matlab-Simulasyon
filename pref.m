classdef pref
    properties(Constant)
        
        %% Panel:
        panelWeight = 35 % Koordinat duzleminde X ekseninin max uzunlugu
        panelHeight = 23 % Koordinat duzleminde Y ekseninin max uzunlugu
        
        %% RobotSekli:
        circleRadius = 0.5 % Robot icin olusturulacak Þeklin Buyuklugu
        
        %% Gruplama:
        groupRadius = 3 % Robotlarin Grup Olusturabilmesini saglayacak kapsama alani
        gravLimit = 0.78 % Robotlarin birbirlerine yaklasarak sahip olabilecekleri maksimum cekim degeri
        groupCount = 3  % Grup Basi Robot Sayisi
        
        %% Robot
        robotMass = 2 * 1 % her bir robotun ilk baþta sahip olduðu kütlesi
        robotGroupedMass = -0.85 % robotlar Gruplandýktan sonraki itim kütlesi
        robotRadius = 2     % Random ekleme sýrasýnda robot için eklenmesi istenmeyen alan yarýçapý
        %% Cisim
        cisimMass = 2 * -0.12 % her bir cisimin ilk baþta sahip olduðu kütlesi
        cisimRadius = 2     % Random ekleme sýrasýnda cisim için eklenmesi istenmeyen alan yarýçapý
        %% Hedef
        hedefMass = 3 * 1             % her bir hedefin ilk baþta sahip olduðu kütlesi
        hedefMassNotGrouped  = -1.50  % Hedef Nesnesinin gruplanmamýþ robotlar için oluþturulan kütle deðeri
        hedefRadius = 2               % Random ekleme sýrasýnda hedef için eklenmesi istenmeyen alan yarýçapý
        %% Aðýrlýk Merkezi
        merkezMass = 2 * 1 % her bir aðýrlýk merkezinin ilk baþta sahip olduðu kütlesi.
        leaderMass = 3     % Aðýrlýk merkezi noktasý hesaplamada kullanýlan , lider robotun kütle deðeri
        groupMemberMass = 1 % Aðýrlýk merkezi noktasý hesaplamada kullanýlan , üye robotun kütle deðeri
        %% Çekim Sýnýrý
        distanceLimit = 3 % Robotlarýn Cisimlere Uygulayacaðý itme kuvvetinin geçerli olduðu uzaklýk
    end
end