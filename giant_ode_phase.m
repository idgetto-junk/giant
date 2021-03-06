function [T, Y] = giant_ode_phase(phase_shift)
% GIANT_ODE - calculates the angle and angular velocity of a double pendulum over time
%
% Outputs:
%    T - a vector of times
%    Y - a matrix of thetas and omegas
%
% Author: Isaac Getto
% email address: isaac.getto@students.olin.edu
% April 2015

    params = containers.Map({'phase'}, {phase_shift});
    [T, Y] = giant_ode(params);

end
