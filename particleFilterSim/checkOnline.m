%------------
% sort_index contains the indices of all the intersecting map lines in sorted order (asc order)
%
% If I'm on a line and trying to move outside, stay on the line.
% If I'm at a corner, move 1 cm away from the corner; but stay within the padded map.
% If I'm on a line and trying to move inside, move 1cm away from the line; but stay within the padded map.
%----------
if(sort_distSQ(1) == 0 && ~isnan(sort_distSQ(2)))	% If intersecting more than one line and I'm on the nearest intersected line
  delta_angle = sang;
  botang = 0;
  botpos = bumps(sort_index(1), :);			
  movedist = 1;

  newang = delta_angle + botang;
  newdir = [cos(newang) sin(newang)];
  newpos = botpos + (newdir * movedist);
  
  
  inside = inpolygon(newpos(1), newpos(2), pad_inpolygonMapformatX, pad_inpolygonMapformatY);
  
  if(inside)				% This a 1 cm check along the direction its trying to move in.
    spos = newpos;			% If inside, Move it by 1 cm along the direction of movement, away from the map line.
    option = -1;
  else
    if(sort_distSQ(2) == 0)				% At a corner
      spos = moveFromCorner(botpos, pad_inpolygonMapformatX, pad_inpolygonMapformatY);
      option = -1;
    else
      option = 1;
    end
  end

end

