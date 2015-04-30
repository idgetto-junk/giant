function body_proportion_plot()
    propmin = 0;
    propmax = 1.5;
    propstep = .01;
    clf;
    hold on;
    for i=propmin:propstep:propmax
        total_time = body_proportion_crunch(i);
        plot(i, total_time, 'r.')
    end
    title('Mass Proportion vs. Time to Complete One Revolution');
    xlabel('Mass Proportion');
    ylabel('Time (s)');
end