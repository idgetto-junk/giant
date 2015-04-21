function res = body_proportion_crunch(prop)
    [T, Y] = giant_ode_body_proportion(prop);
    Theta = Y(:, 1);
    Omega1 = Y(:, 2);
    res = 1;
    for i = 1:length(T)
        if Y(i) <= -pi
            res = abs(Omega1(i));
        else
            res = 0;
        end
    end
end