%---------------------------------------------------
% FIND THE BEST SHIFTED HISTOGRAM
% Get the histogram of particle(i) with the best overlap as 
% the robot's histogram
%---------------------------------------------------
rep_r_scan_dist_1 = repmat(r_scan_dist, [1, nparticles]);
min_err_shift = 9999999999999*ones(1, nparticles);
index_min_err_shift = i*zeros(1, nparticles);
shift_dist = scan_dist;
mat_scan_shift = scan_dist;
for i = 1:nscans
    if(iterations > 0 && i == 9)
      continue;
    end
    mat_scan_diff = bsxfun(@minus, rep_r_scan_dist_1, mat_scan_shift);
    mat_scan_diff = bsxfun(@times, mat_scan_diff, mat_scan_diff);
    sq_err = sum(mat_scan_diff, 1);
    lt_min_err_shift = bsxfun(@lt, sq_err, min_err_shift);
    index_min_err_shift = bsxfun(@plus, bsxfun(@times, i*ones(1, nparticles), lt_min_err_shift), bsxfun(@times, index_min_err_shift, ~lt_min_err_shift));
    min_err_shift = bsxfun(@plus, bsxfun(@times, sq_err, lt_min_err_shift), bsxfun(@times, min_err_shift, ~lt_min_err_shift));
    shift_dist = bsxfun(@plus, bsxfun(@times, mat_scan_shift, repmat(lt_min_err_shift, [nscans 1])), bsxfun(@times, shift_dist, repmat(~lt_min_err_shift, [nscans 1])));
    mat_scan_shift = circshift(scan_dist, i);
end
 
index_min_err_shift = index_min_err_shift';
if(iterations == 0)
    index_min_err_shift = (index_min_err_shift - 1) * (360/nscans);
    index_min_err_shift = degtorad(index_min_err_shift);
    
    ang = bsxfun(@minus, ang, index_min_err_shift);
    ang = bsxfun(@mod, ang, 2*pi*ones(nparticles,1));
    dir = [cos(ang) sin(ang)];
else
    index_min_err_shift = (index_min_err_shift - 1) * (360/nscans);
    index_min_err_shift = degtorad(index_min_err_shift);
    
%      ang = bsxfun(@minus, ang, bsxfun(@times, index_min_err_shift, index_min_err_shift~=round(nscans/2)));
    ang = bsxfun(@minus, ang, index_min_err_shift);
    ang = bsxfun(@mod, ang, 2*pi*ones(nparticles,1));
    dir = [cos(ang) sin(ang)];
end

