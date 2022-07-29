#ifndef RLMAIN_H_
#define RLMAIN_H_

#define MAX_RECORDS	10

#define QLEARNING	0
#define SARSA		1

#define CONVGCHK_GAP	10

void qLearning(robot *r, char world[ENV_SIZE_X][ENV_SIZE_Y], float result[MAX_EPISODES][2]);
void sarsa(robot *r, char world[ENV_SIZE_X][ENV_SIZE_Y], float result[MAX_EPISODES][2]);

extern int g_rl_choice;

#endif