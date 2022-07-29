updateScanLines;

map_len = length(map_lines);
rep_dim = map_len*nscans;
rep_scan = zeros(nscans*length(map_lines), 4);

for i = 1:nscans
    j = (i - 1)*map_len + 1;
    rep_scan(j:(j + map_len - 1), :) = repmat(scan_lines(i, :), map_len, 1);
end
rep_map = repmat(map_lines, nscans, 1);

rep_inter = intersection(rep_scan, rep_map);

botpos_mat = repmat(botpos, rep_dim, 1);
diff = bsxfun(@minus, rep_inter, botpos_mat);
distNN = bsxfun(@hypot, diff(:, 1), diff(:, 2));
%distNN = bsxfun(@times, diff(:, 1), diff(:, 1)) + bsxfun(@times, diff(:, 2), diff(:, 2));
crossingPoints = zeros(nscans, 2);
distances = zeros(nscans, 1);

%  length(distances)

for i = 1:nscans
    j = (i - 1)*map_len + 1;
    temp_distance = distNN(j:(j + map_len - 1), :);
    [distances(i,:), indices] = min(temp_distance);
    temp_cps = rep_inter(j:(j + map_len - 1), :);
    crossingPoints(i,:) = temp_cps(indices,:);
end
