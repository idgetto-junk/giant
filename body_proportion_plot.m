function body_proportion_plot()
    propmin = 0;
    propmax = 1.5;
    propstep = .01;
    clf;
    hold on;
    for i=propmin:propstep:propmax
        omega_final = body_proportion_crunch(i);
        plot(i, omega_final, 'r.')
    end
    title('Mass Proportion vs. Time to Complete One Revolution');
    xlabel('Mass Proportion');
    ylabel('Time (s)');
end