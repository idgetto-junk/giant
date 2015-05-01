function [amp, cor, phase] = optimal_amp_cor

    clf;
    hold on;

    amp0 = 0.6;
    cor0 = amp0;
    phase0 = .2;
    X = fminsearch(@error_func, [amp0, cor0, phase0]);

    amp = X(1);
    cor = X(2);
    phase = X(3);

    function error = error_func(X)
        a = X(1);
        c = X(2);
        p = X(3);

        if a + abs(c) > pi/2
            error = Inf;
            return;
        end

        error = (2.169 - rotation_time(a, c, p))^2;
    end

    function time = rotation_time(amp, cor, phase)
        [T, M] = giant_ode(containers.Map({'amp', 'center_of_rotation', 'phase'}, {amp, cor, phase}));
        time = top_time(T, M); 
    end

    function time = top_time(T, M)
       if M(end, 1) < pi
           time = Inf;
       else
           time = T(end);
       end
    end
end
