classdef selectedObj
    % Panelde o an seçili robot için tutulmasý gerekilen deðerler.
    properties
        circleID % Robot seçildiðinde etrafýný saran kýrmýzý circle adresini tutan deðiþken
        robotID % seçili robota ait id
        laserCircle % seçili robota ait lazer kapsama alanýný gösteren dairenin adresini tutan deðiþken
        linesObj % lazer için atanan bütün çizgilerin adresini içeren deðiþken
        isControlButtonSet % Panelde CTRL tuþuna o an basýlý tutulup tutulmadýðýný kontrol eden deðiþken.
        isMouseDown % Panelde CTRL+mouse sürüklemesi eventi yapýlabilmesi için tutulmasý gereken mouse event deðiþkeni
        allLength % Sensörden gelen tüm ýþýnlarýn uzunluklarýnýn depolandýðý deðiþken
        allSlope % Sensörden gelen tüm ýþýnlarýn açýlarýnýn depolandýðý deðiken
        figureWindow % Seçili Robot için oluþturulan figure penceresinin adresini tutan deðiþken
    end
end