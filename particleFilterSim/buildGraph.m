%  goal_pos = [80 80];
goal_pos = T;
cur_pos = fpos;

node_graph = [];
vis_graph = [];

buildNodeG;		% Returns node_graph, ng_lines

nlen = length(node_graph);
connections = zeros(nlen, nlen);
graph = zeros(nlen, 5);
distances = Inf(nlen, nlen);

for i = 1:nlen

  dist_to_goal = sqrt((node_graph(i,1) - goal_pos(1))^2 + (node_graph(i,2) - goal_pos(2))^2);
  
  graph(i, :) = [i, i, 0, dist_to_goal, dist_to_goal];			% Fills up the graph matrix.
  one = [node_graph(i, 1), node_graph(i, 2)];

  for j = 1:nlen
    if(connections(i, j) == 1)
      continue;
    end
  
    two = [node_graph(j, 1), node_graph(j, 2)];
    
    if(i == j)
      continue
    end
    
    checkConn;
    if(check_conn)	
      connections(i, j) = 1;
      distances(i, j) = sqrt((node_graph(i, 1) - node_graph(j, 1))^2 + (node_graph(i, 2) - node_graph(j, 2))^2);
      connections(j, i) = 1;
      distances(j, i) = distances(i, j);
    end
    
  end
  
end

%  connections
distances(:, nlen) = graph(:, 5);

astar;
path = fliplr(path);
path = node_graph(path, :);
%  path(:, :)