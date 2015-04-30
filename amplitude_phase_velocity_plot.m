function amplitude_phase_velocity_plot
    [X, Y, C] = amplitude_phase_velocity;

    clf;
    surf(X, Y, C);
    xlabel('Amplitude (rads)');
    ylabel('Phase (rads)');
end
