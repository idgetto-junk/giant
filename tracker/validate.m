function res = validate
    % TURN THIS INTO AMPLITUDE VS. THETA AND TOTAL ENERGY VS. THETA
    clf;
    hold on;
    load knee2.csv;
    load torso2.csv;
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
    %plot(Theta1, 'r');
    %plot(Theta2,  'g');
    plot(Amplitude, 'b');
  %  plot(Amplitude);
    period = 3.04-0.968;
    disp(period);
end