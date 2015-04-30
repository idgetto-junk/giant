function [X, Y, C] = amplitude_phase_velocity
    A = linspace(-pi/2, pi/2, 20);
    P = linspace(-1, 5, 20);

    C = zeros(size(A, 1), size(A, 2));
    for row = 1:length(A)
        for col = 1:length(P)
           [row, col]
           C(row, col) = time(A(row), P(col));
       end
    end

    X = A;
    Y = P;

    function res = time(amp, phase)
        [T, M] = giant_ode(containers.Map({'amp', 'phase'}, {amp, phase}));
        if M(end, 1)  < pi
            res = 0;
        else
            res = T(end);
        end
    end

end
