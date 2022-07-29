%#! /usr/bin/octave -qf

function dr (titleMsg, fileName)

    close all
    data = load ("../nmoves.txt"); 
    plot (data (:,1), data (:,3), "g"); 
    hold on
    plot(data (:,1), data(:,4), '.');
%      axis([0, 500, 0, 30], "manual");
     title(titleMsg);
    
    xlabel("Episode number");
    ylabel("Number of moves");
    print("-dpng", fileName);

endfunction

%graph "MPROB=2 CPROB=100" "./output/graph.ps"
