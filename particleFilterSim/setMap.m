% saves the x and y coordinates. Adds an extra row for the first x and y. Therefore, wraps around.
inpolygonMapformatX = cat(1, map(:,1), map(1,1));
inpolygonMapformatY = cat(1,map(:,2), map(1,2));

% The map's length is increased by 1 - First element is appended again to the end.
% for wrap around!
map(length(map)+1,:)= map(1,:);

% map_lines has 4 columns and is the length of the old_map.
% First row -> 1st point, 2nd point
% Second row -> 2nd point, 3rd point...and so on.
for i = 1:length(map_lines)
  map_lines(i,:) = [map(i,:) map(i+1,:)] ;
end
