function cor_amp_time_plot
    [X, Y, C] = cor_amp_time

    clf;
    hold on;
    pcolor(X, Y, C);

    [minNum, minIndex] = min(C(:));
    [row, col] = ind2sub(size(C), minIndex);

    plot(X(row), Y(col), 'r.', 'MarkerSize', 40);

    xlabel('Center of Rotation (rads)');
    ylabel('Amplitude (rads)');
    colorbar;
end
