#include "rlOp.h"
#include "memMng.h"



//------------------------------------------------------------------------------
//
// Function:  freeAll
//
// Free the exploration/exploitation state/action lists and set them to NULL
// Set their lengths to 0
//
void freeAll(robot *r) {
  free(r->explore_s);
  free(r->exploit_s);
  r->explore_len = r->exploit_len = 0;
  r->explore_s   = r->exploit_s   = NULL;
}



/*
 * ------------------------------------------------------------------------------
 * Function:  init
 * 
 * Initialize
 * 1. world - all -1s except the goal state, which is 100 and the CLIFF which is -100
 * 2. reward table - all 'UNEXPLORED_STATE', initially
 * 3. Q table - all 0s
 */
void init(robot *r, char world[ENV_SIZE_X][ENV_SIZE_Y]) {
  memset(world, 0, sizeof(world[0][0])*NSTATES);
  
  /*
   * Specific to the 8*8 grid world with obstacles problem
   */
  world[GOAL_X][GOAL_Y] = GOAL;
  world[0][2] = world[1][0] = world[2][2] = world[2][4] = world[3][2] = world[3][5] = world[4][3] = world[4][5] = OBSTACLE;
  
  memset(r->reward, UNEXPLORED_STATE, sizeof(r->reward[0][0])*NSTATES);
  memset(r->Q, 0, sizeof(r->Q[0][0])*NSTATES*NACTIONS);
}



/*------------------------------------------------------------------------------
* Function:  initEpisode
* 
* Initialize 
* 1. current state to (0,0)
* 2. current action to 'move left'
* 3. Explore and exploit states list to NULL & their lengths to 0 
*/
void initEpisode(robot *r, char world[ENV_SIZE_X][ENV_SIZE_Y]) {
  r->cur_s.x = r->cur_s.y = r->cur_action = 0;
  r->nmoves = 0;
  
  r->exploit_s = r->explore_s = NULL;
  r->explore_len = r->exploit_len = 0;
}



/*------------------------------------------------------------------------------
 * Function: initFile
 * Open the file referred to by 'file_name' and return 
 * the file pointer via 'f'
 */
void initFile(FILE **f, char *file_name) {
  *f = fopen(file_name, "w");
  if(!f) {
    printf("ERROR: fopen(%s)\n", file_name);
    exit(1);
  }
}


