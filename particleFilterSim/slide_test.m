clc
close all;
drawMap;
hold on;

spos = [50, 35];
sang = degtorad(125);
sdist = 100;
sang = mod(sang, 2*pi);
sdir = [cos(sang) sin(sang)];

% Known parameters: spos, sang, sdir, sdist
% Must calculate spos_new in while loop
count = 0;
while(sdist) 

%    count
  count = count + 1;
  prev_spos = spos;
  
  [spos_new sang sdir] = move(spos, sang, sdir, sdist, 0, 0);
  lines = [[spos(1) spos(2)];  [spos_new(1) spos_new(2)]];
  line(lines(:,1), lines(:,2), 'lineWidth', 2, 'Color', 'b');

  checkIn;
  selMapline;				% gets pt_left, pt_right, cross_pt

  findTend;				% finds tend_pt, tend_dir
  findProj;				% finds proj_pt

  plot(proj_pt(1), proj_pt(2), 'g.','MarkerSize',5);
  
%    disp([' ' num2str(count) ' ' num2str(pt_left) ' ' num2str(pt_right) '  == ' num2str(sign(tend_dir))])
%    pt_left
%      pt_right
%      tend_dir
%      tend_pt

  checkBeyond;
  setMove;
  
  if(prev_spos(1) == spos(1) && prev_spos(2) == spos(2))
    break;
  end

end

plot(move_pt(1), move_pt(2), 'y.','MarkerSize',20);
