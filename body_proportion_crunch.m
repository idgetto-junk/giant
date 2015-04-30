function res = body_proportion_crunch(prop)
    [T, Y] = giant_ode_body_proportion(prop);
    Theta = Y(:, 1);
    Omega1 = Y(:, 2);
    res = 1;

    if Theta(end) >= pi
        res = T(end);
    else
        res = 0;
    end
end
