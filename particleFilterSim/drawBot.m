if(option == DRAW_ROBOT)
  lineLength = 5;
  plot(r_pos(1), r_pos(2), 'go', 'LineWidth', 3, 'MarkerSize', 5);
  line([r_pos(1) r_pos(1)+r_dir(1)*lineLength], [r_pos(2) r_pos(2)+r_dir(2)*lineLength]);
else
%    scatter(pos(:, 1), pos(:, 2), 5, 50, 'LineWidth', 2);
  scatter(pos(:, 1), pos(:, 2));
  
%   for jack = 1:nparticles
%     line([pos(jack,1) pos(jack, 1)+ dir(jack, 1)*lineLength], [pos(jack,2) pos(jack,2)+dir(jack,2)*lineLength]);
%   end
end

  
