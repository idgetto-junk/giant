function res = validate_amplitudevstheta
    % TURN THIS INTO AMPLITUDE VS. THETA AND TOTAL ENERGY VS. THETA
    clf;
    hold on;
    load knee2.csv;
    load torso2.csv;
    m_knee = 1;
    m_torso = 1;
    g = 9.8;
    T = knee2(:, 1);
    kneeX = knee2(:, 2);
    kneeY = knee2(:, 3);
    torsoX = torso2(:, 2);
    torsoY = torso2(:, 3);
    for i = 1:length(T)
        Theta1(i) = atan2(torsoY(i),torsoX(i));
        Theta2(i) = atan2((kneeY(i)-torsoY(i)),(kneeX(i)-torsoX(i)));
        Amplitude(i) = Theta2(i)-Theta1(i);
    end
    theta_vs_te = zeros(length(T)-1,2);
    for i = 1:(length(T)-1)
        dt = T(i+1) - T(i);
        Vx_knee(i) = (kneeX(i+1)-kneeX(i))/dt;
        Vy_knee(i) = (kneeY(i+1)-kneeY(i))/dt;
        Vx_torso(i) = (torsoX(i+1)-torsoX(i))/dt;
        Vy_torso(i) = (torsoY(i+1)-torsoY(i))/dt;
        KE(i) = .5 * m_knee * (Vx_knee(i)^2 + Vy_knee(i)^2) + .5 * m_torso * (Vx_torso(i)^2 + Vy_torso(i)^2);
        PE(i) = m_knee*g*kneeY(i) + m_torso*g*torsoY(i);
        TE(i) = KE(i)+PE(i);
        theta_vs_te(i,:) = [Theta1(i), TE(i)];
    end
    plotTo = 70; %(max = 169)
    amplitudevstheta = zeros(plotTo, 2);
    for i = 1:plotTo
        amplitudevstheta(i, :) = [Theta1(i), Amplitude(i)];
    end
    sorted = sortrows(amplitudevstheta,1);
    disp(sorted);
    plot(sorted(:, 1), sorted(:, 2));
    xlabel('Theta (rad)');
    ylabel('Kicking Amplitude (rad)');
    title('Kicking Amplitude vs. Theta');
    period = 3.04-0.968;
    disp(length(T));
end