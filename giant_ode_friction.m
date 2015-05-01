function [T, Y] = giant_ode_friction(uk)
% GIANT_ODE_AMP - calculates the angle and angular velocity of a double pendulum over time with a given amplitude of leg swing
%
% Inputs:
%   amplitude - the amplitude of the gymnasts leg swing
%
% Outputs:
%    T - a vector of times
%    Y - a matrix of thetas and omegas
%
% Author: Isaac Getto
% email address: isaac.getto@students.olin.edu
% April 2015
    m1 = 27.02;
    m2 = 22.88;
    L1 = 1.549 * 40.25;
    L2 = 1.549 - L1;
    [T, Y] = giant_ode(containers.Map({'uk', 'm1', 'm2', 'L1', 'L2', 'amp', 'center_of_rotation'} , {uk, m1, m2, L1, L2, .6071, .5589} ));
end
