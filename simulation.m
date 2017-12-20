function simulation(id, hObject, handles)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    %%%% Initial State
    z0 = [
        10.0;   %horizontal position -
        0.0;   %horizontal velocity
        (pi/180)*handles.angle;  %pendulum angle (wrt gravity)
        0.0];  %pendulum angular rate

    %temp 

    %%%% Physical Parameters  (big mass and inertia for "slow" physics)
    p.m1 = handles.m1;  % (kg) Cart mass
    p.m2 = handles.m2;  % (kg) pole mass
    p.l = handles.l;    % (m) pendulum (pole) length
    p.g = 9.81;         % (m/s^2) gravity
    p.d = handles.d;    % damping

    %%%% Time vector
    t = linspace(0,handles.time,250);  %Simulation time stamps

    % UNPACK
    l = p.l;
    m1 = p.m1;
    m2 = p.m2;
    g = p.g;
    d = p.d;

    switch id
        case 0
            z0(1) = handles.x;
            dynFun = @(t,z)( cartPoleDynamics(z, p, 0));
        case 1
            K = lqr_control(m2,m1,l,-g,d)
            dynFun = @(t,z)( cartPoleDynamics(z, p, -K*(z-[handles.x; 0; pi; 0])));
        case 2
            K = poleplace_control(m2,m1,l,-g,d)
            dynFun = @(t,z)( cartPoleDynamics(z, p, -K*(z-[handles.x; 0; pi; 0])));
        otherwise
    end

    %%%% Function Handle
    

    %%%% Simulate the system!
    options = odeset(...
        'RelTol',1e-8, ...
        'AbsTol',1e-8);
    [~, z] = ode45(dynFun, t, z0, options);   %  <-- This is the key line!
    z = z';

    %%%% Plots:
    % figure(1); clf; hold on;
    % plotCartPole(t,z);  %Moved plotting to its own function


    %%%% Animation:

    % Convert states to cartesian positions:
    pos = cartPolePosition(z,p);
    x1 = pos(1,:);
    y1 = pos(2,:);
    x2 = pos(3,:);
    y2 = pos(4,:);

    % Plotting parameters:
    p.w = 0.6*p.l;  %Width of the cart
    p.h = 0.4*p.l;  %Height of the cart
    p.r = 0.1*p.l;  % Radius of the pendulum bob
    p.rw = 0.1*p.l; % Radius of the wheel

    % Compute the extents of the drawing, keeping everything in view
    padding = 0.2*p.l;  %Free space around edges
    xLow = min(min(x1 - 0.5*p.w,  x2 - p.r)) - padding;
    xUpp = max(max(x1 + 0.5*p.w,  x2 + p.r)) + padding;
    yLow = min(min(y1 - 0.5*p.h,  y2 - p.r)) - padding;
    yUpp = max(max(y1 + 0.5*p.w,  y2 + p.r)) + padding;
%     extents = [xLow,xUpp,yLow,yUpp];
    extents = [0 25 -6 6];

    % Create and clear a figure:
    % figure(2); clf;
    cla
    hold on;    %  <-- This is important!
    set(gcf,'DoubleBuffer','on');   % Prevents flickering (maybe??)

    % Compute the verticies of a star, just for fun;
    star = getStarVerticies(7,0.5);  % 7 verticies, spoke ratio of 0.5
    p.star = 0.6*p.r*star;  %Rescale the star;

    time = 0;
    tic;
    while time < t(end)

        % Compute the position of the system at the current real world time
        posDraw = interp1(t',pos',time')';

        % Redraw the image
        drawCartPole(time,posDraw,extents,p);

        % Update current time
        time = toc;

        % Update handles structure
        guidata(hObject, handles);
    end 
    
    %% Plots
    figure;
    plot(t,z,'LineWidth',2);
    legend('displacement','velocity','angle','angular velocity');
    xlabel('time (s)','Fontsize',14,'interpreter','latex');
    ylabel('States','Fontsize',14,'interpreter','latex');
    xlim([min(t) max(t)]);
end
