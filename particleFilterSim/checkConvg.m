%---------------------------------------------------
% CHECK FOR CONVERGENCE
%---------------------------------------------------

std_x = std(pos(:, 1), 1);
std_y = std(pos(:, 2), 1);
std_ang = std(ang, 1);

done = 0;
%  disp(['iteration: ' num2str(iterations) ' x: ' num2str(std_x) ' y: ' num2str(std_y) ' angle: ' num2str(std_ang)])

if(std_x + std_y <=  0.000000005)
  drawAll;
  done = 1;
end