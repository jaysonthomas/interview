#ifndef MEMMNG_H_
#define MEMMNG_H_

void freeAll(robot *r);
void init(robot *r, char world[ENV_SIZE_X][ENV_SIZE_Y]);
void initEpisode(robot *r, char world[ENV_SIZE_X][ENV_SIZE_Y]);
void initFile(FILE **f, char *file_name);

#endif