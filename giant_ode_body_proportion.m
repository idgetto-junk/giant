function [T, Y] = giant_ode_body_proportion(prop)
% GIANT_ODE - calculates the angle and angular velocity of a double pendulum over time
%
% Outputs:
%    T - a vector of times
%    Y - a matrix of thetas and omegas
%
% Author: Isaac Getto
% email address: isaac.getto@students.olin.edu
% April 2015

    defaults = default_params;
    defaults('m2') = defaults('m1') * prop;

    [T, Y] = giant_ode(defaults);

end
