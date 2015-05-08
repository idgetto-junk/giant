function res = friction_time_optimal
    res = fminsearch(@error_func, [0; 0; 0]);

    function error = error_func(X)
        [T, Y] = giant_ode(containers.Map({'uk', 'phase', 'center_of_rotation'}, {X(1), X(2), X(3)}));
        
        if Y(end, 1) >= pi
            time = T(end);
        else
            time = 0;
        end

        if X(1) <= 0
            error = Inf;
            return;
        end

        error = (2.07 - time)^2;
    end
end
