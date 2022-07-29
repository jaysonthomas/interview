total_weight = 0;
likelihood = zeros(nscans, nparticles);
constant = 0.0004;

for i = 1:nscans
    likelihood(i,:) = gaussmf(shift_dist(i, :), [8 r_scan_dist(i)]);
end

weight = sum(likelihood, 1) + constant;

weight = weight' / sum(weight);