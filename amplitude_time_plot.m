function [A, O] = amplitude_omega_plot


    A = linspace(0, pi/2, 10);

    O = zeros(length(A), 1); 
    for index = 1:length(A)
        O(index) = amplitude_time(A(index));
    end

    clf 
    hold on;
    plot(A, O, 'LineWidth', 4);
    xlabel('kick amplitude');
    ylabel('time (s)')
    title('time vs. kick amplitude');

    [time, index] = max(O);
    top_amp = A(index);
    plot(top_amp, time, '.r', 'MarkerSize', 40);
    s = strcat('(', num2str(top_amp), ', ', num2str(time), ')');
    text(top_amp + 0.02  * top_amp, time + 0.02  * time, s, 'FontSize', 14);

    m = min(O)
    
    function time = amplitude_time(amplitude)
        [T, M] = giant_ode_amp(amplitude);
        time = top_time(T, M); 
    end

    function res = top_index(M)
        res = -1;
        if M(end, 1) > -pi
            res = -1;
            return;
        end
        for i = 1:length(M)
            if M(i, 1) <= -pi
                res = i;
            end
        end
    end

    function omega = top_omega(M)
       ti = top_index(M);
       if ti == -1
           omega = -Inf;
       else
           omega = abs(M(ti, 2));
       end
    end

    function time = top_time(T, M)
       ti = top_index(M);
       if ti == -1
           time = -Inf;
       else
           time = T(ti);
       end
    end
end
