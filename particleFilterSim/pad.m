%----
% We look for a point that is pad_len distance from each corner of the map.
% The order in which we check is important - refer to the newPts variable.
%----
new_map = map;
pad_len = 1;
pad_len2 = 5;

for i = 1:length(map)
    newPts = [map(i, 1) - pad_len, map(i, 2) - pad_len;
        map(i, 1) - pad_len, map(i, 2) + pad_len;
        map(i, 1) + pad_len, map(i, 2) + pad_len;
        map(i, 1) + pad_len, map(i, 2) - pad_len];
    
    padPts = [map(i, 1) - pad_len2, map(i, 2) - pad_len2;
        map(i, 1) - pad_len2, map(i, 2) + pad_len2;
        map(i, 1) + pad_len2, map(i, 2) + pad_len2;
        map(i, 1) + pad_len2, map(i, 2) - pad_len2];
    
    out = inpolygon(newPts(:, 1), newPts(:, 2), inpolygonMapformatX, inpolygonMapformatY);
    index =  find(out);
    
    if(length(index) > 1)
        out_ind = find(out == 0);
        
        if(out_ind == 1)
            in_ind = 3;
        elseif(out_ind == 2)
            in_ind = 4;
        elseif(out_ind == 3)
            in_ind = 1;
        else
            in_ind = 2;
        end
        
        new_map(i, :) = padPts(in_ind, :);
        
    else
        new_map(i, :) = padPts(index, :);
    end
    
end

pad_inpolygonMapformatX = cat(1, new_map(:,1), new_map(1,1));
pad_inpolygonMapformatY = cat(1,new_map(:,2), new_map(1,2));

