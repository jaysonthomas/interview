fpos = r_pos;
fang = r_ang;
fdir = r_dir;

lineLength = 5;
buildGraph;

plot(fpos(1), fpos(2), 'ko', 'LineWidth', 3, 'MarkerSize', 5);
line([fpos(1) fpos(1)+fdir(1)*lineLength], [fpos(2) fpos(2)+fdir(2)*lineLength]);

angle = fang;
direction = fdir;

for i = 1:length(path)-1
  [dest angle direction] = moveAccd(path(i, :), path(i+1, :), angle, direction);
  
  plot(dest(1), dest(2), 'co', 'LineWidth', 3, 'MarkerSize', 5);
  line([dest(1) dest(1)+direction(1)*lineLength], [dest(2) dest(2)+direction(2)*lineLength]);
  
  trajs = [path(i, :); dest];
  
  line(trajs(:,1), trajs(:,2), 'lineWidth', 2, 'Color', 'm'); 	% draws connecting lines between nodes.
end

