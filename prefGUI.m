function tmp = prefGUI(opt)

tmp = opt;

% Create figure
h.f = figure('units','pixels','position',[200,200,250,250],...
             'toolbar','none','menu','none');
% Create yes/no checkboxes
h.c(1) = uicontrol('style','checkbox','units','pixels',...
                'position',[10,220,230,15],'string','Animasyon Esnansýnda Oklar');
h.c(2) = uicontrol('style','checkbox','units','pixels',...
                'position',[10,200,230,15],'string','Grubu Dairelerle Göster');   
            
h.c(3) = uicontrol('style','checkbox','units','pixels',...
                'position',[10,180,230,15],'string','Robot Yollarýný Ýþaretle');             

% Create OK pushbutton   
h.p = uicontrol('style','pushbutton','units','pixels',...
                'position',[40,5,170,20],'string','OK',...
                'callback',@popup_callback);

% Default atamalar yapýlýyor.
set(h.c(1),'Value',opt.arrowStatus);
set(h.c(2),'Value',opt.circleVisible);        
set(h.c(3),'Value',opt.robotPath);              

 uiwait(h.f);
    % Pushbutton callback
    function popup_callback(varargin)
        
        result = cell2mat(get(h.c,'Value'));

       
        opt.arrowStatus = result(1);
        opt.circleVisible = result(2);
        opt.robotPath = result(3);

        tmp = opt;
        delete(h.f);
    end

end