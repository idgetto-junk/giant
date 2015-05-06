function phase_time_plot

    P = linspace(-pi, 1,  500);
    for index = 1:length(P)
        [T, Y] = giant_ode_phase(P(index));
        
        if Y(end, 1) >= pi
            time = T(end);
        else
            time = 0;
        end

        Time(index) = time;
    end

    clf;
    plot(P, Time, 'LineWidth', 4);

    title('Phase Shift vs. Time to Complete One Revolution');
    xlabel('Phase Shift (rad)');
    ylabel('Time (s)');
end
