function [res, val] = optimal_amplitude
% OPTIMAL_AMPLITUDE - finds the aplitude of the gymnast's leg swing that allows for him to just perform a full rotation around the bar
%
% Outputs:
%    res - the amplitude of the gymnast's leg swing
%
% Author: Isaac Getto
% email address: isaac.getto@students.olin.edu
% April 2015

    initial_amplitude = pi/2;% 0.75;

    clf;
    hold on;
    options = optimset('MaxFunEvals', 1E6, 'MaxIter', 1E6);
    [res, val] = fminsearch(@error_func, initial_amplitude, options);

    % look for the amplitude that produces the 
    % greates number of rotations around the bar
    function error = error_func(amplitude)
        if amplitude > pi/2
            error = Inf;
            return;
        end
        [T, M] = giant_ode_amp(amplitude);
        omega = top_omega(M);
        error = omega;
        plot(amplitude, omega, 'rx', 'MarkerSize', 10);
        drawnow;
    end

    function res = top_index(M)
        if M(end, 1) < pi
            res = -1;
            return;
        end

        res = -1;
        for index = 1:length(M)
            if M(index, 1) >= pi
                res = index;
            end
        end
    end

    function omega = top_omega(M)
       ti = top_index(M);
       if ti == -1
           omega = Inf;
       else
           omega = M(ti, 2)^2; 
       end
    end
end
