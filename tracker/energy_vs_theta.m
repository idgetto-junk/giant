function energy_vs_theta
    clf;
    hold on;
    LIM = [29:91]
    [T Y1 Y2] = validate();
    Kinetic_Energy = Y2(:, 5);
    Kinetic_Energy = Kinetic_Energy(LIM);
    Potential_Energy = Y2(:, 6);
    Potential_Energy = Potential_Energy(LIM);
    Total_Energy = Y2(:, 7);
    Total_Energy = Total_Energy(LIM)
    %Total_Energy = sgolayfilt(Total_Energy, 3, 61);
    Time = T;
    Time = T(LIM);
    Theta = Y1(:,1);
    Theta = Y1(LIM);
    plot(Theta, Total_Energy, 'r');
    %plot(Theta, Kinetic_Energy, 'g');
    %plot(Theta, Potential_Energy, 'b');
    disp(Theta);
    title('Kinetic, Potential, and Total Energies vs. Rotation')
    xlabel('\theta_1 (rad)')
    ylabel('Energy (j)')
end