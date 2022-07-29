%---------------
% Finds sdist, pt_left, pt_right
%---------------

lineseg = [spos, spos_new];
botpos_mat = repmat(spos, length(pad_map_lines), 1); 		% (repeat matrix) preallocate for speed

% Find the intersection points and the particular map lines being intersected.
bumps = intersection(lineseg, pad_map_lines);
distSQ = sum((bumps - botpos_mat).^2, 2);

[sort_distSQ sort_index] = sort(distSQ);

option = 1;

checkOnline;		% returns option

% If option == -1, bot is at a corner or on a line and trying to move inside.
% If so, spos would have been set to the new position within checkOnline.
if(option == -1)
  continue			
end

%----------
% Comes here only if option ~= -1
%----------
pt_a = pad_map_lines(sort_index(option), 3:4);
pt_b = pad_map_lines(sort_index(option), 1:2);
cross_pt = bumps(sort_index(option), :);

% The right crossing point and intersecting map line has been chosen.
% Find sdist.
% Assign pt_left and pt_right.
% If moving along the x-axis, pt_right will be the top point.

% No matter what the axis, pt_left will always be the smaller coordinate 
% considering the other axis along which it is not moving.
% Coordinate of the axis along which it is moving remains constant.
if(pt_a(1) < pt_b(1) || pt_a(2) < pt_b(2))
  pt_left = pt_a;
  pt_right = pt_b;
else
  pt_left = pt_b;
  pt_right = pt_a;
end
  
if(pt_a(2) == pt_b(2))					% Moving along y-axis
  sdist = abs(cross_pt(1) - spos_new(1));
elseif(pt_a(1) == pt_b(1))				% Moving along x-axis
  sdist = abs(cross_pt(2) - spos_new(2));
end
