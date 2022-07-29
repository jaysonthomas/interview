check_conn = 0;
lineseg = [one, two];

botpos_mat = repmat(one, length(pad_map_lines), 1); 		% (repeat matrix) preallocate for speed

% Find the intersection points and the particular map lines being intersected.
cps = intersection(lineseg, pad_map_lines);
distSQ = sum((cps - botpos_mat).^2, 2);
[sort_distSQ sort_index] = sort(distSQ);

index = sort_index(1);

for k = 1:length(cps)
  if (cps(sort_index(k), 1) == node_graph(i, 1) && cps(sort_index(k), 2) == node_graph(i, 2))
    continue;
  end

  if(cartDist(node_graph(i, 1), node_graph(i, 2), node_graph(j, 1), node_graph(j, 2)) <= cartDist(node_graph(i, 1), node_graph(i, 2), cps(sort_index(k), 1), cps(sort_index(k), 2)))
    check_conn = 1;
    break;
  else
    check_conn = 0;
    break;
  end  
end

