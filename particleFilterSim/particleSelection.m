%---------------------------------------------------
% ROULETTE-WHEEL SELECTION
% Cumulative Sum
%---------------------------------------------------
running_sum = 0;
c_sum = zeros(nparticles, 1);

for ind = 1:nparticles
  running_sum = running_sum + weight(ind);
  c_sum(ind) = running_sum;
end

rand_ind = zeros(nparticles, 1);
rand_ind = randsample([1:nparticles], nparticles, true, c_sum); 

pos = pos(rand_ind, :);
ang = ang(rand_ind);
dir = dir(rand_ind, :);
weight = weight(rand_ind);

%  shift_dist = shift_dist(:, rand_ind);
%  scan_dist = scan_dist(:, rand_ind);
%  cross_pts = cross_pts(rand_ind, :, :);
%  
%  
