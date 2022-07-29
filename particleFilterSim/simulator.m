hold on;
axis equal;

%---------------------------------------------------
% Initialisations
%---------------------------------------------------
tic
declareGlobals
init

iterations = 0;

scan;
correctShift;
drawAll;

for iterations = 1:100

  for nmovs = 1:1
    moveAll;
    scan;
    correctShift;
  end

%    if(mod(iterations, 20) == 0)
%      close all;
%    end
    
  assignWeights;
  sortParticles;
  
  particleSelection;
  assignWeights;
  
  if(mod(iterations, 4) == 0)
    drawAll;
  end
  checkConvg;
  
  if(done)
    break;
  end
  
end


figure();
hold on;
drawMap;

moveToGoal;
toc