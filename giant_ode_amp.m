function [T, Y] = giant_ode_amp(amplitude)
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

    [T, Y] = giant_ode(containers.Map({'amp'}, {amplitude}));

end
