%
% Parameters that should be allocated before the script is called.
% delta_angle, r_ang, r_pos, movedist
% Return values
% delta_angle
%
% localScan  - returns the scanned distances in ndirs directions.
% -----------
% needs - delta_angle, r_ang, r_pos, ndirs
% returns r_scan_dist - will contain 'ndirs' dimensions.
%
% The value 10 is used to account for the padding around the map.
% The padded map has a padding of 5 cm. But we've given the value 10
% cos the robot, when at an angle, needs to be set further apart from the wall.
% To make it simple for us, we've just put 10 cm for all angles.
%

inside = OUT_MAP;

turn_angle = 0.7854;		% 45 deg
alt_turn_angle = 0.3491;	% 20 deg

min_ang = 0.0873;		
max_ang = 0.2618;		% 15 deg

delta_angle = (rand()*max_ang) + min_ang;
%  delta_angle = min_ang;
ndirs = 18;

min_dist = 5;
max_dist = 15;

while(1)
  localScan;
  delta_dist = (rand()*max_dist) + min_dist;
%    delta_dist = 10;
  del_ind = 0;
  r_scan_dist = r_scan_dist - 10;			% Note: See comment in the comments section.
  pickPriorityAng;
  
  if(del_ind ~= 0)			% We can move delta_dist length along one of the 'priority angles' directions.
    break;
  end
  
  delta_angle = delta_angle + alt_turn_angle;
end

movedist = delta_dist;
delta_angle = ((del_ind - 1) * turn_angle) + delta_angle; 		% times 45deg
