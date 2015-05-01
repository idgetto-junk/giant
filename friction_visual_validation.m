function friction_visual_validation
    addpath('tracker')
    clf;
    hold on;
    
    [T_real Y1_real Y2_real] = validate();
    [T_model Y_model] = giant_ode_friction(.97);
    
    theta_real = Y1_real(:, 1);
    theta_model = Y_model(:, 1);
    
    plot(T_real, theta_real, 'r');
    plot(T_model+.9, theta_model, 'g');
    
    xlabel('Time (sec)');
    ylabel('\theta_1 (rad)');
    title('Rotation vs. Time, Model and Video');
    
    rmpath('tracker')  
end