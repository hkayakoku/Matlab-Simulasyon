classdef hedefInfo
    % Her bir Hedefin icin tutulacak butun degerler.
    properties
        %% Hedefin Info
        id  % Hedefin Id'si
        x   % Hedefin X koordinati
        y   % Hedefin Y koordinati
        mass % Hedefin Kütlesi
       
        
        %% Circle Info
        rectangleObj   % Hedef nesnesinin adresinin tutulacagi degisken
        textObj     % Robotun isimlendirilmesinde kullanilan text nesnesinin adresi
      
    end
end