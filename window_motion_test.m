function NZQRadm(action)
global L cp scale s1 op s

switch action
   
case 'zoom in'
   set(gcbf,'WindowButtonDownFcn','NZQRadm(''set axis'')')
   scale=.5;
   
case 'zoom out'
   set(gcbf,'WindowButtonDownFcn','NZQRadm(''set axis'')')
   scale=2;
   
case 'refocus'
   set(gcbf,'WindowButtonDownFcn','NZQRadm(''set axis'')')
   scale=1;
   
case 'set axis'
   cp=get(gca,'CurrentPoint');
   cp=cp(1,1:2);
   XLim=get(gca,'XLim');
   YLim=get(gca,'YLim');
   cp(2)=sum(YLim)/2;
   m=log(10)/log(2);
   dX=scale*diff(XLim);
   dY=scale^(1/m)*diff(YLim);     %% modify here
   NewXLim=[cp(1)-dX/2 cp(1)+dX/2];
   NewYLim=[cp(2)-dY/2 cp(2)+dY/2];
   set(gca,'XLim',NewXLim,'YLim',NewYLim)
   NZQRadm('replot')
   
case 'drag'
   set(gcbf,'WindowButtonDownFcn','NZQRadm(''start drag'')')
   
case 'start drag'
   set(gcbf,'WindowButtonMotionFcn','NZQRadm(''drag it'')')
   set(gcbf,'WindowButtonUpFcn','NZQRadm(''stop drag'')')
   cp=get(gca,'CurrentPoint');
   cp=cp(1,1:2);  
   
case 'drag it'
   newcp=get(gca,'CurrentPoint');
   newcp=newcp(1,1:2);
   dxy=newcp-cp;
   dxy(2)=0;
   XLim=get(gca,'XLim');
   YLim=get(gca,'YLim');
   XLim=XLim-dxy(1)/5;
   YLim=YLim-dxy(2)/5;
   set(gca,'XLim',XLim,'YLim',YLim)
   NZQRadm('replot')
   
case 'stop drag'
   set(gcbf,'WindowButtonMotionFcn','')
   set(gcbf,'WindowButtonUpFcn','')
   NZQRadm('replot')
      
case 'replot'
   XLim=get(gca,'XLim');
   YLim=get(gca,'YLim');
   set(fo('x-axis'),'XData',XLim,'YData',[0 0])
   delete(fo('N-tick'))
   delete(fo('Z-tick'))
   delete(fo('Q-tick'))
   if L=='N'
      x=0:ceil(XLim(2));
      for i=1:length(x)
         line([x(i) x(i)],[-.1 .1],'Tag','N-tick')
      end
      dX=ceil(diff(XLim)/30);
      XTick=max(1,ceil(XLim(1))):dX:floor(XLim(2));
      set(gca,'XTick',XTick,'XTickLabelMode','auto')
   end
   if L=='Z'
      x=floor(XLim(1)):ceil(XLim(2));
      for i=1:length(x)
         line([x(i) x(i)],[-.1 .1],'Tag','Z-tick')
      end
      dX=ceil(diff(XLim)/30);
      XTick=ceil(XLim(1)):dX:floor(XLim(2));
      set(gca,'XTick',XTick,'XTickLabelMode','auto')
   end
   if L=='Q'
      dx=diff(XLim)/100;
      n=round(log(1/dx)/log(10));
      for j=0:n
         x=floor(XLim(1)):1/10^j:ceil(XLim(2));
         for i=1:length(x)
            line([x(i) x(i)],[-.1/2^(j) .1/2^(j)],'Tag','Q-tick')
         end
      end
      set(gca,'XTickMode','auto','XTickLabelMode','auto')
   end
   if L=='+'
      set(fo('y-axis'),'YData',YLim,'Visible','on')
      dx=diff(XLim)/100;
      n=round(log(1/dx)/log(10));
      for j=0:n
         x=floor(XLim(1)):1/10^j:ceil(XLim(2));
         y=floor(YLim(1)):1/10^j:ceil(YLim(2));
         for i=1:length(x)
            line([x(i) x(i)],[-.1/2^(j) .1/2^(j)],'Tag','Q-tick')
         end
         for i=1:length(y)
            line([-.1/2^(j) .1/2^(j)],[y(i) y(i)],'Tag','Q-tick')
         end
      end
      set(gca,'XTickMode','auto')
   end
   
case 'N'
   L='N';
   NZQRadm('plot')
   
case 'Z'
   L='Z';
   NZQRadm('plot')
   
case 'Q'
   L='Q';
   NZQRadm('plot')
   
case 'QxQ'
   L='+';
   NZQRadm('plot')
   
case 'R'
   L='R';
   NZQRadm('plot')
   
case 'plot'
   XLim=get(gca,'XLim');
   YLim=get(gca,'YLim');
%   cbo=get(gcbf,'CurrentObject');
%   L=get(cbo,'String');
   set(fo('x-axis'),'XData',XLim,'YData',[0 0])
   set(fo('y-axis'),'Visible','off')
   set(gca,'YTickLabel','')
   delete(fo('N-tick'))
   delete(fo('Z-tick'))
   delete(fo('Q-tick'))
   if L=='N'
      x=0:ceil(XLim(2));
      for i=1:length(x)
         line([x(i) x(i)],[-.1 .1],'Tag','N-tick')
      end
      dX=ceil(diff(XLim)/30);
      XTick=max(1,ceil(XLim(1))):dX:floor(XLim(2));
      set(gca,'XTick',XTick,'XTickLabelMode','auto')
   end
   if L=='Z'
      x=floor(XLim(1)):ceil(XLim(2));
      for i=1:length(x)
         line([x(i) x(i)],[-.1 .1],'Tag','Z-tick')
      end
      dX=ceil(diff(XLim)/30);
      XTick=ceil(XLim(1)):dX:floor(XLim(2));
      set(gca,'XTick',XTick,'XTickLabelMode','auto')
   end
   if L=='Q'
      dx=diff(XLim)/100;
      n=round(log(1/dx)/log(10));
      n=max(n,2);     % kolla denna
      for j=0:n
         x=floor(XLim(1)):1/10^j:ceil(XLim(2));
         for i=1:length(x)
            line([x(i) x(i)],[-.1/2^(j) .1/2^(j)],'Tag','Q-tick')
         end
      end
      set(gca,'XTickMode','auto','XTickLabelMode','auto')
   end
   if L=='+'
      set(fo('y-axis'),'YData',YLim,'Visible','on')
      dx=diff(XLim)/100;
      n=round(log(1/dx)/log(10));
      n=max(n,2);     % kolla denna
      for j=0:n
         x=floor(XLim(1)):1/10^j:ceil(XLim(2));
         y=floor(YLim(1)):1/10^j:ceil(YLim(2));
         for i=1:length(x)
            line([x(i) x(i)],[-.1/2^(j) .1/2^(j)],'Tag','Q-tick')
         end
         for i=1:length(y)
            line([-.1/2^(j) .1/2^(j)],[y(i) y(i)],'Tag','Q-tick')
         end
      end
      set(gca,'XTickMode','auto')
      set(gca,'YTickLabelMode','auto')
   end
   
case 'scale'
   string=get(gcbo,'String');
   if string=='lin scale'
     set(gcbo,'String','log scale')
     set(gca,'XScale','linear')
   elseif string=='log scale'
     set(gcbo,'String','lin scale')
     set(gca,'XScale','log')
   end
   NZQRadm('plot')

case 'calculate'
%   XLim=get(gca,'XLim');
   figure(findobj('Tag','NZQR'))
   s=get(gcbo,'String');
   if isempty(s1)
      delete(findobj('Tag','result'))
      s1=s
      h=line([0 .1 -.1 0],[0 .1 .1 0]);
      set(h,'Tag','result')
      drawnow
      X=get(h,'XData');
      y=sin(0:.1:100);
      for i=1:eval(s1)
         set(h,'XData',X+i)
         sound(y)
         drawnow
         for j=1:100; drawnow; end
      end
%      [X,Y]=arrow([s1 0]);
%      figure(findobj('Tag','NZQR'))
%      h=line(X,Y); set(h,'Color','r','LineWidth',2,'Tag','arrow')
   elseif isempty(op)
      if s=='+' | s=='-' | s=='*'
         op=s;
      else
         s1=[];
         NZQRadm('calculate')
      end
   else
      result=eval([s1 op s]);
      h=findobj('Tag','result');
      X=get(h,'XData');
      y=sin(0:.1:100);
      XX=0;
      x=X(1);
      for i=1:eval(s)
         if op=='+'
            set(h,'XData',X+i)
            sound(y)
         elseif op=='-'
            set(h,'XData',X-i)           
            sound(y)
        elseif op=='*'
            XX(1)=i*x; XX(2)=XX(1)+.1; XX(3)=XX(1)-.1; XX(4)=XX(1);
            set(h,'XData',XX)           
         end
         drawnow
         for j=1:100; drawnow; end
      end
%      [X,Y]=arrow([result 0]);
%      set(fo('arrow'),'XData',X,'YData',Y)
      pause(3)
      delete(fo('arrow'))
      disp(['Result = ' num2str(result)])
      op=[];; s1=num2str(result);
   end
   
   
case 'calc'
   h=figure;
   set(h,'UNits','normalized','Position',[.25 .3 .2 .2])
   h=uicontrol(gcf,'Style','PushButton','String','1','Units','normalized','Position',[.1 .1 .2 .1],'Callback','NZQRadm(''calculate'')');
   h=uicontrol(gcf,'Style','PushButton','String','2','Units','normalized','Position',[.4 .1 .2 .1],'Callback','NZQRadm(''calculate'')');
   h=uicontrol(gcf,'Style','PushButton','String','3','Units','normalized','Position',[.7 .1 .2 .1],'Callback','NZQRadm(''calculate'')');
   h=uicontrol(gcf,'Style','PushButton','String','4','Units','normalized','Position',[.1 .3 .2 .1],'Callback','NZQRadm(''calculate'')');
   h=uicontrol(gcf,'Style','PushButton','String','5','Units','normalized','Position',[.4 .3 .2 .1],'Callback','NZQRadm(''calculate'')');
   h=uicontrol(gcf,'Style','PushButton','String','6','Units','normalized','Position',[.7 .3 .2 .1],'Callback','NZQRadm(''calculate'')');
   h=uicontrol(gcf,'Style','PushButton','String','7','Units','normalized','Position',[.1 .5 .2 .1],'Callback','NZQRadm(''calculate'')');
   h=uicontrol(gcf,'Style','PushButton','String','8','Units','normalized','Position',[.4 .5 .2 .1],'Callback','NZQRadm(''calculate'')');
   h=uicontrol(gcf,'Style','PushButton','String','9','Units','normalized','Position',[.7 .5 .2 .1],'Callback','NZQRadm(''calculate'')');
   h=uicontrol(gcf,'Style','PushButton','String','+','Units','normalized','Position',[.1 .7 .2 .1],'Callback','NZQRadm(''calculate'')');
   h=uicontrol(gcf,'Style','PushButton','String','-','Units','normalized','Position',[.4 .7 .2 .1],'Callback','NZQRadm(''calculate'')');
   h=uicontrol(gcf,'Style','PushButton','String','*','Units','normalized','Position',[.7 .7 .2 .1],'Callback','NZQRadm(''calculate'')');
   
end


function o=fo(tag)
o=findobj(gcbf,'Tag',tag);


function [X,Y]=arrow(p)
   XLim=get(gca,'XLim');
   dx=diff(XLim);
   s=(norm(p)+eps);
   X=[0 1 1-.01*dx/s 1-.02*dx/s 1-.01*dx/s...
        1 1-.01*dx/s 1-.02*dx/s];
   Y=[0 0  .003*dx/s  .01*dx/s  .003*dx/s...
        0 -.003*dx/s -.01*dx/s];
   v=atan2(p(2),p(1));
   XY=[cos(v) -sin(v);
   sin(v) cos(v)]*[X;Y];
   XY=[s 0;0 s]*XY;
   X=XY(1,:); Y=XY(2,:);