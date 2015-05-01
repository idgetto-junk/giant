function [C, T] = center_of_rotation_time_plot


    C = linspace(-pi, pi, 100);

    O = zeros(length(C), 1); 
    for index = 1:length(C)
        index
        O(index) = center_of_rotation_time(C(index));
    end

    clf 
    hold on;
    plot(C, O, 'LineWidth', 4);
    xlabel('Center of Rotation (rad)');
    ylabel('Rotational Period (s)')
    title('Center of Rotation vs. Rotational Period');

    function time = center_of_rotation_time(cor)
        [T, M] = giant_ode(containers.Map({'amp', 'center_of_rotation'}, {1, cor}));
        time = top_time(T, M); 
    end

    function res = top_index(M)
        res = -1;
        if M(end, 1) < pi
            res = -1;
            return;
        else
            res = length(M);
        end
    end

    function time = top_time(T, M)
       ti = top_index(M);
       if ti == -1
           time = Inf;
       else
           time = T(ti);
       end
    end
end
