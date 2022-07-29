[sort_w sort_ind] = sort(weight);

pos = pos(sort_ind, :);
ang = ang(sort_ind);
dir = dir(sort_ind, :);

weight = weight(sort_ind);

%  shift_dist = shift_dist(:, rand_ind);
%  scan_dist = scan_dist(:, rand_ind);
%  cross_pts = cross_pts(rand_ind, :, :);
%  
%  
