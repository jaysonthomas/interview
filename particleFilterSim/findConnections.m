%---------------------------------------------------
% Check if the line: robot <-> corner intersects any map wall.
% If it does, record the map wall point.
%---------------------------------------------------
botpos_mat = repmat(r_pos, length(map_lines), 1); %preallocate for speed
line_seg = [r_pos map(c, :)];
cps = intersection(line_seg, map_lines);
distSQ = sum((cps(:,:) - botpos_mat).^2,2);
[distances(1,:) index] = min(distSQ);

if(the closest point (index) is also the corner we're looking for)  
 add the corner to our list
end