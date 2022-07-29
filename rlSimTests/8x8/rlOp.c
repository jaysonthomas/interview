#include "rlOp.h"
#include "rlMain.h"

// float step_size = 0.1, discount_factor = 0.5;
float step_size = 0.8, discount_factor = 0.2;

/*------------------------------------------------------------------------------
* Function:  addToStateList
*
* If the particular state has been explored before - this is found by checking
* if any reward has been assigned to the state - add the state/action to the 
* exploitation list
* Else, add it to the exploration list
*/
void addToStateList(robot *r, state s, int action) {
  void *ptr;
  int index;
  ptr = NULL;
  
  index = r->explore_len++;

  ptr = realloc(r->explore_s, sizeof(SA)*r->explore_len);
  if(!ptr) 
    goto kill;
  r->explore_s = ptr;
  r->explore_s[index].s = s;
  r->explore_s[index].a = action;
  
  if(r->reward[s.x][s.y] == UNEXPLORED_STATE) 
    return;
  
  index = r->exploit_len++;
  ptr = realloc(r->exploit_s, sizeof(SA)*r->exploit_len);
  if(!ptr)
    goto kill;
  r->exploit_s = ptr;
  r->exploit_s[index].s = s;
  r->exploit_s[index].a = action;
  return;

kill:
  printf("\nERROR: Reallocation failed\n");
  free(ptr);
  free(r->exploit_s);
  free(r->explore_s);
  exit(0);
}



/*------------------------------------------------------------------------------
* Function:  checkMove
*
* Check if the particular move falls within the bounds of the environment
* by checking the x,y coordinates of the resultant state
* 
*/
int checkMove(state s) {
  if(s.x >= ENV_LLIMIT && s.x <= ENV_ULIMIT_X && s.y >= ENV_LLIMIT && s.y <= ENV_ULIMIT_Y)
    return POSSIBLE;
  return NOT_POSSIBLE;
}



/*------------------------------------------------------------------------------
* Function:  chooseAction
*
* Steps involved:
* 1. If the 'exploration/exploitation probability' is >= EPSILON, go exploiting!
* Exploitation Mode
* -----------------
* 1. If there are no states to be exploited then
*    - If there are no states to be explored - Quit with an error message.
*    - If there are states to be explored - EXPLORE!
* 2. If there are states to be exploited, EXPLOIT!
* 
* Exploration is done in a similar fashion
* In either mode, select a state/action pair from the corresponding lists
* 'exploit_s & explore_s' & assign them to 'next_s' & 'next_action' 
* respectively.
* 
* When 'choice' == 'CURRENT'/'NEXT', a current/next action is found for the robot
* and the resulting next/next_next state from taking the particular action.
* 
*/
void chooseAction(robot *r, int choice) {
  int a_index;
  int t_action;
  state t_state;

  updatePossibleActions(r, choice);
  
  // If the probability is >= EPSILON, go exploiting!
  if((rand()&0xFF)%100 >= EPSILON) {
    if(r->exploit_len == 0) {
      if(r->explore_len != 0)
	goto EXPLORE;
      goto kill;
    }

EXPLOIT:
    a_index = (rand() & 0xFF) % r->exploit_len;
    t_action = r->exploit_s[a_index].a;
    t_state = r->exploit_s[a_index].s;
    goto ASSIGN;
  }

  if(r->explore_len == 0) {
    if(r->exploit_len != 0) 
      goto EXPLOIT;
    goto kill;
  }
  

EXPLORE:  
  a_index = (rand() & 0xFF) % r->explore_len;
  t_action = r->explore_s[a_index].a;
  t_state = r->explore_s[a_index].s;
  
ASSIGN:
  if(choice == CURRENT) {
    r->cur_action = t_action;
    r->next_s = t_state;
  }
  else {
    r->next_action = t_action;
    r->next_next_s = t_state;
  }
  return;  
  
kill:
  free(r->exploit_s);
  free(r->explore_s);
  printf("\nERROR: number of states to explore & exploit shouldn't be 0\n");
  exit(0);
}



/*------------------------------------------------------------------------------
* Function:  updateCurStatus
*
* Assign next state to the current state.
*/
void updateCurStatus(robot *r) {
  r->cur_s = r->next_s;
  r->nmoves++;  
  
  if(g_rl_choice == SARSA)
    r->cur_action = r->next_action;
}



/*------------------------------------------------------------------------------
* Function:  updatePossibleActions
*
* Steps involved:
* 1. Note the possible states the robot could move into by taking the 4 basic actions
* 2. Check if each of the 4 resultant states fall under the environment's bounds
*    If yes, add the resultant states and corresponding actions to either the 
*    exploration or the exploitation state/action list
*/
void updatePossibleActions(robot *r, int choice) {
  state poss_s[4];
  state s;
  
  if(choice == CURRENT)
    s = r->cur_s;
  else
    s = r->next_s;
  
  poss_s[LEFT].x  = s.x-1;
  poss_s[LEFT].y  = s.y;
  
  poss_s[FWD].x   = s.x;
  poss_s[FWD].y   = s.y+1;
  
  poss_s[RIGHT].x = s.x+1;
  poss_s[RIGHT].y = s.y;
  
  poss_s[BWD].x   = s.x;
  poss_s[BWD].y   = s.y-1;
  
  if(checkMove(poss_s[LEFT]) == POSSIBLE) 
    addToStateList(r, poss_s[LEFT], LEFT);
  if(checkMove(poss_s[FWD]) == POSSIBLE) 
    addToStateList(r, poss_s[FWD], FWD);
  if(checkMove(poss_s[RIGHT]) == POSSIBLE) 
    addToStateList(r, poss_s[RIGHT], RIGHT);
  if(checkMove(poss_s[BWD]) == POSSIBLE) 
    addToStateList(r, poss_s[BWD], BWD);
}



/*------------------------------------------------------------------------------
* Function:  updateQTable
* 
* Calculate the Q value for the current state-action pair.
* 
*/
void updateQTable(robot *r) {
  float temporal_diff, target;
  int i;

  int c_row = (r->cur_s.x * ENV_SIZE_X) + r->cur_s.y;
  int c_col = r->cur_action;
  int n_row = (r->next_s.x * ENV_SIZE_X) + r->next_s.y;
  int n_col = r->next_action;
  float maxQ = MAXQ_INIT;

  if(g_rl_choice == QLEARNING) {
    for(i=0; i<4; i++) {
      if(r->Q[n_row][i] > maxQ)
	maxQ = r->Q[n_row][i];
    }
    target = r->reward[r->next_s.x][r->next_s.y] + (discount_factor * maxQ);
  }
  else {
    target = r->reward[r->next_s.x][r->next_s.y] + (discount_factor * r->Q[n_row][n_col]);
  }

  temporal_diff = target - r->Q[c_row][c_col];
  r->Q[c_row][c_col] = r->Q[c_row][c_col] + (step_size*temporal_diff);
}


