% I need to get just 8 values here.
temp_config = scanConfig;
temp_nscans = nscans;

nscans = ndirs;
generateScanConfig;			% sets scanConfig

botpos = r_pos(1, :);
botang = r_ang + delta_angle;

ultraScan;
r_scan_dist = distances;

nscans = temp_nscans;
scanConfig = temp_config;

