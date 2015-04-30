function res = phase_crunch(phase)
    [T, Y] = giant_ode_phase(phase);
    Theta = Y(:, 1);
    res = 1;
    for i = 1:length(T)
        if Theta(i) <= pi
            res = T(i);
        else
            res = 0;
        end
    end
end