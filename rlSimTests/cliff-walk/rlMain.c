#include "rlOp.h"
#include "memMng.h"
#include "convgCheck.h"
#include "rlMain.h"



/*------------------------------------------------------------------------------
 * Function: sarsa
 * 
 * SARSA algorithm - refer fig 6.9 http://webdocs.cs.ualberta.ca/~sutton/book/ebook/node64.html
 */
void sarsa(robot *r, char world[ENV_SIZE_X][ENV_SIZE_Y], float result[MAX_EPISODES][2]) {
  int i;
  int nepisodes = 0;
  int prev_sol;
  unsigned char ret_val = DIVERGENCE;
  FILE *sol_file;
  
  initFile(&sol_file, "solution.txt");

  while(nepisodes != MAX_EPISODES) {
    initEpisode(r, world);
    chooseAction(r, CURRENT);	// Current action, Next state is found here.
    do {
      if(r->nmoves != 0)
	r->next_s = r->next_next_s;
      r->reward[r->next_s.x][r->next_s.y] = world[r->next_s.x][r->next_s.y];
      chooseAction(r, NEXT);		// Next action, Next_next state is found here.
      updateQTable(r);
      updateCurStatus(r);		
      
      // CLIFF
      if(r->reward[r->cur_s.x][r->cur_s.y] == CLIFF)
	sarsaCliff(r);
      
      freeAll(r);
    } while(r->reward[r->cur_s.x][r->cur_s.y] != GOAL && r->nmoves!=MAX_TRIALS);
    
    nepisodes++;    
    if(nepisodes%CONVGCHK_GAP == 0)
      ret_val = chkConvg(sol_file, r, &prev_sol);
    
    // Write to file the 'episode number' and 'Number of moves in the episode'
    result[nepisodes][0] += r->nmoves;
    result[nepisodes][1] += prev_sol;
    
    if(ret_val == CONVERGENCE) 
      break;
  }
  
    // for formating the output graphs properly - not necessary!
  for(i = nepisodes+1; i<=MAX_EPISODES; i++) {
    result[i][0] += 0;
    result[i][1] += prev_sol;
  }
  
  fclose(sol_file);
}



/*------------------------------------------------------------------------------
 * Function: sarsaCliff
 * 
 */
void sarsaCliff(robot *r) {
  r->cur_s.x = r->cur_s.y = 0;
  r->next_next_s.x = 1;
  r->next_next_s.y = 0;
  r->cur_action = RIGHT;
}



/*------------------------------------------------------------------------------
 * Function: qLearning
 * 
 * Q-learning algorithm - refer fig 6.12 http://webdocs.cs.ualberta.ca/~sutton/book/ebook/node65.html
 */
void qLearning(robot *r, char world[ENV_SIZE_X][ENV_SIZE_Y], float result[MAX_EPISODES][2]) {
  int i;
  int nepisodes = 0;
  int prev_sol;
  unsigned char ret_val = DIVERGENCE;
  FILE *sol_file;
  
  initFile(&sol_file, "solution.txt");
  
  while(nepisodes != MAX_EPISODES) {
    initEpisode(r, world);
    do {
      chooseAction(r, CURRENT);	// Current action, Next state is found here.
      r->reward[r->next_s.x][r->next_s.y] = world[r->next_s.x][r->next_s.y];
      updateQTable(r);
      updateCurStatus(r);		
      
      // CLIFF
      if(r->reward[r->cur_s.x][r->cur_s.y] == CLIFF)
	qLearningCliff(r);
      
      freeAll(r);
    } while(r->reward[r->cur_s.x][r->cur_s.y] != GOAL && r->nmoves!=MAX_TRIALS);
    
    nepisodes++;    
    if(nepisodes%CONVGCHK_GAP == 0)
      ret_val = chkConvg(sol_file, r, &prev_sol);
    
    // Write to file the 'episode number' and 'Number of moves in the episode'
    result[nepisodes][0] += r->nmoves;
    result[nepisodes][1] += prev_sol;
    
    if(ret_val == CONVERGENCE) 
      break;
  } 

  // for formating the output graphs properly - not necessary!
  for(i = nepisodes+1; i<=MAX_EPISODES; i++) {
    result[i][0] += 0;
    result[i][1] += prev_sol;
  }
  
  fclose(sol_file);
}



/*------------------------------------------------------------------------------
 * Function: qLearningCliff
 * 
 */
void qLearningCliff(robot *r) {
  r->cur_s.x = r->cur_s.y = 0;
}
