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
    plot(T, PE, '-bs', 'LineWidth', 3);
    plot(T, KE, '-ro', 'LineWidth', 3);
    plot(T, TE, 'k', 'LineWidth', 3);
    plot(T, IE, '--k', 'LineWidth', 3);

    xlabel('time (s)');
    ylabel('energy (J)');
    title('Energy vs. Time');
    legend('Potential Energy', 'Kinetic Energy', 'Total Energy');

    xlim([0, 2.5]);


end
