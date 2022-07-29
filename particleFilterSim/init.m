%---------------------------------------------------
% All particles have 0 weights in the beginning, random angles.
% Position of particles is based on the pad_len distance set in genParticlePos.
%---------------------------------------------------

% Initialise Robot
%  r_pos = [10 10];
r_pos = S;
r_ang = degtorad(90);
r_dir = [cos(r_ang) sin(r_ang)];

option = DRAW_ROBOT;
drawBot;

% Iniitialise Particles
scanOffset = [0 0];
generateScanConfig;			% sets scanConfig

sensorNoise = 0;  %constant noise model. Error standard deviation in cm
motionNoise = 0;  %proportional noise model. cm error stdDev per unit length in cm/cm
turningNoise = 0; %porportional noise model. Radian stdDev error per radian rad/rad

pos = plot_point;			% plot_point is the output of genParticlePos

angle = rand(nparticles, 1) * 360;
angle = round(angle);

ang = degtorad(angle);
dir = [cos(ang) sin(ang)];

option = DRAW_PARTICLE;
drawBot;
