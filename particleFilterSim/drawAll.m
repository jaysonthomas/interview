
figure();
hold on;
drawMap;

option = DRAW_ROBOT;
drawBot;

part_pos = pos;
jitter = 1;
for ind = 1:nparticles
  part_pos(ind, 1) = pos(ind, 1) + ((rand() - rand())/jitter);
  part_pos(ind, 2) = pos(ind, 2) + ((rand() - rand())/jitter);
  
%    inside = inpolygon(part_pos(1), part_pos(2), pad_inpolygonMapformatX, pad_inpolygonMapformatY);
%    if(inside)
%      pos(ind, :) = part_pos(1, :);
%    end
end

%  option = DRAW_PARTICLE;
%  drawBot;

scatter(part_pos(:, 1), part_pos(:, 2));

%  for jack = 1:nparticles
%    line([part_pos(jack,1) part_pos(jack, 1)+ dir(jack, 1)*lineLength], [part_pos(jack,2) part_pos(jack,2)+dir(jack,2)*lineLength]);
%  end


hold off;
    
