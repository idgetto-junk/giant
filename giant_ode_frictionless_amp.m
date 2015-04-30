function [T, M] = giant_ode_frictionless_amp(amp)

    m1 = 35;
    m2 = 35;
    L1 = 1;
    L2 = 1;
    g = 10;
    uk = 0;
    amplitude = amp;

    theta0 = -pi/4;
    initial_conds = [theta0, 1, theta0 + amplitude];
    time_range = [0, 100];

    options = odeset('Events', @top_of_circle, 'RelTol', 1E-50);
    [T, M] = ode45(@pendulum_derivs, time_range, initial_conds, options); 

    % append omega2's
    T1 = M(:, 1);
    O1 = M(:, 3);
    O2 = omega2(T1, O1);
    M = [M, O2];

    function [val,isterminal,direction] = top_of_circle(t, Y)
        theta = Y(1);
        val = theta - pi;
        isterminal = 1;
        direction = 1;
    end

    function D = pendulum_derivs(t, Y)
        theta1 = Y(1);
        omega1 = Y(2); 
        theta2 = Y(3);
        o2 = omega2(theta1, omega1);
        alpha1 = acceleration1(theta1, theta2, omega1, o2);

        dTheta1 = omega1;
        dOmega1 = alpha1;
        dTheta2 = o2;

        D = zeros(3, 1);
        D(1) = dTheta1;
        D(2) = dOmega1;
        D(3) = dTheta2;
    end

    function res = omega2(theta1, omega1)
        res = omega1 + 2 .* omega1 .* amplitude .* cos(2 .* theta1);
    end

    function res = acceleration1(theta1, theta2, omega1, omega2)
        numer = - g * (2 * m1 + m2) * sin(theta1) - m2 * g * sin(theta1 - 2 * theta2) - 2 * sin(theta1 - theta2) * m2 * (omega2^2 + omega1^2 * L1 * cos(theta1 - theta2)); 
        denom = L1 * (2 * m1 + m2 - m2 * cos(2 * theta1 - 2 * theta2));
        res = numer / denom;
        res = res - (omega1 / abs(omega1)) * (omega1^2) * uk;
    end

end

