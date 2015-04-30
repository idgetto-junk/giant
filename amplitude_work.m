function [A, W] = amplitude_work
    A = linspace(0, 0.2, 100);
    for index = 1:length(A)
        W(index) = gymnast_work(A(index));
        index
    end

    W1 = zeros(1, 1);
    A1 = zeros(1, 1);

    count = 1;
    for ind = 1:length(A)
        if W(ind) > 0
            W1(count) = W(ind);
            A1(count) = A(ind);
            count = count + 1;
        end
    end

    clf;
    plot(A1, W1, 'LineWidth', 4);
    xlim([0, 0.19]);

    xlabel('amplitude (rads)');
    ylabel('work (J)');
    title('kick amplitude vs. gymnast input work');

    function res = gymnast_work(amp)
        [T, E] = giant_energy_amp(A(index));
        GE = E(:, 5);
        res = GE(end);
    end
end
