function val  = generateArrow( totalGravX ,totalGravY , rObj )

val = robotInfo;

egim = atand(totalGravY/totalGravX);
    uzunluk = sqrt((totalGravX.^2) + (totalGravY.^2));
    
    if totalGravX > 0 && totalGravY > 0
    end
    if totalGravX < 0 && totalGravY > 0
        egim = 180 + egim;
    end
    if totalGravX < 0 && totalGravY < 0
        egim = 180 + egim;
    end
    if totalGravX > 0 && totalGravY < 0
        egim = 360 + egim;
    end
    
    hold on
    
    % Egim ve uzunluk degerlerine gore X ve Y bilesenleri belirlendi.
%     
%     x=[rObj.x,rObj.x+cosd(egim)];
%     y=[rObj.y,rObj.y+sind(egim)];
%        
    x = rObj.x;                          %# X coordinate of arrow start
    y = rObj.y;                          %# Y coordinate of arrow start
    radEgim = egim * ( pi / 180.0);
    theta = radEgim;                   %# Angle of arrow, from x-axis
    L = 1;                          %# Length of arrow
    xEnd = x+L*cos(theta);          %# X coordinate of arrow end
    yEnd = y+L*sin(theta);          %# Y coordinate of arrow end
    
    points = linspace(0,theta);     %# 100 points from 0 to theta
    
    xCurve = x+(L/2).*cos(points);  %# X coordinates of curve
    yCurve = y+(L/2).*sin(points);  %# Y coordinates of curve
    
    % Ok isaretiyle alakali degerlerin adresleri class'a kopyalandi.
    rObj.lineInfo = plot(x+[-L L],[y y],'--k');    %# Plot dashed line
    rObj.arrowInfo = arrow([x y],[xEnd yEnd]);       %# Plot arrow
    rObj.curveInfo = plot(xCurve,yCurve,'-k');     %# Plot curve
    
    %pointInfo = plot(x,y,'o','MarkerEdgeColor','k','MarkerFaceColor','w');  %# Plot point
    
    % Kutle cekim Algoritmasinin sonuclari class'a kopyalandi.
    rObj.gravSlope = egim;
    rObj.gravLength = uzunluk;
    
    hold off
    
    val = rObj;