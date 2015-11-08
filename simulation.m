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
select.isControlButtonSet = false;
select.isMouseDown = false;
select.allLength = [];
select.allSlope = [];
select.figureWindow = 0;
setSelectedRobot(select);


handles.output = hObject;
guidata(hObject, handles);

set(gcf,'Pointer','fullcross');

% Event Listener: on mouse hover eventi ekleniyor
set(panel , 'WindowButtonMotionFcn' , @coordinate_callback)
% Event Listener: is mouse clicked eventi ekleniyor
set(panel , 'WindowButtonDownFcn' , {@ClicktoAdd_callback,handles})

set(panel , 'WindowButtonUpFcn' , @mouseDown )
%Event Listener: ScrollDown eventi Ekleniyor.
set(panel , 'WindowScrollWheelFcn' , @panelZoom )
%Event Listener: 
set(panel , 'WindowKeyPressFcn' , @panelNavigation )

set(panel , 'WindowKeyReleaseFcn' , @keyRelease )

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



            % ctrl ye basýlmýþsa be mousedown ise
            if selRobot.isControlButtonSet && selRobot.isMouseDown
                
%                 fprintf('tasý dayý\n');
                
                % Robot Objesi Taþýnacak:
                
                tmp = getRobotObj;
                % þu an seçili bulunan robot alýndý.
                s = tmp(selRobot.robotID);
                % X ve Y koordinatý alýndý.

                % mevcut konumdaki robot ve selectedObj siliniyor.
                deleteRobot(selRobot.robotID);
               
                % Yeni Robot Ekleniyor.

                s.circleObj = circles(X,Y, pref.circleRadius , 'facecolor' , s.color); 
                % Koordinat Güncelleniyor.
                s.x = X;
                s.y = Y;
                
                %robot ID'si daire icine yazi olarak ekleniyor.
                if s.id > 9
                    s.textObj = text(X-0.1,Y,int2str(s.id));           % text adresi robot nesnesine atildi
                else
                    s.textObj = text(X,Y,int2str(s.id));
                end
                
                set(s.textObj , 'FontSize',12);
                set(s.textObj , 'FontWeight','bold');
                
                % Deðiþtirilen deðerler güncelleniyor.
                tmp(selRobot.robotID) = s;
                setRobotObj(tmp);
                
            
            else
                
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
    
    
    
    % seçili robot bilgisi alýnýyor.
    selectedObj = getSelectedRobot;
    
    if left > pLeft && left < pLeft + pWidth && bottom > pBottom && bottom < pBottom + pHeight
        posCurr = get(gca , 'CurrentPoint');
        X = posCurr(1);
        Y = posCurr(3);
        
        roboID = getMeIdByCoordinate(X , Y);

       
        % ilk olarak sürükle býrak komutu için control butonuna basýlýp
        % basýlmadýðý kontrol ediliyor.
        if selectedObj.isControlButtonSet
%             fprintf('bu mal tasýnacak/n')
            selectedObj.robotID = roboID;
            
            % mouse da týklandý artýk taþýmaya hazýrdýr
            selectedObj.isMouseDown = true;
            setSelectedRobot(selectedObj);
            
        else
            
        % Eðer panelde týklanýlan yerde bir robot varsa, bu robot için
        % lazer range finder datasý oluþturulacak.
        if roboID ~= 0
            plotLaserRangeFinderForId(roboID);
        else
            
            % Eðer burada bir robot yoksa panele robot eklenecek
            hold on
            addElementToPanel(X , Y , handles);
            hold off
        end
        end
        
    end
    
function panelZoom (src,callbackdata)
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
            
            % Panel boyutlarý alýnýyor.
   width = get(gca,'XLim');
    height = get(gca,'YLim');

    zoom = pref.zoomFactor;
            
            % Scroll Up
            if( callbackdata.VerticalScrollCount > 0 )
                
            axis([width(1)+zoom, width(2)-zoom, height(1)+zoom, height(2)-zoom]);
            axis equal;
            end
            
            
            % Scroll Down
            if( callbackdata.VerticalScrollCount < 0 )
                
                axis([width(1)-zoom, width(2)+zoom, height(1)-zoom, height(2)+zoom]);
                axis equal;
            end
            
           
        end
  
function panelNavigation (src,callbackdata)

    keyPressed = callbackdata.Key;
    % Panel boyutlarý alýnýyor.
    width = get(gca,'XLim');
    height = get(gca,'YLim');

 
 if strcmpi(keyPressed,'rightarrow')
     
                axis([width(1)+2.5, width(2)+2.5, height(1), height(2)]);
%                 axis equal;
                
 end
 
 
 
 if strcmpi(keyPressed,'leftarrow')  
     
                axis([width(1)-2.5, width(2)-2.5, height(1), height(2)]);
%                 axis equal;
                
 end
 
  
 if strcmpi(keyPressed,'uparrow') 
     
                axis([width(1), width(2), height(1)+2.5, height(2)+2.5]);
%                 axis equal;
                
 end
 
 
 
 if strcmpi(keyPressed,'downarrow')
     
                axis([width(1), width(2), height(1)-2.5, height(2)-2.5]);
%                 axis equal;
                
 end
 
 % Eðer kontrol tuþuna basýlmýþsa deðer true edilecek.
 if strcmpi(keyPressed,'control')
     
     set(gcf,'Pointer','fleur');
     
     selectedObj = getSelectedRobot;
     
     selectedObj.isControlButtonSet = true;
     setSelectedRobot(selectedObj);
     
     
 end
 
function keyRelease (src,callbackdata)
     
     
     keyPressed = callbackdata.Key;
     
     selectedObj = getSelectedRobot;
     
     if strcmpi(keyPressed,'control')
         set(gcf,'Pointer','arrow');
         selectedObj.isControlButtonSet = false;
         setSelectedRobot(selectedObj);
     end
     
function mouseDown(src,callbackdata)
selectedObj = getSelectedRobot;
selectedObj.isMouseDown = false;

setSelectedRobot(selectedObj);

        
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
    
    
    % iki nokta arasýndaki uzaklýk hesaplanýyor.
    arr = [s.x , s.y ; X , Y];
    distance = pdist(arr , 'euclidean');
    
    
    if distance <= pref.circleRadius
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
    
    
    % Eðer açýlý bir figure penceresi varsa kapatýlacak.
    if selRobot.figureWindow ~= 0
%         fprintf('kaptýlýyor..\n')
        close(selRobot.figureWindow)
    end
    % Daha önceden çizilmiþ lazer çizgileri varsa onlar alandan silinecek.
    allLines = selRobot.linesObj;
    
    % Daha Önceden Atanmýþ lazer uzunluk bilgileri varsa silinecek
    selRobot.allLength = [];
    selRobot.allSlope = [];

setSelectedRobot(selRobot);

    for i=1:length(allLines)
        delete(allLines(i))
    end
    allLines = [];
    
    % Lazerin çevresinde bulunan robotlar bulunup array halinde deðiþkene
    % atanýyor.
%     foundedRobots = findRobotsForLazer(s.x , s.y );
    
    
% lazer ýþýnlarý çiziliyor.

% Sensorden gelen tüm uzunluklar ve tüm açýlar array a atýlýyor.



for i=0:laserInfo.interval:360
    
    X = s.x;
    Y = s.y;
    
    % çizginin nereye kadar çizileceði. çizilecek uzunluk sensörün
    % deðerini belirleyecek.
    limitX = s.x+laserInfo.range * cosd(i);
    limitY = s.y+laserInfo.range*sind(i);
    
    % çizilen çizgi doðrultusunda hiç robot var mý ona bakýlýyor.
    robotNum = isRobotExistForSlope(X , Y , limitX, limitY , i , s.id);
    
    if robotNum ~= 0 && robotNum ~= s.id
        % Lazerlerin yüzeyinden sensör datasý çýkmasý için gerekli
        % ayarlamalar yapýlýyor.
        
        % gönderilen lazer ýþýný doðrultusunda bir robotun varlýðý
        % anlaþýldýktan sonra ýþýnýn sahip olduðu uzunluðun
        % belirlenmesi gerekiyor.
        % Limit X ve Limit Y deðerleri senkronize edilmeli.
        
        [ limitX , limitY ] = findLimitBeamDistance(X , Y , i , robotNum);
        
        
        hold on
        plotObj = plot([X limitX] , [s.y limitY] , 'Color' , 'red' );
        hold off
        
    else
        
        % Eðer bu noktada herhangi bir robotla karþýlaþýlmamýþsa length ve
        % slope deðerleri default olarak array'a atanýyor.
        

        
        hold on
        plotObj = plot([X limitX] , [s.y limitY] , 'Color' , 'blue' );
        hold off
    end
    
    % oluþturulan çizgi bilgisi array'a atýlýyor.
    allLines = [allLines plotObj];
    
    
    arr = [X , Y ; limitX , limitY];
    distance = pdist(arr , 'euclidean');
    
    selRobot.allLength = [selRobot.allLength distance];
    selRobot.allSlope = [selRobot.allSlope i];
    
    
    setSelectedRobot(selRobot);
    
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
%      setSelectedRobot(selRobot);   
     
     
     tmpSel = getSelectedRobot;
     tmpSel.allLength;
     tmpSel.allSlope;
%     
%      
%      assignin('base','length',tmpSel.allLength)
%      assignin('base','slope',tmpSel.allSlope)

     selRobot.figureWindow = figure;
     plot(tmpSel.allSlope,tmpSel.allLength)
     title('2-D Line Plot')
     xlabel('angle')
     ylabel('length')
     
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
function robot = isRobotExistForSlope(X , Y , limitX, limitY , slope , currID)

robot = 0;

% limitI = floor(laserInfo.range / ( pref.circleRadius * 2));

limitI = floor(laserInfo.range / ( 1 ));

for i=1:limitI

currY = sind(slope) * i + Y;
currX = cosd(slope) * i + X;

roboid = getMeIdByCoordinate(currX , currY );
    
% if roboid ~= currID
%     circles(currX,currY, 0.1 , 'facecolor' , 'red');
% end

if roboid ~= 0 && roboid ~= currID
    robot = roboid;
    break;
end

end
% fprintf('b-------------------------\n')


function [ limitX , limitY ] = findLimitBeamDistance(X , Y , angle , robotNum)

tmp = getRobotObj;
s = tmp(robotNum);
angle
% Bölgesi Bulunuyor.
area = floor(angle/90)+1
% selRobot = getSelectedRobot;

% iki nokta arasýndaki uzaklýk hesaplanýyor.
arr = [s.x , s.y ; X , Y]
distance = pdist(arr , 'euclidean')

alpha = asind( (s.y-Y) / distance)


if area == 2
    angle = mod(angle , 90 )
    fprintf('diff es')
    diff = 90 - ( angle + alpha )
 
elseif area == 3
    angle = mod(angle , 90 )
    alpha = alpha * -1
    diff = angle - alpha
    
else
    
    diff = angle - alpha
end

root = roots([1 -2*distance*cosd(diff) distance^2-pref.circleRadius^2]);
% Küçük kök alýnýr.
if root(1) < distance
    touchPoint = root(1);
else
    touchPoint = root(2);
end

% % elde edilen uzunluk ve açý verisi mevcut robotun arraylarine aktarýlýyor.
% selRobot.allLength = [selRobot.allLength touchPoint];
% selRobot.allSlope = [selRobot.allSlope angle];
% 
% setSelectedRobot(selRobot);
% 
%      tmpSel = getSelectedRobot;
%      tmpSel.allLength
%      tmpSel.allSlope

if area == 3
    noktaX = -touchPoint*cosd(angle)+X;
    noktaY = -touchPoint*sind(angle)+Y;
elseif area == 2
    
    noktaX = -touchPoint*cosd(diff + alpha)+X;
    noktaY = touchPoint*sind(diff + alpha)+Y;
    
else
    noktaX = touchPoint*cosd(angle)+X;
    noktaY = touchPoint*sind(angle)+Y;
end


limitX = noktaX;
limitY = noktaY;
    


% Robotlarin Adreslerini tutan global degisken.
function setRobotObj(val)
global robotObj
robotObj = val;

function r = getRobotObj
global robotObj
r = robotObj;

% Seçilen robota ait bilgilerin bulunduðu deðiþken
function setSelectedRobot(val)
global selectObj
selectObj = val;

function r = getSelectedRobot
global selectObj
r = selectObj;




function varargout = simulation_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


