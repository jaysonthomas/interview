#ifndef RLOP_H_
#define RLOP_H_

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

// The different steps the robot can take at a time when in the grid world
#define LEFT 	0
#define FWD	1	
#define RIGHT	2
#define BWD	3
#define X	0
#define Y	1

#define POSSIBLE	1
#define NOT_POSSIBLE	0

#define KNOWN		1
#define UNKNOWN		0

// CLIFF
#define ENV_ULIMIT_X	3	// 0-7, so ENV_SIZE_X = 8
#define ENV_ULIMIT_Y	11	// 0-7, so ENV_SIZE_Y = 8
#define ENV_LLIMIT	0
#define ENV_SIZE_X	4
#define ENV_SIZE_Y	12

#define GOAL_X		0
#define GOAL_Y		11

/*
 * CLIFF
 * Specific to the cliff-walk problem
 * If the agent walks into the cliff, a reward of -100 is given
 * For all other states a reward of -1 is given
 * End Goal has no reward.
 */
#define CLIFF		-100
#define NORMAL_REWARD	-1

#define NACTIONS	4
#define NSTATES 	ENV_SIZE_X*ENV_SIZE_Y

#define CURRENT		0
#define NEXT		1

#define GOAL 		100

#define UNEXPLORED_STATE	-2
#define EPSILON			10	// == 10% or 0.1

#define EXPLORATION	'0'
#define EXPLOITATION	'1'

#define MAX_TRIALS	NSTATES
#define MAX_EPISODES	100001

#define IDEAL_SOL	13
#define MAXQ_INIT	-50000

typedef struct {
  int x, y;
} state;

typedef struct {
  state s;
  int a;
} SA;

typedef struct {
  state cur_s, next_s;
  state next_next_s;
  int cur_action, next_action;
  int nmoves;
  float Q[NSTATES][NACTIONS];
  int reward[ENV_SIZE_X][ENV_SIZE_Y];
  SA *exploit_s, *explore_s;
  unsigned int exploit_len, explore_len;
} robot;


void addToStateList(robot *r, state s, int action);
int checkMove(state s); 
void chooseAction(robot *r, int choice);
void updateCurStatus(robot *r);
void updatePossibleActions(robot *r, int choice);
void updateQTable(robot *r);

extern float step_size, discount_factor;

#endif
