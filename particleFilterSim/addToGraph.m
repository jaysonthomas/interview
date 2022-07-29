%---------------------------------------------------
% ADDTOGRAPH
%---------------------------------------------------
function addToGraph(robot, c, visgraph)

  visgraph(0, c) = 1;
  visgraph(c, 0) = 1;

end