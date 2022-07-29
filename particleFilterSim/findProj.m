%---
% Crossing point = cross_pt
% Particular map point = tend_pt
% Move crossing point along the intersected map line == proj_pt
%---
cross_pt = (round(abs(cross_pt) .* 1000))/1000;

if(cross_pt(2) == tend_pt(2))			% Moving along y axis
  if(tend_dir > 0)				% Moving to the right
    cross_pt(1) = cross_pt(1) + sdist;
  else
    cross_pt(1) = cross_pt(1) - sdist;
  end
else						% Moving along x axis
  if(tend_dir > 0)				% Moving upwards
    cross_pt(2) = cross_pt(2) + sdist;
  else						% Moving downwards
    cross_pt(2) = cross_pt(2) - sdist;
  end
end

proj_pt = (round(cross_pt .* 1000))/1000;
