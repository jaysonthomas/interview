%------------------------------
% First updates the angle and position to local variables and checks on them.
% Checks if the new position is within the padded map.
% If yes, checks if there is any wall (of the padded map) between the robot and the new position.
% checkPoint works on the old position of the bot.
%------------------------------
function inside = checkPoint(delta_angle, botang, botpos, movedist, pad_map_lines, pad_inpolygonMapformatX, pad_inpolygonMapformatY)

  IN_MAP = 1;
  OUT_MAP = 0;
  
  newang = delta_angle + botang;
  newang = mod(newang, 2*pi);
  newdir = [cos(newang) sin(newang)];
  newpos = botpos + (newdir * movedist);

  inside = inpolygon(newpos(1), newpos(2), pad_inpolygonMapformatX, pad_inpolygonMapformatY);

  if (inside == IN_MAP)
    botpos_mat = repmat(botpos, length(pad_map_lines), 1); %preallocate for speed
    line_seg = [botpos newpos];
    cps = intersection(line_seg, pad_map_lines);
    distSQ = sum((cps(:,:) - botpos_mat).^2,2);
    
    [c_distSQ c_index] = sort(distSQ);
      
    pindex = c_index(1);
    if(botpos == cps(c_index(1), :))		% If I'm on a pad_map_line, ignore this line.
      pindex = c_index(2);
      if(botpos == cps(c_index(2), :))		% If I'm on a corner, ignore the next line as well.
	pindex = c_index(3);
      end
    end
    
    if(isnan(cps(pindex, 1)) || isnan(cps(pindex, 2)))
      inside = IN_MAP;
    elseif(cartDist(botpos(1), botpos(2), cps(pindex, 1), cps(pindex, 2)) < cartDist(botpos(1), botpos(2), newpos(1), newpos(2)))
      inside = OUT_MAP;
    end
  end

end