function [Z X E] = PontosInteriores(x0,a,cont)
    x0 = x0;
    a = a;
    cont = cont;
    X0 = [x0(1) x0(2) 8-2*x0(1) 6-x0(2)  18-3*x0(1)-2*x0(2)];

    I = eye(size(X0,2));
    e = ones(1,size(X0,2));
    
    A = [2 0 1 0 0;0 1 0 1 0;3 2 0 0 1];
    c = [300 500 0 0 0];
    D = diag(X0);
    
    X = ones(8,2);
    plot(x0(1),x0(2),'go')
    hold on;
    for i = 1:8
        At = A*D;
        ct= c*D;
        P = I - At'*inv(At*At')*At ;
        cp = ct*P;
        xt1 = e + a/abs(min(cp))* cp;
        X1 = xt1*D;
        Z(i) = 300*X1(1)+500*X1(2);
        D = diag(X1);
        plot(X1(1),X1(2),'bo')
        hold on;
        X(i,:)=[X1(1) X1(2)];
       
        if cont == 1
            msg1=sprintf('Itera��o n�: %d - Para os pontos iniciais[x1,x2]: [%d,%d] e Alfa: %.2f',i,x0(1),x0(2),a);
        disp(msg1);
        disp('Matriz A cotendo os coeficientes das restri��es');
        disp(A);
        disp('Vetor C cotendo os coeficientes da Fun��o Objetivo');
        disp(c);
        disp('Matriz D cotendo os valores de A na diagonal principal');
        disp(D);
        disp('Matriz At gerada a partir da multiplica��o entre A*D');
        disp(At);
        disp('Vetor ct gerada a partir da multiplica��o entre c*D');
        disp(ct);
        disp('Matriz P gerada a partir da equa��o P = I - At(transp)*inv(At*At(transp))*At ;');
        disp(P);
        disp('Matriz cp gerada a partir da multiplica��o entre ct*P');
        disp(cp);
        disp('Matriz xt1 gerada a partir da equa��o: e + a/abs(min(cp))* cp;');
        disp(xt1);
        disp('Vetor X1 gerada a partir da multiplica��o entre xt1*D contendo os novos valores de x1 e x2');
        disp(X1)
        cont = cont +1;
        end
    end
    
    E=100*abs(3600-max(Z))/3600;
    Z = Z';
    end
