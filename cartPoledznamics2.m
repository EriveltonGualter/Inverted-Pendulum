function dz = cartPoleDynamics2(z,p,u)

% x = z(1,:);
dx = z(2,:);
q = z(3,:);
dq = z(4,:);

% Unpack the physical parameters
L = p.l;  %Pendulum length
m1 = p.m1; % cart mass
m2 = p.m2; % pole mass
g = p.g;  %Gravity acceleration

Sz = sin(q);
Cz = cos(q);
D = m1*L*L*(m2+m1*(1-Cz^2));

dz1 = dx;
dz2 = (1/D)*(-m1^2*L^2*g*Cz*Sz + m1*L^2*(m1*L*dq^2*Sz - d*dx)) + m1*L*L*(1/D)*u;
dz3 = dq;
dz4 = (1/D)*((m1+m2)*m1*g*L*Sz - m1*L*Cz*(m1*L*dq^2*Sz - d*dx)) - m1*L*Cz*(1/D)*u +.01*randn;

dz = [dz1;dz2;dz3;dz4]; % temp