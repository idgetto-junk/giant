function [T, M] = giant_ode_frictionless_amp(amp)
    
    defaults = default_params;
    defaults('uk') = 0;
    defaults('m2') = defaults('m1') * prop;

    [T, Y] = giant_ode(defaults);
end
