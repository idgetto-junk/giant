function [T, E] = giant_energy
% GIANT_ENERGY - calculate the energy stocks of the giant system
%
% Outputs:
%    T - time vector
%    E - matrix of PE, KE, and TE
%
% Author: Isaac Getto
% email address: isaac.getto@students.olin.edu
% April 2015
    
    % constants
    m1 = 1;
    m2 = 0.65;
    l1 = 1;
    l2 = 1;
    g = 9.8;

    [T, M] = giant_ode;

    T1 = M(:, 1); % vector of theta1
    T2 = M(:, 3); % vector of theta2
    O1 = M(:, 2); % vector of omega1
    O2 = M(:, 4); % vector of omega2

    PE = potential_energy(T1, T2);
    KE = kinetic_energy(T1, T2, O1, O2);
    TE = PE + KE;

    E = [PE, KE, TE];

    function pe = potential_energy(theta1, theta2)
        bob1_height = l1 .* -cos(theta1);
        bob1_energy = m1 .* g .* bob1_height;     

        bob2_height = l1 .* -cos(theta1) + l2 .* -cos(theta2);
        bob2_energy = m2 .* g .* bob2_height;     

        pe = bob1_energy + bob2_energy;
    end

    function ke = kinetic_energy(theta1, theta2, omega1, omega2)
        bob1_vx  = omega1 .* l1 .* cos(theta1);
        bob1_vy  = omega1 .* l1 .* sin(theta1);
        bob1_speed = sqrt(bob1_vx.^2 + bob1_vy.^2);
        bob1_energy = 0.5 .* m1 .* bob1_speed.^2;

        bob2_vx  = omega1 .* l1 .* cos(theta1) + omega2 .* l2 .* cos(theta2);
        bob2_vy  = omega1 .* l1 .* sin(theta1) + omega2 .* l2 .* sin(theta2);
        bob2_speed = sqrt(bob2_vx.^2 + bob2_vy.^2);
        bob2_energy = 0.5 .* m2 .* bob2_speed.^2;

        ke = bob1_energy + bob2_energy;
    end
end
