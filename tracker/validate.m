function [T Y1 Y2] = validate
   
    %   Analyzes tracker data from knee_txy.csv and torso_txy.csv  
    %   T  outputs time
    %   Y1 outputs first-order results:  [Theta1 Theta2 Amplitude]
    %   Y2 outputs second-order results: [Vx_torso Vy_torso Vx_knee Vy_knee
    %   KE PE TE]
    %
    %   (c) 2015 Trent Dye
    %

    clf;
    hold on;
    load knee_txy.csv;
    load torso_txy.csv;
    Knee = knee_txy;
    Torso = torso_txy;
    
    m_knee = 22.88;
    m_torso = 27.02;
    g = 9.8;
    
    T = Torso(:, 1);
    kneeX = Knee(:, 2);
    kneeY = Knee(:, 3);
    torsoX = Torso(:, 2);
    torsoY = Torso(:, 3);
    
    Theta1 = zeros(1, length(T));
    Theta2 = zeros(1, length(T));
    Amplitude = zeros(1, length(T));
    
    Vx_knee = zeros(1, length(T)-1);
    Vy_knee = zeros(1, length(T)-1);
    Vx_torso = zeros(1, length(T)-1);
    Vy_torso = zeros(1, length(T)-1);
    KE = zeros(1, length(T)-1);
    PE = zeros(1, length(T)-1);
    TE = zeros(1, length(T)-1);
    
    
    for i = 1:length(T)
        Theta1(i) = atan2(torsoY(i),torsoX(i));
        Theta2(i) = atan2((kneeY(i)-torsoY(i)),(kneeX(i)-torsoX(i)));
        Amplitude(i) = Theta2(i)-Theta1(i);
    end

    disp(Theta1)

    for i = 1:(length(T)-1)
        dt = T(i+1) - T(i);
        Vx_knee(i) = (kneeX(i+1)-kneeX(i))/dt;
        Vy_knee(i) = (kneeY(i+1)-kneeY(i))/dt;
        Vx_torso(i) = (torsoX(i+1)-torsoX(i))/dt;
        Vy_torso(i) = (torsoY(i+1)-torsoY(i))/dt;
        KE(i) = .5 * m_knee * (Vx_knee(i)^2 + Vy_knee(i)^2) + .5 * m_torso * (Vx_torso(i)^2 + Vy_torso(i)^2);
        PE(i) = m_knee*g*kneeY(i) + m_torso*g*torsoY(i);
        TE(i) = KE(i)+PE(i);
    end
    Y1 = [Theta1.' Theta2.' Amplitude.'];
    Y2 = [Vx_torso.' Vy_torso.' Vx_knee.' Vy_knee.' KE.' PE.' TE.'];
end