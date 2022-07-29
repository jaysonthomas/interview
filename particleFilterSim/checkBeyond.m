% Check if the resultant point goes beyond the particular map line we had intersected.
beyond = 0;

if(tend_pt(2) == proj_pt(2))					% Moving along the y axis
  sdist = tend_pt(1) - proj_pt(1);
else								% Moving along the x axis
  sdist = tend_pt(2) - proj_pt(2);
end

if((tend_dir > 0 && sdist < 0) || (tend_dir < 0 && sdist > 0))		
  beyond = 1;
end

sdist = abs(sdist);