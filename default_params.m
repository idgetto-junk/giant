function res = defaults_params
    total_mass = 69;
    m1_prop = 0.5415;
    m2_prop = 0.4558;
    m1 = m1_prop * total_mass;
    m2 = m2_prop * total_mass;

    total_height = 1.56;
    l1_prop = 0.4025;
    l2_prop = 0.5975;
    l1 = total_height * l1_prop;
    l2 = total_height * l2_prop;

    keys = {'m1', 'm2', 'l1', 'l2', 'uk', 'amp', 'theta0', 'phase', 'frequency',  'center_of_rotation', 'anim'};
    vals = {m1, m2, l1, l2, 1, .57, -pi, 0, 2, .57, 0};
    res = containers.Map(keys, vals);
end
