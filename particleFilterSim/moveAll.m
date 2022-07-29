% For robotRepos
% ---------------
% Parameters that should be allocated before the script is called.
% r_ang, r_pos
%
robotRepos;				% We get the new delta_angle and movedist from here.

inside = checkPoint(delta_angle, r_ang, r_pos, movedist, pad_map_lines, pad_inpolygonMapformatX, pad_inpolygonMapformatY);

[r_ang r_dir] = turn(r_ang, delta_angle, r_dir, r_turningNoise);
[spos_new sang sdir] = move(r_pos, r_ang, r_dir, movedist, motionNoise, turningNoise);
spos = r_pos;

sdist = movedist;

% sang, spos, sdir, sdist needs to be allocated for slide to work.
if(~inside)
  callSlide;
  r_pos = move_pt;
else
  r_pos = spos_new;
end

%--------------------------PARTICLES MOVEMENT------------------------------------
for ind = 1:nparticles

  inside = checkPoint(delta_angle, ang(ind), pos(ind, :), movedist, pad_map_lines, pad_inpolygonMapformatX, pad_inpolygonMapformatY);			    
  [ang(ind) dir(ind, :)] = turn(ang(ind), delta_angle, dir(ind, :), turningNoise);

  if (inside == IN_MAP)
    [pos(ind, :) ang(ind) dir(ind, :)] = move(pos(ind, :), ang(ind), dir(ind, :), movedist, motionNoise, turningNoise);
  else
    sang = ang(ind);
    spos = pos(ind, :);
    sdir = dir(ind, :);
    sdist = movedist;

    % sang, spos, sdir, sdist needs to be allocated for slide to work.
    callSlide;
    pos(ind, :) = move_pt;
  end
end




