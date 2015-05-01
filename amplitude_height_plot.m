function [A, O] = amplitude_height_plot

    defaults = default_params;
    l1 = defaults('l1');

    A = linspace(0, pi/2, 400);

    O = zeros(length(A), 1); 
    for index = 1:length(A)
        index
        O(index) = amplitude_height(A(index));
    end

    clf;
    hold on;
    plot(A, O, 'LineWidth', 4);
    xlabel('Kick Amplitude (rad)');
    ylabel('Maximum Height (m)');
    title('Kick Amplitude vs. Maximum Height');

    max(O)

    function h = amplitude_height(amplitude)
        [T, M] = giant_ode(containers.Map({'amp', 'center_of_rotation'}, {amplitude, amplitude}));
        h = height(M(:, 1));
    end

    function res = height(theta)
        mtheta = max(theta)
        % if (mtheta < 0)
        %     res = -Inf
        % else
            res = l1 * -cos(mtheta);
        % end
    end

end
