%moves the bot forward by a distance in the direction its
%facing.  noise is added proportional to the distance moved. A
%constant amount of angular noise is added

function [botpos botang botdir] = move(botpos, botang, botdir, movedist, motionNoise, turningNoise)
  botang = botang + randn(1) * turningNoise;
  botdir = [cos(botang) sin(botang)];
  botpos = botpos + botdir * (movedist + (movedist * randn(1) * motionNoise));
end