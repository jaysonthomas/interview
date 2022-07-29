#ifndef RLMAIN_H_
#define RLMAIN_H_

#define MAX_RECORDS	10

#define QLEARNING	0
#define SARSA		1

#define CONVGCHK_GAP	3000

void sarsa(robot *r, char world[ENV_SIZE_X][ENV_SIZE_Y], float result[MAX_EPISODES][2]);
void sarsaCliff(robot *r);
void qLearning(robot *r, char world[ENV_SIZE_X][ENV_SIZE_Y], float result[MAX_EPISODES][2]);
void qLearningCliff(robot *r);

extern int g_rl_choice;

#endif