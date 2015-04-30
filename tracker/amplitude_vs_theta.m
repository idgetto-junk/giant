function amplitude_vs_theta
    clf;
    hold on;
    LIM = [29:91]
    [T Y1 Y2] = validate();
    Amplitude = Y1(:, 3)
    Amplitude = Amplitude(LIM);
    Theta = Y1(:,1);
    Theta = Theta(LIM)
    plot(Theta, Amplitude, 'r');
    title('Kick Amplitude vs. Rotation')
    xlabel('Theta (rad)')
    ylabel('Kick Amplitude (rad)')
end