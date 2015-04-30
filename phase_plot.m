function phase_plot()
    phase_min = -1;
    phase_max = 1;
    phase_step = .01;
    clf;
    hold on;
    for i=phase_min:phase_step:phase_max
        total_time = phase_crunch(i);
        plot(i, total_time, 'r.')
    end
    title('Phase Shift vs. Time to Complete One Revolution');
    xlabel('Phase Shift (rad)');
    ylabel('Time (s)');
end