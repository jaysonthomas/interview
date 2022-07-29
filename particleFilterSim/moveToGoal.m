[fval findex] = max(weight);
fpos = pos(findex, :);
fang = ang(findex);
fdir = dir(findex, :);

disp(['Estimated position: ' num2str(fpos(1)) ', ' num2str(fpos(2)) '  theta: ' num2str(radtodeg(fang))]);
disp(['Actual position: ' num2str(r_pos(1)) ', ' num2str(r_pos(2))  '  theta: ' num2str(radtodeg(r_ang))]);

lineLength = 5;
buildGraph;

plot(fpos(1), fpos(2), 'go', 'LineWidth', 3, 'MarkerSize', 5);
line([fpos(1) fpos(1)+fdir(1)*lineLength], [fpos(2) fpos(2)+fdir(2)*lineLength]);

angle = fang;
direction = fdir;

for i = 1:length(path)-1
  
  moveAccd;
%    [dest angle direction] = moveAccd(, , angle, direction);
  
  plot(dest(1), dest(2), 'bo', 'LineWidth', 3, 'MarkerSize', 5);
  line([dest(1) dest(1)+direction(1)*lineLength], [dest(2) dest(2)+direction(2)*lineLength]);
  
  trajs = [path(i, :); dest];
  
  line(trajs(:,1), trajs(:,2), 'lineWidth', 2, 'Color', 'y'); 	% draws arena
end

%  actual;