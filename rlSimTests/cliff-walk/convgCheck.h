#ifndef CONVGCHECK_H_
#define CONVGCHECK_H_

#define CONVERGENCE	'1'
#define DIVERGENCE	'0'

unsigned char chkConvg(FILE *f, robot *r, int *prev_sol);

#endif