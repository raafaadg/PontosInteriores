function [Z X E] = PontosInteriores(x0,a)
    x0 = x0;
    a = a;

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
    end
    E=100*abs(3600-max(Z))/3600;
    Z = Z';
    end
