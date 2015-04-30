function energy_vs_time
    clf;
    hold on;
    [T Y1 Y2] = validate();
    Kinetic_Energy = Y2(:, 5);
    Potential_Energy = Y2(:, 6);
    Total_Energy = Y2(:, 7);
    Energy = smooth(Total_Energy);
    Time = T(1:length(Total_Energy));
    Theta = Y1(:,1);
    Theta = Theta(1:length(Total_Energy));
    plot(Time, Total_Energy, 'r');
    plot(Time, Kinetic_Energy, 'g');
    plot(Time, Potential_Energy, 'b');
    title('Kinetic, Potential, and Total Energies vs. Time')
    xlabel('Time (s)')
    ylabel('Energy (j)')
end