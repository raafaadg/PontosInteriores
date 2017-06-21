function [Z X E] = PontosInteriores(x0,a,cont,data,sheet)
 
%     X0 = [x0(1) x0(2) 8-2*x0(1) 6-x0(2)  18-3*x0(1)-2*x0(2)];
    X0 = [1 0 2];

    I = eye(size(X0,2));
    e = ones(1,size(X0,2));
    
%     A = [2 0 1 0 0;0 1 0 1 0;3 2 0 0 1];
%     c = [300 500 0 0 0];
    
    A=[1 3 1];
    c=[2 5 4];
    D = diag(X0);
    
    it=8;
    X = ones(it,3);
%     plot(x0(1),x0(2),'go')
%     hold on;
    for i = 1:it
        At = A*D
        ct= D*c'
        P = I - At'*(At*At')^-1*At
        cp = P*ct
        xt1 = e' + a/abs(min(cp))* cp
        X1 = D*xt1
%         Z(i) = 300*X1(1)+500*X1(2);
        Z(i) = 2*X1(1)+5*X1(2)+4*X1(3)
        D = diag(X1)
%         plot(X1(1),X1(2),'bo')
%         hold on;
        X(i,:)=[X1(1) X1(2) X1(3)];
      
        if cont == 1
            msg1=sprintf('Iteração nº: %d - Para os pontos iniciais[x1,x2]: [%d,%d] e Alfa: %.2f',i,x0(1),x0(2),a);
            xlswrite(data,msg1,sheet,'A1:B1');
            disp(msg1);
            
            msg1='Matriz A cotendo os coeficientes das restrições';
            disp(msg1);
            disp(A);
%             xlswrite(data,msg1,sheet,'A3');
%             xlswrite(data,A,sheet,'A4');
            
            msg1='Vetor C cotendo os coeficientes da Função Objetivo';
            disp(msg1);
            disp(c);
%             xlswrite(data,msg1,sheet,'A8');
%             xlswrite(data,c,sheet,'A9');
            
            msg1='Matriz D cotendo os valores de A na diagonal principal';
            disp(msg1);
            disp(D);
%             xlswrite(data,msg1,sheet,'A11');
%             xlswrite(data,D,sheet,'A12');
            
            msg1='Matriz At gerada a partir da multiplicação entre A*D';
            disp(msg1);
            disp(At);
%             xlswrite(data,msg1,sheet,'A16');
%             xlswrite(data,At,sheet,'A17');
            
            msg1='Vetor ct gerada a partir da multiplicação entre c*D';
            disp(msg1);
            disp(ct);
%             xlswrite(data,msg1,sheet,'A21');
%             xlswrite(data,ct,sheet,'A22');
            
            msg1='Matriz P gerada a partir da equação P = I - At(transp)*inv(At*At(transp))*At ;';
            disp(msg1);
            disp(P);
%             xlswrite(data,msg1,sheet,'A24');
%             xlswrite(data,P,sheet,'A525');
            
            msg1='Matriz cp gerada a partir da multiplicação entre ct*P';
            disp(msg1);
            disp(cp);
%             xlswrite(data,msg1,sheet,'A30');
%             xlswrite(data,cp,sheet,'A31');
            
            msg1='Matriz xt1 gerada a partir da equação: e + a/abs(min(cp))* cp;';
            disp(msg1);
            disp(xt1);
%             xlswrite(data,msg1,sheet,'A35');
%             xlswrite(data,xt1,sheet,'A36');
            
            msg1='Vetor X1 gerada a partir da multiplicação entre xt1*D contendo os novos valores de x1 e x2';
            disp(msg1);
            disp(X1)
%             xlswrite(data,msg1,sheet,'A40');
%             xlswrite(data,X1,sheet,'A41');
            
            cont = cont +1;
        end
    end
    
    E=100*abs(3600-max(Z))/3600;
    Z = Z';
    end
