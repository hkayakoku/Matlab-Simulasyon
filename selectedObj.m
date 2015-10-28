classdef selectedObj
    % Panelde o an seçili robot için tutulmasý gerekilen deðerler.
    properties
        circleID % Robot seçildiðinde etrafýný saran kýrmýzý circle adresini tutan deðiþken
        robotID % seçili robota ait id
        laserCircle % seçili robota ait lazer kapsama alanýný gösteren dairenin adresini tutan deðiþken
        linesObj % lazer için atanan bütün çizgilerin adresini içeren deðiþken
    end
end