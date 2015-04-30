function [T, E] = giant_energy_amp(amp)

    % constants
    m1 = 35;
    m2 = 35;
    l1 = 1;
    l2 = 1;
    g = 9.8;

    [T, M] = giant_ode_frictionless_amp(amp);

    T1 = M(:, 1); % vector of theta1
    T2 = M(:, 3); % vector of theta2
    O1 = M(:, 2); % vector of omega1
    O2 = M(:, 4); % vector of omega2

    PE = potential_energy(T1, T2);
    KE = kinetic_energy(T1, T2, O1, O2);
    TE = PE + KE;
    IE = TE(1) * ones(length(TE), 1); % initial energy
    GE = TE - IE; % gymnast's input energy

    if T1(end) ~= pi
        GE = -10 * ones(length(GE), 1);
    end

    E = [PE, KE, TE, IE, GE];

    function pe = potential_energy(theta1, theta2)
        pe = potential_energy1(theta1) + potential_energy2(theta1, theta2);
    end

    function ke = kinetic_energy(theta1, theta2, omega1, omega2)
        ke = kinetic_energy1(theta1, omega1) + kinetic_energy2(theta1, omega1, theta2, omega2);
    end

    function res = potential_energy1(theta1)
        res = m1 * g * l1 * -cos(theta1);
    end

    function res = potential_energy2(theta1, theta2)
        res = -m2 * g * (l1 * cos(theta1) + l2 * cos(theta2));
    end

    function res = kinetic_energy1(theta1, omega1)
        vx = omega1 .* l1 .* cos(theta1);
        vy = omega1 .* l1 .* sin(theta1);
        res = 0.5 .* m1 .* (vx.^2 + vy.^2);
    end

    function res = kinetic_energy2(theta1, omega1, theta2, omega2)
        vx = omega1 .* l1 .* cos(theta1) + omega2 .* l2 .* cos(theta2);
        vy = omega1 .* l1 .* sin(theta1) + omega2 .* l2 .* sin(theta2);
        res = 0.5 .* m2 .* (vx.^2 + vy.^2);
    end
end
