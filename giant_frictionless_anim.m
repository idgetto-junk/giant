function giant_frictionless_anim
    [T, Y] = giant_ode_frictionless_amp(0.1);

    m1 = 1
    m2 = 1
    L1 = 1;
    L2 = 1;
    g = 10;
    O = [0, 0]; % origin position

    max_vel = 11.8699;
    max_acc = 100.7099;

    start_time = T(1);
    stop_time  = T(end);
    dt = 1 / 1000;
    index = 1;

    clf;
    set_axes;
    for t = start_time:dt:stop_time
        if index < length(T) && t >= T(index)
            theta1 = Y(index, 1)
            omega1 = Y(index, 2);
            theta2 = Y(index, 3);
            omega2 = 0;

            draw_frame(theta1, omega1, theta2, omega2);
            drawnow;

            index = index + 1;
        end
        pause(10 * dt);
    end

    max_vel
    max_acc

    function res = thetadot2(theta1)
        res = sin(2 * theta1);
    end

    function draw_frame(theta1, omega1, theta2, omega2)
        clf;
        hold on;
        set_axes;

        P1 = bob_position(theta1, O, L1);
        P2 = bob_position(theta2, P1, L2);
        V1 = velocity(theta1, omega1, L1);
        A1 = acceleration1(theta1, theta2, omega1, omega2, L1);

        draw_pendulum(theta1, omega1, O, L1, zeros(1, 2), zeros(1, 2));
        draw_pendulum(theta2, omega2, P1, L2, V1, A1);

        draw_velocity_arrow(theta1, omega1, P1, L1, zeros(1, 2));
        draw_acceleration_arrow1(theta1, theta2, omega1, omega2, P1, L1, zeros(1, 2));

        draw_velocity_arrow(theta2, omega2, P2, L2, V1);
        draw_acceleration_arrow2(theta1, theta2, omega1, omega2, P2, L2, A1);
    end

    function draw_pendulum(theta, omega, P, L, Vref, Aref)
        draw_origin(P);
        draw_string(theta, P, L);
        draw_bob(theta, P, L); 

    end

    function draw_origin(P)
        plot(P(1), P(2), 'k.', 'MarkerSize', 20);
    end

    function draw_string(theta, P, L)
        R = bob_position(theta, P, L);

        SX = zeros(2, 1);
        SX(1) = P(1);
        SX(2) = R(1);

        SY = zeros(2, 1);
        SY(1) = P(2);
        SY(2) = R(2);

        plot(SX, SY, 'LineWidth', 4); 
    end

    function draw_bob(theta, P, L)
        R = bob_position(theta, P, L);
        plot(R(1), R(2), 'k.', 'MarkerSize', 50);
    end

    function draw_velocity_arrow(theta, omega, P, L, Vref)
        V = velocity(theta, omega, L);
        V = V + Vref;
        
        absV = sqrt(V(1)^2 + V(2)^2);
        max_vel = max(max_vel, absV);

        V = V / max_vel;
        V = V * 2;

        VX = [P(1), P(1) + V(1)];
        VY = [P(2), P(2) + V(2)];
        plot(VX, VY, 'LineWidth', 4, 'Color', 'g');
    end

    function draw_acceleration_arrow1(theta1, theta2, omega1, omega2, P, L, Aref)
        A = acceleration1(theta1, theta2, omega1, omega2, L);
        A = A + Aref;

        absA = sqrt(A(1)^2 + A(2)^2);
        max_acc = max(max_acc, absA);

        A = A / max_acc;
        A = A * 2;

        AX = [P(1), P(1) + A(1)];
        AY = [P(2), P(2) + A(2)];
        plot(AX, AY, 'LineWidth', 4, 'Color', 'r');
    end

    function draw_acceleration_arrow2(theta1, theta2, omega1, omega2, P, L, Aref)
        A = acceleration2(theta1, theta2, omega1, omega2, L);
        A = A + Aref;

        absA = sqrt(A(1)^2 + A(2)^2);
        max_acc = max(max_acc, absA);

        A = A / max_acc;
        A = A * 2;

        AX = [P(1), P(1) + A(1)];
        AY = [P(2), P(2) + A(2)];
        plot(AX, AY, 'LineWidth', 4, 'Color', 'r');
    end

    function R = bob_position_helper(theta, L)
        R(1) = L * sin(theta); % x-position
        R(2) = -L * cos(theta); % y-position
    end

    function R = bob_position(theta, P, L)
        R = bob_position_helper(theta, L) + P;
    end

    function V = velocity(theta, omega, L)
        theta_hat = [cos(theta), sin(theta)];
        V = L * omega * theta_hat; 
    end

    function A = acceleration1(theta1, theta2, omega1, omega2, L)
        theta_hat = [cos(theta1), sin(theta1)];
        r_hat = [sin(theta1), -cos(theta1)];
        A = L * alpha1(theta1, theta2, omega1, omega2, L) * theta_hat - L * omega1 * r_hat;
    end

    function A = acceleration2(theta1, theta2, omega1, omega2, L)
        theta_hat = [cos(theta2), sin(theta2)];
        r_hat = [sin(theta2), -cos(theta2)];
        A = L * alpha2(theta1, theta2, omega1, omega2, L) * theta_hat - L * omega2 * r_hat;
    end

    function set_axes
        axis([-3, 3, -3, 3]);
        axis square;
    end
 
    function res = alpha1(theta1, theta2, omega1, omega2, L)
        numer = -g * (2 * m1 + m2) * sin(theta1) - m2 * g * sin(theta1 - 2 * theta2) - 2 * sin(theta1 - theta2) * m2 * (omega2^2 + omega1^2 * L * cos(theta1 - theta2)); 
        denom = L * (2 * m1 + m2 - m2 * cos(2 * theta1 - 2 * theta2));
        res = numer / denom;
    end

    function res = alpha2(theta1, theta2, omega1, omega2, L)
        numer = 2 * sin(theta1 - theta2) * (omega1^2 * L * (m1 + m2) + g * (m1 + m2) * cos(theta1) + omega2^2 * L * m2 * cos(theta1 - theta2));
        denom = L * (2 * m1 + m2 - m2 * cos(2 * theta1 - 2 * theta2));
        res = numer / denom;
    end
end
