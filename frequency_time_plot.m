function frequency_time_plot

    F = linspace(0, 6, 100);
    for index = 1:length(F)
        index
        [T, Y] = giant_ode_frequency(F(index));
        
        if Y(end, 1) >= pi
            time = T(end);
        else
            time = 0;
        end

        Time(index) = time;
    end

    clf;
    plot(F, smooth(Time, 10), 'LineWidth', 4);

    title('Kick Frequency vs. Time to Complete One Revolution');
    xlabel('Kick Frequency');
    ylabel('Time (s)');
end
