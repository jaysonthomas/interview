%----------------
% We're giving priority to the forward facing angles.
%----------------
%  if (r_scan_dist(1) > delta_dist)
%    del_ind = 1;
%  elseif(r_scan_dist(2) > delta_dist && r_scan_dist(8) > delta_dist)
%    if(rand() > 0.5)
%      del_ind = 8;
%    else
%      del_ind = 2;
%    end
%  elseif(r_scan_dist(2) > delta_dist)
%    del_ind = 2;
%  elseif(r_scan_dist(8) > delta_dist)
%    del_ind = 8;
%  elseif(r_scan_dist(3) > delta_dist && r_scan_dist(7) > delta_dist)
%    if(rand() > 0.5)
%      del_ind = 7;
%    else
%      del_ind = 3;
%    end
%  elseif(r_scan_dist(3) > delta_dist)
%    del_ind = 3;
%  elseif(r_scan_dist(7) > delta_dist)
%    del_ind = 7;
%  elseif(r_scan_dist(4) > delta_dist && r_scan_dist(6) > delta_dist)
%    if(rand() > 0.5)
%      del_ind = 6;
%    else
%      del_ind = 4;
%    end
%  elseif(r_scan_dist(4) > delta_dist)
%    del_ind = 4;
%  elseif(r_scan_dist(6) > delta_dist)
%    del_ind = 6;
%  elseif(r_scan_dist(5) > delta_dist)			% 270 deg w.r.t current angle
%    del_ind = 5;
%  end

if (r_scan_dist(1) > delta_dist - 10)
  del_ind = 1;
elseif(r_scan_dist(3) > delta_dist && r_scan_dist(17) > delta_dist)
  if(rand() > 0.5)
    del_ind = 8;
  else
    del_ind = 2;
  end
elseif(r_scan_dist(3) > delta_dist)
  del_ind = 2;
elseif(r_scan_dist(17) > delta_dist)
  del_ind = 8;
elseif(r_scan_dist(5) > delta_dist && r_scan_dist(14))
  if(rand() > 0.5)
    del_ind = 7;
  else
    del_ind = 3;
  end
elseif(r_scan_dist(5) > delta_dist)
  del_ind = 3;
elseif(r_scan_dist(14) > delta_dist)
  del_ind = 7;
elseif(r_scan_dist(8) > delta_dist && r_scan_dist(12) > delta_dist)
  if(rand() > 0.5)
    del_ind = 6;
  else
    del_ind = 4;
  end
elseif(r_scan_dist(8) > delta_dist)
  del_ind = 4;
elseif(r_scan_dist(12) > delta_dist)
  del_ind = 6;
elseif(r_scan_dist(10) > delta_dist)
  del_ind = 5;
end