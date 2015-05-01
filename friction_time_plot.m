function friction_time_plot
    clf;
    hold on;
    
    F = linspace(0, 1.5, 1000);
    for index = 1:length(F)
        index
        [T, Y] = giant_ode_friction(F(index));
        
        if Y(end, 1) >= pi
            time = T(end);
        else
            time = 0;
        end

        Time(index) = time;
    end

    clf;
    plot(F, Time, 'LineWidth', 4);
    %plot(2.169);
    
    title('Coefficient of Friction vs. Rotational Period');
    xlabel('Coefficient of Friction F/v^2');
    ylabel('Rotational Period');
end
