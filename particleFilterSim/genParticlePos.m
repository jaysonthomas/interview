%---------------------------------------------------
% Generates the maximum number of particles that are padlen distance from each
% other and within the padded map.
%---------------------------------------------------

padlen = 3;

% Finds the left, lowermost corner and right, topmost corner of the padded map
min_x = min(new_map(:, 1));
max_x = max(new_map(:, 1));

min_y = min(new_map(:, 2));
max_y = max(new_map(:, 2));

% Generates the x and y coordinates of plot points that are padlen distance from each other.
np_x = floor(max_x/padlen);
np_y = floor(max_y/padlen);

pts_x = (1:np_x) * padlen;
pts_y = (1:np_y) * padlen;

nparticles = np_x*np_y;
plot_point = zeros(nparticles, 1);

for i = 0:np_x-1
  for j = 0:np_y-1
    plot_point(i*np_y + j + 1, 1) = pts_x(i+1);
    plot_point(i*np_y + j + 1, 2) = pts_y(j+1);
  end
end

% Remove all those plot points that fall outside the map.
inside = inpolygon(plot_point(:,1), plot_point(:,2), pad_inpolygonMapformatX, pad_inpolygonMapformatY);
plot_point = plot_point(find(inside), :);

nparticles = length(plot_point);

