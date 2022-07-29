function move_pt = slide(pad_inpolygonMapformatX, pad_inpolygonMapformatY, pad_map_lines, spos, sang, sdir, sdist)

  sang = mod(sang, 2*pi);
  sdir = [cos(sang) sin(sang)];

  % Known parameters: spos, sang, sdir, sdist
  % Must calculate spos_new in while loop

  while(sdist) 

    prev_spos = spos;
    
    [spos_new sang sdir] = move(spos, sang, sdir, sdist, 0, 0);
%      lines = [[spos(1) spos(2)];  [spos_new(1) spos_new(2)]];
%      line(lines(:,1), lines(:,2), 'lineWidth', 2, 'Color', 'b');

    checkIn;
    selMapline;				% gets pt_left, pt_right, cross_pt

    findTend;				% finds tend_pt, tend_dir
    findProj;				% finds proj_pt

    checkBeyond;
    setMove;
    
    if(prev_spos(1) == spos(1) && prev_spos(2) == spos(2))
      break;
    end

  end
  
end