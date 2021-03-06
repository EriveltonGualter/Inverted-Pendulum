function dz = cartPoleDynamics(z,p,u)
% dz = cartPoleDynamics(z,p)
%
% This function computes the first-order dynamics of the cart-pole. The
% cart rolls along horizontal rails. There is no friction in the system.
% Both the cart and the pole (pendulum) are point masses.
%
% The control has been removed, so that the system is purely passive.
%
% INPUTS:
%   z = [4, n] = [x;q;dx;dq] = state of the system
%   p = parameter struct
%       .g = gravity
%       .m1 = cart mass
%       .m2 = pole mass
%       .l = pendulum length
% OUTPUTS:
%   dz = dz/dt = time derivative of state
%

%
% NOTES:
%   The dynamics are written out here by hand, to make reading them easier.
% They are actually derived using the symbolic math toolbox. You can find
% the script in ../Derive_CartPole/Derive_cartPole.m
%

% x = z(1,:);   %Cart position (Not used in dynamics)
% q = z(2,:);   % pendulum (pole) angle, measure from gravity vector
% dx = z(3,:);  % cart velocity
% dq = z(4,:);  %pendulum angle rate

% x = z(1,:);
dx = z(2,:);
q = z(3,:);
dq = z(4,:);

% Unpack the physical parameters
l = p.l;  %Pendulum length
m1 = p.m1; % cart mass
m2 = p.m2; % pole mass
g = p.g;  %Gravity acceleration

% Compute the dynamics:
mEff = m1 + m2 - m2.*cos(q).^2;
centr = dq.^2.*l.*m2.*sin(q);
ddx = (u + centr + g.*m2.*cos(q).*sin(q))./mEff;
ddq = -(u.*cos(q) + (m1 + m2)*g*sin(q) + centr.*cos(q))./(l.*mEff);

% Pack everything back up:
% dz = [dx;dq;ddx;ddq];
dz = [dx;ddx;dq;ddq]; % temp

end