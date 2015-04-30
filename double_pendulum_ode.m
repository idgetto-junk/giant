function [T, Y] = double_pendulum_ode
% DOUBLE_PENDULUM_ODE - calculates the angle and angular velocity of a double pendulum over time
%
% Outputs:
%    T - a vector of times
%    Y - a matrix of thetas and omegas
%
% Author: Isaac Getto
% email address: isaac.getto@students.olin.edu
% February 2015

    m1 = 1;
    m2 = 1;
    L1 = 1;
    L2 = 1;
    g = 10;

    initial_conds = [pi/4, 0, pi/4, 0];
    time_range = [0, 10];

    odeset('RelTol', 1E-100);
    [T, Y] = ode45(@pendulum_derivs, time_range, initial_conds); 

    function D = pendulum_derivs(t, Y)
        theta1 = Y(1);
        omega1 = Y(2); 
        theta2 = Y(3);
        omega2 = Y(4); 
        alpha1 = acceleration1(theta1, theta2, omega1, omega2);
        alpha2 = acceleration2(theta1, theta2, omega1, omega2);

        dTheta1 = omega1;
        dOmega1 = alpha1;
        dTheta2 = omega2;
        dOmega2 = alpha2;

        D = zeros(4, 1);
        D(1) = dTheta1;
        D(2) = dOmega1;
        D(3) = dTheta2;
        D(4) = dOmega2;
    end

    function res = acceleration1(theta1, theta2, omega1, omega2)
        numer = -g * (2 * m1 + m2) * sin(theta1) - m2 * g * sin(theta1 - 2 * theta2) - 2 * sin(theta1 - theta2) * m2 * (omega2^2 + omega1^2 * L1 * cos(theta1 - theta2)); 
        denom = L1 * (2 * m1 + m2 - m2 * cos(2 * theta1 - 2 * theta2));
        res = numer / denom;
    end

    function res = acceleration2(theta1, theta2, omega1, omega2)
        numer = 2 * sin(theta1 - theta2) * (omega1^2 * L1 * (m1 + m2) + g * (m1 + m2) * cos(theta1) + omega2^2 * L2 * m2 * cos(theta1 - theta2));
        denom = L2 * (2 * m1 + m2 - m2 * cos(2 * theta1 - 2 * theta2));
        res = numer / denom;
    end
end

