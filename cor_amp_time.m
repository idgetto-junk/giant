function [X, Y, C] = cor_amp_time
    COR = linspace(-4, 6, 100);
    AMP = linspace(1, 3.5, 100);

    C = zeros(size(COR, 1), size(COR, 2));
    for row = 1:length(COR)
        for col = 1:length(AMP)
           [row, col]
           C(row, col) = time(COR(row), AMP(col));
       end
    end

    X = COR;
    Y = AMP;

    function res = time(cor, amp)
        [T, M] = giant_ode(containers.Map({'center_of_rotation', 'amp'}, {cor, amp}));
        if M(end, 1)  < pi
            res = Inf;
        else
            res = T(end);
        end
    end

end
