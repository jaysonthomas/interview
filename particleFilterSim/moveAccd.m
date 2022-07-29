%
% No checks are made within the function to find out if the path jumps over walls.
% The bot is the origin.
%  1. Find in which quadrant the bot is moving towards.
%  2. Find angle.
%  3. Make change to current angle.
%  4. Move towards goal.
%

src = path(i, :);
goal = path(i+1, :);

%  function [dest angle direction] = moveAccd(src, goal, angle, direction)

if(goal(1) > src(1) && goal(2) > src(2))		% Quadrant 1: 0 - 90 deg
    d0 = atan2(goal(2) - src(2), goal(1) - src(1));
  elseif(goal(1) < src(1) && goal(2) > src(2))		% Quadrant 2: 90 - 180 deg
    d0 = atan2(goal(2) - src(2), src(1) - goal(1));
    d0 = (pi/2 - d0) + pi/2;
  elseif(goal(1) < src(1) && goal(2) < src(2))		% Quadrant 3: 180 - 270 deg
    d0 = atan2(src(2) - goal(2), src(1) - goal(1));
    d0 = d0 + pi;
  elseif(goal(1) > src(1) && goal(2) < src(2))		% Quadrant 4: 270 - 360 deg
    d0 = atan2(src(2) - goal(2), goal(1) - src(1));
    d0 = (pi/2-d0) + 4.7124;
  elseif(goal(2) == src(2))				% On the X-axis
    if(goal(1) >= src(1))					% Positive side - 0
      d0 = 0;
    else							% Negative - 180 deg
      d0 = pi;
    end
  elseif(goal(1) == src(1))
    if(goal(2) >= src(2))					% On the Y-axis
      d0 = pi/2;						% Positive side - 90 deg
    else							% Negative - 270 deg
      d0 = 4.7124;
    end
  end

  move_dist = sqrt((src(1) - goal(1))^2 + (src(2) - goal(2))^2);

  d0 = (2*pi - angle) + d0;
  [angle direction] = turn(angle, d0, direction, 0);
  [dest angle direction] = move(src, angle, direction, move_dist, 0, 0);
  
%  end