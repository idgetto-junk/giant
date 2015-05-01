function giant_energy_plot
% GIANT_ENERGY_PLOT - plot the energy stocks of the giant system
%
% Author: Isaac Getto
% email address: isaac.getto@students.olin.edu
% April 2015

    [T, E, Theta] = giant_energy;
    PE = E(:, 1);
    KE = E(:, 2);
    TE = E(:, 3);
    IE = E(:, 4);

    clf;
    hold on;
    plot(Theta, PE, '-bs', 'LineWidth', 3);
    plot(Theta, KE, '-ro', 'LineWidth', 3);
    plot(Theta, TE, 'k', 'LineWidth', 3);
    plot(Theta, IE, '--k', 'LineWidth', 3);

    xlabel('\theta_1 (rad)');
    ylabel('Energy (J)');
    title('Energy vs. \theta_1');
    legend('Potential Energy', 'Kinetic Energy', 'Total Energy');

    xlim([-pi, pi]);


end
