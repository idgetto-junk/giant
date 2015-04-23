function giant_energy_plot
% GIANT_ENERGY_PLOT - plot the energy stocks of the giant system
%
% Author: Isaac Getto
% email address: isaac.getto@students.olin.edu
% April 2015

    [T, E] = giant_energy;
    PE = E(:, 1);
    KE = E(:, 2);
    TE = E(:, 3);

    clf;
    hold on;
    plot(T, PE, '-bs', 'LineWidth', 3);
    plot(T, KE, '-ro', 'LineWidth', 3);
    plot(T, TE, 'k', 'LineWidth', 3);

    xlim([0, 1.0]);
end
