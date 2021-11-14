% This function calculates the required delta-v's for a phasing orbit
% relative to a geostationary target

function [delta_v_phase_1, delta_v_phase_2, delta_v_phase_total, Tphase] = geoPhase(nPeriods, dlong, r_a_initial, r_p_initial, hB_3,apogeeBurn)
    
    

    omega_geo = 7.292123516990375e-05; % angular velocity of geostationary orbit (m/s)
    mu = 3.986004418e+14; % standard gravitational parameter for Earth (m^3/s^2)

    TB_phase = (nPeriods*2*pi + dlong)/(nPeriods*omega_geo); % period of phaser (s)
    aB_phase = ((mu*TB_phase^2)/(4*pi^2))^(1/3); % semi-major axis (m)
    
    % Check where the burn occurs
    if apogeeBurn == true
        r_p_phase = r_a_initial; % the perigee of the phaser is the apogee of initial orbit (m)
    else
        r_p_phase = r_p_initial; % the perigee of the phaser is the perigee of initial orbit (m)
    end
    
    r_aB_phase = 2*aB_phase - r_p_phase; % apogee of transfer orbit (m)
    eB_phase = (r_aB_phase - r_p_phase)/(r_aB_phase + r_p_phase); % eccentricity of phaser 

    hB_phase = sqrt(mu*aB_phase*(1 - eB_phase^2)); % angular momentum of phaser (m^2/s)

    % Now calculate the velocities required to compute the delta-v
    vB_initial_apogee = hB_3/r_a_initial; % the initial orbit, orbit 3's, velocity at apogee (m/s)
    v_B_phase = hB_phase/r_p_phase; % velocity required for phaser (m/s)

    % Calculate the delta-v's, and the net delta-v for phasing
    delta_v_phase_1 = v_B_phase - vB_initial_apogee; % delta-v for first burn (m/s)
    delta_v_phase_2 = -(v_B_phase - vB_initial_apogee); % delta-v for first burn (m/s)

    delta_v_phase_total = abs(delta_v_phase_1) + abs(delta_v_phase_2); % net delta-v for phaser
 
    Tphase = TB_phase;

end