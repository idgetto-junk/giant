function body_proportion_plot()
    propmin = 0.5;
    propmax = 1.5;
    propstep = .01;
    clf;
    hold on;
    for i=propmin:propstep:propmax
        omega_final = body_proportion_crunch(i);
        plot(i, omega_final, 'ro')
    end
end