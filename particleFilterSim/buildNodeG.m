for i = 1:length(new_map)
  newPts = [new_map(i, 1) - 1, new_map(i, 2);
	    new_map(i, 1) + 1, new_map(i, 2);
	    new_map(i, 1),     new_map(i, 2) + 1;
	    new_map(i, 1),     new_map(i, 2) - 1];
	    
  if(sum(inpolygon(newPts(:, 1), newPts(:, 2), pad_inpolygonMapformatX, pad_inpolygonMapformatY)) == 4)
    node_graph = [node_graph; [new_map(i, 1) new_map(i, 2)]];
  end
end

node_graph = [cur_pos; node_graph; goal_pos];
line(new_map(:,1), new_map(:,2), 'lineWidth', 2, 'Color', 'g');
