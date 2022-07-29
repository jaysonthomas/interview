% Move the bot 1cm away from the corner, such that the new position is still on the map.

function botpos = move(botpos, pad_inpolygonMapformatX, pad_inpolygonMapformatY)

  vec_botpos = [botpos(1) - 1 botpos(2) + 1;
	      botpos(1) - 1 botpos(2) - 1;
	      botpos(1) + 1 botpos(2) - 1;
	      botpos(1) + 1 botpos(2) + 1];

  inside = inpolygon(vec_botpos(:,1), vec_botpos(:,2), pad_inpolygonMapformatX, pad_inpolygonMapformatY);

  for i = 1:4
    if(inside(i))
      botpos = vec_botpos(i, :);
    end
  end

end
