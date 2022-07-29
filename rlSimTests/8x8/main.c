#include "rlOp.h"
#include "rlMain.h"
#include "memMng.h"
#include <time.h>

void save(FILE *f, float result[MAX_EPISODES][2]);
int g_rl_choice;

/*------------------------------------------------------------------------------
 * Function:  main
 * 
 * Reward Table is of size ENV_SIZE_X*ENV_SIZE_Y
 * Q Table is of size NSTATES*NACTIONS
 * prev_sol: helps keep track of convergence - refer to convgCheck(..)
 * r.nmoves: (variable within the robot structure) 
 *           keeps track of the no. of moves made within an episode
 * nepisodes: keeps track of the no. of episodes run so far
 * 
 * moves_file refers to the file nmoves.txt which contains the data:
 * "Episode number - No. of trial moves done in that episode - 
 *  current solution by following the greedy path, i.e. 
 *  no. of moves taken from start to end"
 * 
*/
int main(int argc, char *argv[]) {
  char world[ENV_SIZE_X][ENV_SIZE_Y];
  robot r;
  FILE *moves_file;
  int nrecords = 0;
  float result[MAX_EPISODES][2];
  int i;
  
  printf("\nEnter RL choice [0-QLearning, 1-SARSA]: ");
  scanf("%d", &g_rl_choice);   
  
  initFile(&moves_file, "nmoves.txt");
  for(i=0; i<MAX_EPISODES; i++)
    result[i][0] = result[i][1] = 0;
  
  srand(time(NULL));
  
  while(nrecords != MAX_RECORDS) {
    init(&r, world);  
    
    if(g_rl_choice == QLEARNING) 
      qLearning(&r, world, result);
    else
      sarsa(&r, world, result);
    
    nrecords++;
  }

  save(moves_file, result);
  fclose(moves_file);
  return 0;
}



/*------------------------------------------------------------------------------
 * Function: save
 * 
 * 
 */
void save(FILE *f, float result[MAX_EPISODES][2]) {
  int i, j;
  
  for(i=0; i<MAX_EPISODES; i++) 
    for(j=0; j<2; j++)
      result[i][j] /= MAX_RECORDS;
    
  for(i=0; i<MAX_EPISODES; i+=CONVGCHK_GAP) {
    if(fprintf(f, "%d\t%f\t%f\t%d\n", i, result[i][0], result[i][1], IDEAL_SOL) < 0) {
      printf("ERROR: File write in main()\n");
      fclose(f);
      exit(1);
    }
  }
}

