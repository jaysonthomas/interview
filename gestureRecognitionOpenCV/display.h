#ifndef DISPLAY_H_
#define DISPLAY_H_

float map_pix(float x, float in_min, float in_max, float out_min, float out_max);
void normalize(Mat &frame);
void display(Mat &frame, char* win_frame, char disp_option);
void print_dir();

#endif