function [T, Y] = giant_ode(params)
% GIANT_ODE - calculates the angle and angular velocity of a double pendulum over time
%
% Outputs:
%    T - a vector of times
%    Y - a matrix of thetas and omegas
%
% Author: Isaac Getto
% email address: isaac.getto@students.olin.edu
% April 2015

    params = merge_defaults(params);

    m1 = params('m1');
    m2 = params('m2');
    L1 = params('l1');
    L2 = params('l2');
    g = 9.8;
    uk = params('uk');
    amplitude = params('amp');
    phase_shift = params('phase');
    frequency = params('frequency');

    theta0 = params('theta0');
    center_of_rotation = params('center_of_rotation');
    initial_conds = [theta0, 1, theta0 + center_of_rotation];
    time_range = [0, 3];

    options = odeset('RelTol', 1E-50, 'Events', @top_of_circle);
    [T, Y] = ode45(@pendulum_derivs, time_range, initial_conds, options); 

    if params('anim')
        figure
        giant_animate(T, Y, params);
    end

    % append omega2's
    T1 = Y(:, 1);
    O1 = Y(:, 3);
    O2 = omega2(T1, O1);
    Y = [Y, O2];

    function [value, isterminal, direction] = top_of_circle(t, Y)
        theta1 = Y(1);
        if theta1 < -pi
            value = 0;
        elseif theta1 >= pi
            value = 0;
        else
            value = theta1 - pi;
        end
        isterminal = 1;
        direction = 0;
    end

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
        res = omega1 + frequency .* omega1 .* amplitude .* cos(frequency * theta1 + phase_shift);
    end

    function res = acceleration1(theta1, theta2, omega1, omega2)
        numer = - g * (2 * m1 + m2) * sin(theta1) - m2 * g * sin(theta1 - 2 * theta2) - 2 * sin(theta1 - theta2) * m2 * (omega2^2 + omega1^2 * L1 * cos(theta1 - theta2)); 
        denom = L1 * (2 * m1 + m2 - m2 * cos(2 * theta1 - 2 * theta2));
        res = numer / denom;
        res = res - friction(omega1);% (omega1 / abs(omega1)) * (omega1^2) * uk;
    end

    function res = friction(omega2)
        r = L1 + 0.5 * L2;
        v = omega2 * r;
        fc = (m1 + m2) * v^2 / r;
        res = fc * uk;
    end

end

