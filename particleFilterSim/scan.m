%---------------------------------------------------
% 20 SCANS (360deg) with a 18deg gap.
% Get the crossing points and distances along scan lines for the robot and all particles
%---------------------------------------------------

botpos = r_pos(1, :);
botang = r_ang;

ultraScan;
r_scan_dist = distances;

for ind = 1:nparticles
  botpos = pos(ind, :);
  botang = ang(ind);
  ultraScan;
  scan_dist(:, ind) = distances;
  cross_pts(ind, :, :) = crossingPoints;
end


  



