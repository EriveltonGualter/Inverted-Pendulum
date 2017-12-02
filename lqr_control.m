function K = lqr_control(M, m, L, g, d)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    s = 1;

    A = [0 1 0 0;
        0 -d/M -m*g/M 0;
        0 0 0 1;
        0 -s*d/(M*L) -s*(m+M)*g/(M*L) 0];

    B = [0; 1/M; 0; s*1/(M*L)];
    eig(A)

    Q = [1 0 0 0;
        0 1 0 0;
        0 0 10 0;
        0 0 0 100];
    R = .0001;

%     det(ctrb(A,B))

    K = lqr(A,B,Q,R);

end

