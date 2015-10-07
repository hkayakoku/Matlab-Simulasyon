classdef agirlikInfo
    % Gruba ait her aðýrlýk merkezi deðeri için tutulacak deðerler.
    properties
        %% Robot Info
        groupID  % merkezi hesaplanan grubun id'si
        x        % merkezin x koodinati
        y       % merkezin y koordinati
        mass    % Aðýrlýk merkezinin sahip olduðun kütle
        %% Circle Info
        circleObj   % agirlik merkezi nesnesinin adresinin tutulacagi degisken
    end
end