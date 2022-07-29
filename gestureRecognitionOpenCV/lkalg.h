#ifndef LKALG_H_
#define LKALG_H_

void lsa(int irow, int icol, int reg_size, Mat &ixframe, Mat &iyframe, Mat &itframe);
void lktracker(int reg_size, Mat &ixframe, Mat &iyframe, Mat &itframe);
void lkalg(Mat &ixframe, Mat &iyframe, Mat &itframe);
void gradients(Mat &ixframe, Mat &iyframe, Mat &itframe);
int binAngle(float theta);

#endif