function [T, Y] = giant_ode_frictionless
% GIANT_ODE_FRICTIONLESS - calculates the angle and angular velocity of a double pendulum over time (no friction)
%
% Outputs:
%    T - a vector of times
%    Y - a matrix of thetas and omegas
%
% Author: Isaac Getto
% email address: isaac.getto@students.olin.edu
% April 2015

    params = containers.Map({'uk'}, {0});
    [T, Y] = giant_ode(params);

end
