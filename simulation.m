function varargout = simulation(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @simulation_OpeningFcn, ...
                   'gui_OutputFcn',  @simulation_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


function simulation_OpeningFcn(hObject, eventdata, handles, varargin)


% koordinat duzlemi ayarlandi
xlim manual;
ylim manual;


lx = pref.panelWeight;
ly = pref.panelHeight;

xlim([0 lx]);
ylim([0 ly]);

axis([0,lx,0,ly]);
 axis equal;

 
 % Paneldeki axe adresi alýyor.
% gca : get current axes
panel = gcf;
 

% Panelde üzerine gelinerek seçilecek robotlarý belirten daire nesnesinin
% adresini tutan global deðiþkenin ilk deðeri ve robot id'si 0 a atanýyor.
select = selectedObj;
select.circleID = 0;
select.robotID = 0;
select.laserCircle = 0;
select.linesObj = [];
setSelectedRobot(select);


handles.output = hObject;
guidata(hObject, handles);

set(gcf,'Pointer','fullcross');

% Event Listener: on mouse hover eventi ekleniyor
set(panel , 'WindowButtonMotionFcn' , @coordinate_callback)
% Event Listener: is mouse clicked eventi ekleniyor
set(panel , 'WindowButtonDownFcn' , {@ClicktoAdd_callback,handles})

function coordinate_callback (src,callbackdata)

selRobot = getSelectedRobot;
circle = selRobot.circleID;
    % Axe nesnesinde  position deðerini al.
    % Position [left bottom width height]
    position = get(gca , 'Position');
    
    pLeft = position(1);
    pBottom = position(2);
    pWidth = position(3);
    pHeight = position(4);
    
 % Paneli al.
    seltype = get(src,'CurrentPoint');
    left = seltype(1);
    bottom = seltype(2);
    
    
        if left > pLeft && left < pLeft + pWidth && bottom > pBottom && bottom < pBottom + pHeight
        
        
            
        posCurr = get(gca , 'CurrentPoint');
        
        X = posCurr(1);
        Y = posCurr(3);
        
        % Koordinat Bilgileri yazýlýyor.
        s1 = num2str( posCurr(1) );
        s2 = num2str(posCurr(3) );
        res = strcat(s1,{' x '},s2);
        set(findobj('Tag' , 'coordinate') , 'String' , res );
        
        roboID = getMeIdByCoordinate(X , Y);
%         selID = selRobot.robotID 
        
%         avail = isAvailOnPanel(X,Y);
        if roboID ~= 0 && circle == 0 && roboID ~= selRobot.robotID 
           
            set(gcf,'Pointer','hand');
            
            tmp = getRobotObj;
            s = tmp(roboID);
            
            selRobot.robotID = roboID;
            selRobot.circleID = circles(s.x, s.y , pref.circleRadius ,'facecolor' , 'none','edgecolor',[1 0 0],'linewidth',4);

            setSelectedRobot(selRobot);
            
        
        else
            
            if circle ~= 0 && roboID ~= selRobot.robotID 
                
                set(gcf,'Pointer','fullcross');
                
                delete(circle);
                selRobot.circleID = 0;
                selRobot.robotID = 0;
                setSelectedRobot(selRobot);
           
            end
        end
        
    
               
        else
            set(findobj('Tag' , 'coordinate') , 'String' , '' );
            set(gcf,'Pointer','arrow');
       
        end

function ClicktoAdd_callback (src,callbackdata,handles)
    % Axe nesnesinde  position deðerini al.
    % Position [left bottom width height]
    position = get(gca , 'Position');
    
    pLeft = position(1);
    pBottom = position(2);
    pWidth = position(3);
    pHeight = position(4);
    
    % Paneli al.
    seltype = get(src,'CurrentPoint');
    left = seltype(1);
    bottom = seltype(2);
    
    
    if left > pLeft && left < pLeft + pWidth && bottom > pBottom && bottom < pBottom + pHeight
        posCurr = get(gca , 'CurrentPoint');
        X = posCurr(1);
        Y = posCurr(3);
        
        roboID = getMeIdByCoordinate(X , Y);

        % Eðer panelde týklanýlan yerde bir robot varsa, bu robot için
        % lazer range finder datasý oluþturulacak.
        if roboID ~= 0
            

            plotLaserRangeFinderForId(roboID);

        else

            hold on
            addElementToPanel(X , Y , handles);
            hold off
        end
        
    end
    

  
function addElementToPanel(X ,Y ,handles)
    
global s;


%robot ekleniyor
s = robotInfo; % Yeni nesne olusturuldu
s.id = length(getRobotObj) + 1;      % id Atandi

s.mass = pref.robotMass;             % Kutle Atandi
s.groupID = 0;                       % Group ID 0 Atandi
s.isLeader = 0;                      % Liderlik durumu false ayarlandi.
s.centerOfMassValue = pref.groupMemberMass;             % Gruplandýðý zaman kullanýcak kütle deðeri  atandý
s.groupedMass = 0;                   % Robotlar henüz gruplanmadýklarýndan
% itme için kullanýlacak kütle deðeri 0 atandý.
s.x = X;                             % x koorinati Atandi
s.y = Y;                             % y koorinati Atandi





s.color = randomColor;
s.circleObj = circles(X,Y, pref.circleRadius , 'facecolor' , s.color);      % Robot olusturuldu ve adresi nesneye atandi



%robot ID'si daire icine yazi olarak ekleniyor.
if s.id > 9
    s.textObj = text(X-0.1,Y,int2str(s.id));           % text adresi robot nesnesine atildi
else
    s.textObj = text(X,Y,int2str(s.id));
end

set(s.textObj , 'FontSize',12);
set(s.textObj , 'FontWeight','bold');


setRobotObj([getRobotObj s]);
    
% Belirlenen koorinarlarda robot olup olmadýðýný kontrol eder. eðer robot
% varsa id sini döndürür yoksa 0 döndürür.
function roboID = getMeIdByCoordinate( X , Y )

% Foksiyon robotlar, cisimler ve hedeflerde böyle bir kordinatýn olup
% olmadýðýna bakýyor.
% Eðer Seçilen koordinat gruplanmýþ robotlarýn bulunduðu bir alana denk
% gelmiþse deðer false dönecek.

tmp = getRobotObj;
roboID = 0;

for i=1:length(tmp)
    
    s = tmp(i);

    
    topLimitX  = s.x + pref.circleRadius;
    downLimitX = s.x - pref.circleRadius;
    
    topLimitY  = s.y + pref.circleRadius;
    downLimitY = s.y - pref.circleRadius;
    
     %fprintf('kontrol edilecek X: %3f Y:%3f \n' , s.x - X , s.y-Y);
    
    if X > s.x
        resX = topLimitX - X;
    end
    
    if X <= s.x
        resX = X - downLimitX;
    end
    
    if Y > s.y
        resY = topLimitY - Y;
    end
    
    if Y <= s.y    
        resY = Y - downLimitY;
    end
    
    if resX > 0 && resY > 0 && resX < pref.circleRadius && resY < pref.circleRadius
        roboID = s.id;
        break;

    end
    
end

function deleteRobot(id)

tmp = getRobotObj;
s = tmp(id);

delete(s.circleObj);
delete(s.textObj);

% Rbot idsi ile belirlenen robot için lazer çizgilerini panelede çizer ve
% her çizginin adresini array a atar.
function plotLaserRangeFinderForId(roboID)

% Robotlar alýndý.
tmp = getRobotObj;
s = tmp(roboID);

% seçili robot bilgileri alýndý.
selRobot = getSelectedRobot;

if selRobot.laserCircle ~= 0
    delete(selRobot.laserCircle);
end
    selRobot.laserCircle = circles(s.x, s.y , laserInfo.range,'facecolor' , 'none','edgecolor',[0 0 1],'linewidth',2);
    setSelectedRobot(selRobot);


    % robot silinip tekrar yüklenecek.
    deleteRobot(s.id);
    
    % Daha önceden çizilmiþ lazer çizgileri varsa onlar alandan silinecek.
    allLines = selRobot.linesObj;
    
    for i=1:length(allLines)
        delete(allLines(i))
    end
    allLines = [];
    
    % Lazerin çevresinde bulunan robotlar bulunup array halinde deðiþkene
    % atanýyor.
%     foundedRobots = findRobotsForLazer(s.x , s.y );
    
    
    % lazer ýþýnlarý çiziliyor.
    for i=0:laserInfo.interval:360
        
        X = s.x;
        Y = s.y;
        
        % çizginin nereye kadar çizileceði. çizilecek uzunluk sensörün
        % deðerini belirleyecek.
        limitX = s.x+laserInfo.range * cosd(i);
        limitY = s.y+laserInfo.range*sind(i);
        
        % çizilen çizgi doðrultusunda hiç robot var mý ona bakýlýyor.
        robotNum = isRobotExistForSlope(X , Y , limitX, limitY , i);
        if robotNum ~= 0
        % Lazerlerin yüzeyinden sensör datasý çýkmasý için gerekli
        % ayarlamalar yapýlýyor.
            
        % gönderilen lazer ýþýný doðrultusunda bir robotun varlýðý
        % anlaþýldýktan sonra ýþýnýn sahip olduðu uzunluðun
        % belirlenmesi gerekiyor.
        % Limit X ve Limit Y deðerleri senkronize edilmeli.
        
        
        
            hold on
            plotObj = plot([X limitX] , [s.y limitY] , 'Color' , 'red' );
            hold off
            
        else
            hold on
            plotObj = plot([X limitX] , [s.y limitY] , 'Color' , 'blue' );
            hold off
        end
        
        allLines = [allLines plotObj];
        
    end
    

    
     hold on
    % robot tekrar ekleniyor
    s.circleObj = circles(X,Y, pref.circleRadius , 'facecolor' , s.color);      % Robot olusturuldu ve adresi nesneye atandi
    %robot ID'si daire icine yazi olarak ekleniyor.
    if s.id > 9
        s.textObj = text(X-0.1,Y,int2str(s.id));           % text adresi robot nesnesine atildi
    else
        s.textObj = text(X,Y,int2str(s.id));
    end
    
    set(s.textObj , 'FontSize',12);
    set(s.textObj , 'FontWeight','bold');
    hold off
    
    % robot silinip tekar yüklendiði için güncelleniyor.
    tmp(roboID) = s;
    setRobotObj(tmp);
    
    % çizgiler nesneye atanýyor.
    selRobot.linesObj = allLines;
     setSelectedRobot(selRobot);   
    
    
    
% Lazer sensörü aktif olan bir robot için, sensör içerisinde bulunan bütün 
% robotlarýn idsini dönen foksiyon.    
function arr = findRobotsForLazer(X , Y )
% Robotlar alýndý.
tmp = getRobotObj;

arr = [];
diffX=0;
diffY=0;

for i=1:length(tmp)

s = tmp(i);

if s.x >= X
    diffX = s.x - X;
end

if s.x < X
    diffX = X - s.x;
end

if s.y >= Y
    diffY = s.y - Y;
end

if s.y < Y
    diffY = Y-s.y;
end

if diffX <= laserInfo.range && diffY <= laserInfo.range && diffX+diffY ~= 0
arr = [arr s.id];
end

end

% Lazerden çýkan ýþýnýn doðrultusuna bakarak bu doðrultu üzerinde robot 
% olup olmadýðýný kontrol eden foksiyon.
function robot = isRobotExistForSlope(X , Y , limitX, limitY , slope)

robot = 0;

limitI = floor(laserInfo.range / ( pref.circleRadius * 2));

for i=1:limitI

currY = sind(slope) * pref.circleRadius * i * 2 + Y;
currX = cosd(slope) * pref.circleRadius * i * 2 + X;

roboid = getMeIdByCoordinate(currX , currY );

% circles(currX,currY, 0.1 , 'facecolor' , 'red');

if roboid ~= 0
    robot = roboid;
    break;
end

end



% Robotlarin Adreslerini tutan global degisken.
function setRobotObj(val)
global robotObj
robotObj = val;

function r = getRobotObj
global robotObj
r = robotObj;


function setSelectedRobot(val)
global selectObj
selectObj = val;

function r = getSelectedRobot
global selectObj
r = selectObj;
    

function varargout = simulation_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


