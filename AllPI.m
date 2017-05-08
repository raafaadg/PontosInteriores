clear;
clc;
format long
vars = {'Z1' 'Z2' 'Z3' 'Z4' 'Z5' 'Z6' 'Z7' 'Z8' 'Precisao'};
% x0=[1 2;2 1;1 3;3 1;2 3;3 2];
% a=[.75 .9 .7 .85 .6 .8];
x0=[1 2;2 1];
a=[.75 .9];
Z = ones(size(x0,1)*size(a,2),8);
iter=8;
xb=0:10;
yb=0:10;
u=1;
v=1;
XX=[];
ZZ=[];
EE=[];
cont = 1;
for k=1:size(x0,1)
    for i=1:size(a,2)
        msg=sprintf('Ponto Inicial x0: [%d,%d] e Alfa: %.2f',...
            x0(k,1),x0(k,2),a(i));
        figure('Name',msg)
        grid on;
        plot([0 0],[-10 10],'k',[-10 10],[0 0],'k',xb,(9-1.5*xb),'r',...
            4*ones(1,size(yb,2)),yb,'r',xb,6*ones(1,size(xb,2)),'r',...
            [0 0],[0 9],'r',[0 4],[0 0],'r')
        hold on;
         fill([0 0 2 4 4],[0 6 6 3 0],[.5 .7 .8])
         hold on;
         
        [Z X E] = PontosInteriores(x0(k,:),a(i),cont);
        cont = 1;
        XS=[x0(k,1) X(:,1)'];
        YS=[x0(k,2) X(:,2)'];
        plot(XS,YS,'k','LineWidth',1);

        XX=vertcat(XX,X);
        ZZ=vertcat(ZZ,Z);
        EE=horzcat(EE,E);
        Names(v,1)={sprintf('[%d,%d] a=%.2f',x0(k,1),x0(k,2),a(i))};
        v = v+1;
    end
end
% close all;
for i=1:(size(x0,1)*size(a,2))
    for j=1:iter+1
        if j<9
            tab(i,j) = {sprintf('[%.4f,%.4f] = %f',XX(u,1),XX(u,2),ZZ(u))};
            u = u+1;
        else
            tab(i,j)={num2str(EE(i),'%f')};
        end
    end
end

T = table(tab(:,1),tab(:,2),tab(:,3),tab(:,4),tab(:,5),tab(:,6),...
    tab(:,7),tab(:,8),tab(:,9),'VariableName',vars,'RowNames',Names)  
