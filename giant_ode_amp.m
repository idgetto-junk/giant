function [T, Y] = giant_ode_amp(amplitude)
% GIANT_ODE_AMP - calculates the angle and angular velocity of a double pendulum over time with a given amplitude of leg swing
%
% Inputs:
%   amplitude - the amplitude of the gymnasts leg swing
%
% Outputs:
%    T - a vector of times
%    Y - a matrix of thetas and omegas
%
% Author: Isaac Getto
% email address: isaac.getto@students.olin.edu
% April 2015

    m1 = 5;
    m2 = 4;
    L1 = 1;
    L2 = 1;
    g = 10;
    uk = .6;

    initial_conds = [pi/4, 1E-10, pi/4];
    time_range = [0, 100];

    odeset('RelTol', 1E-50);
    [T, Y] = ode45(@pendulum_derivs, time_range, initial_conds); 

    function D = pendulum_derivs(t, Y)
        theta1 = Y(1);
        omega1 = Y(2); 
        theta2 = Y(3);
        omega2 = omega2(theta1, omega1);
        alpha1 = acceleration1(theta1, theta2, omega1, omega2);

        dTheta1 = omega1;
        dOmega1 = alpha1;
        dTheta2 = omega2;

        D = zeros(3, 1);
        D(1) = dTheta1;
        D(2) = dOmega1;
        D(3) = dTheta2;
    end

    function res = omega2(theta1, omega1)
        res = omega1 + 2 * omega1 * amplitude * cos(2 * theta1);
    end

    function res = acceleration1(theta1, theta2, omega1, omega2)
        numer = - g * (2 * m1 + m2) * sin(theta1) - m2 * g * sin(theta1 - 2 * theta2) - 2 * sin(theta1 - theta2) * m2 * (omega2^2 + omega1^2 * L1 * cos(theta1 - theta2)); 
        denom = L1 * (2 * m1 + m2 - m2 * cos(2 * theta1 - 2 * theta2));
        res = numer / denom;
        res = res - (omega1 / abs(omega1)) * (omega1^2) * uk;
    end

end

