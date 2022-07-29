%---------------------------------------------------
% generates an '360/nscans' degree scan configuration.              
%---------------------------------------------------

startAngle = 0;
endAngle = 2 * pi;
i = startAngle:abs(startAngle-endAngle) / nscans:startAngle+endAngle - abs(startAngle-endAngle) / nscans;
scanConfig =  cat(1,cos(i), sin(i))'*30;


