#include "rlOp.h"
#include "convgCheck.h"



/*------------------------------------------------------------------------------
 * Function: chkConvg
 * 
 * The robot moves from the START to the GOAL, constantly picking
 * the best action - that with the greatest Q value. If the current
 * solution found is same as the previous solution and not equal to 'MAX_TRIALS'
 * then the reinforcement learning has reached convergence and the function
 * returns 'CONVERGENCE' else 'DIVERGENCE'.
 * 
 * 'prev_sol' always holds the previous solution. If the learning has not
 * yet converged by the end of the function, the current solution is assigned to
 * 'prev_sol'. 
 */
unsigned char chkConvg(int no, FILE *f, robot *r, int *prev_sol) {
  int choice[4][2] = {
		      {-1,0},
		      {0,1},
		      {1,0},
		      {0,-1}
		     };
  int c_row = 0;
  int action = 0;
  int found = 0;
  float maxQ;
  state prev_s;
  state temp;
  int cur_sol = 0;
  int i;
  
  r->cur_s.x = r->cur_s.y = 0;
  
  fprintf(f, "\n%d\n%d %d", no, r->cur_s.x, r->cur_s.y);
  
  while(r->reward[r->cur_s.x][r->cur_s.y] != GOAL && cur_sol!=MAX_TRIALS) {
    c_row = (r->cur_s.x*ENV_SIZE_X) + r->cur_s.y;
  
    found = 0;
    maxQ = MAXQ_INIT;
    // Choose the action with the highest Q value
    for(i=0; i<4; i++) {
      temp.x = r->cur_s.x + choice[i][X];
      temp.y = r->cur_s.y + choice[i][Y];
      
      if(checkMove(temp) != POSSIBLE) 
	continue;

      if(r->reward[r->cur_s.x][r->cur_s.y] == OBSTACLE)
	continue;

      /* The next state shouldn't be same as the previous one 
       * else the robot could get stuck in a loop
       */
      if(temp.x == prev_s.x && temp.y == prev_s.y) 
	continue;
      
      if(r->Q[c_row][i] > maxQ) {
	maxQ = r->Q[c_row][i];
	action = i;
	found = 1;
      }
    }
    
    // Choose any action if no action has a higher Q value
    if(!found) {
     for(i=0; i<4; i++) {
	temp.x = r->cur_s.x + choice[i][X];
	temp.y = r->cur_s.y + choice[i][Y];
	
	if(checkMove(temp) != POSSIBLE) 
	  continue;
	
	if(r->reward[r->cur_s.x][r->cur_s.y] == OBSTACLE)
	  continue;

	if(temp.x != prev_s.x || temp.y != prev_s.y) {
	  action = i;
	  break;
	}
      }
    }
    
    prev_s = r->cur_s;
    // Take action
    r->cur_s.x += choice[action][X];
    r->cur_s.y += choice[action][Y];
    cur_sol++;
    
    // Print current state and update no. of moves
    fprintf(f, "\n%d %d", r->cur_s.x, r->cur_s.y);
  }
  fprintf(f, "\n\n");
  if(*prev_sol == cur_sol && cur_sol!=MAX_TRIALS)
    return CONVERGENCE;
  
  *prev_sol = cur_sol;
  return DIVERGENCE;
}






