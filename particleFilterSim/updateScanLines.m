%---------------------------------------------------
%needs to be called after the robot has moved or turned.  This
%updates the scanLine vectors.  The inner and outer rad set how
%the scanlines are drawn and do not affect the operation of the
%program, Don't set them both to 0 however.
% returns the scan configuration stored as 2d lines
%---------------------------------------------------
innerRad = 0;
outerRad = 1;

transMat = createTransMat(botpos) * createRotMat(botang) * createTransMat(scanOffset);
scanCenter = translate(scanConfig*innerRad, transMat);
scans =  translate(scanConfig*outerRad, transMat);
scan_lines = cat(2, scanCenter, scans);

