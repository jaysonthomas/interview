#ifndef MAIN_H_
#define MAIN_H_

#include "/usr/local/include/opencv4/opencv2/objdetect/objdetect.hpp"
// #include </usr/local/include/opencv4/opencv2/objdetect/objdetect.hpp>
// #include </usr/local/include/opencv4/opencv2/highgui/highgui.hpp>
// #include </usr/local/include/opencv4/opencv2/imgproc/imgproc.hpp>

#include <iostream>
#include <stdio.h>

using namespace std;
using namespace cv;

#define	YES	1
#define NO	0

extern Mat output;
extern Mat pframe_mod, nframe_mod, cframe_mod;
extern vector<Point> v;
extern int bins[8];

#endif