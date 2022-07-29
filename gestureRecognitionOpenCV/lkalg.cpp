#include "main.h"
#include "lkalg.h"
#include "display.h"
#include <math.h>

#define PI (3.141592653589793)


/**
 * Finds Vx & Vy of each region
 * Plots Lines based on vector direction and magnitude
 */
void lktracker(int reg_size, Mat &ixframe, Mat &iyframe, Mat &itframe) {
  int i, j;
  int ncol = ixframe.cols - (ixframe.cols % reg_size);
  int nrow = ixframe.rows - (ixframe.rows % reg_size);
  float mag;
  int vind = 0;
  float ratio;
  float theta;
  int bin;
  
  for(i=0; i<nrow; i+=reg_size) {
    for(j=0; j<ncol; j+=reg_size) {
      lsa(i,j, reg_size, ixframe, iyframe, itframe);
    }
  }
  
  for(i=reg_size/2; i<nrow; i+=reg_size) {
    for(j=reg_size/2; j<ncol; j+=reg_size) {
      mag = sqrt((v[vind].x*v[vind].x) + (v[vind].y*v[vind].y));

      if(mag>3 && mag < 2*reg_size) {
	line(output, Point(j*2, i*2), Point((j*2)+(v[vind].x), (i*2)+(v[vind].y)), Scalar((255*mag)/(2*reg_size),0,(255*mag)/(2*reg_size)), 3);
	
	if(v[vind].x == 0)
	  theta = v[vind].y > 0 ? 90 : 270;
	else if(v[vind].y == 0)
	  theta = v[vind].x > 0 ? 0 : 180;
	else{
	  theta = atan((-v[vind].y)/v[vind].x) * 180/PI;
	  if(v[vind].x < 0){
	    theta += 180;
	  }
	}
	theta = theta<0 ? 360+theta : theta;
	
	bin = binAngle(theta);
	
	bins[bin]+=mag; 
      }
      vind++;
    }
  }
  
  
  imshow("OUTPUT", output);
    
}


/**
 * Helps find the dominant direction in the entire frame by
 * allocating a bin for each angle and incrementing it by the magnitude when found
 * 
 * This happens per frame. And bins are reinitialized to 0 every 25 frames.
 */
int binAngle(float theta) {
  if(theta > 22 && theta <= 67)  //45
    return 1;
  
  if(theta > 67 && theta <= 112)  // 90	
    return 2;
  
  if(theta > 112 && theta <= 157) // 135
    return 3;
    
  if(theta > 157 && theta <= 202) // 180
    return 4;
    
  if(theta > 202 && theta <= 247) // 225
    return 5;
    
  if(theta > 247 && theta <= 292) // 270 
    return 6;

  if(theta > 292 && theta <= 337) // 315
    return 7;
  
  return 0;
}



/*
 * Calculation of Vx & Vy per region
 */
void lsa(int irow, int icol, int reg_size, Mat &ixframe, Mat &iyframe, Mat &itframe) {
  int i, j;
  Mat ix_sub, iy_sub, it_sub;
  Mat A = Mat(2, 2, CV_32FC1, Scalar(0));
  Mat B = Mat(2, 1, CV_32FC1, Scalar(0));
  Mat tempv(2, 1, CV_32FC1);
  
  for(i=irow; i<irow+reg_size; i++) {
    for(j=icol; j<icol+reg_size; j++) {
      A.at<float>(0,0) += (ixframe.at<float>(i,j) * ixframe.at<float>(i,j));
      A.at<float>(0,1) += (ixframe.at<float>(i,j) * iyframe.at<float>(i,j));
      A.at<float>(1,1) += (iyframe.at<float>(i,j) * iyframe.at<float>(i,j));
      B.at<float>(0) += (ixframe.at<float>(i,j) * itframe.at<float>(i,j));
      B.at<float>(1) += (iyframe.at<float>(i,j) * itframe.at<float>(i,j));
    }
  }

  if(A.at<float>(0,0) == 0.0 && A.at<float>(0,1) == 0.0 && A.at<float>(1,0) == 0.0 && A.at<float>(1,1) == 0.0){
    v.push_back(Point(0.0,0.0));
    return;
  }
  
  A.at<float>(1,0) = A.at<float>(0,1);
  B.at<float>(0,0) = -B.at<float>(0,0);
  B.at<float>(1,0) = -B.at<float>(1,0);
  tempv = A.inv() * B;
  Mat test = A.inv()*A;
  v.push_back(Point((int)(tempv.at<float>(0)*10), (int)(tempv.at<float>(1)*10)));
}



/*
 * Find gradients in x,y,t directions
 * Applies Lucas Kanade Algorithm
 * Display Output Ix, Iy and It
 */
void lkalg(Mat &ixframe, Mat &iyframe, Mat &itframe) {
  
  gradients(ixframe, iyframe, itframe);
  
  lktracker(cframe_mod.rows/8 , ixframe, iyframe, itframe);
  display(ixframe, "IXFRAME", YES);
  display(iyframe, "IYFRAME", YES);
  display(itframe, "ITFRAME", YES);
}



/*
 * Find Ix - consider 3 columns - 3*3 kernel with middle column = 0
 * Find Iy - consider 3 rows    - 3*3 kernel with middle row = 0
 * Find It - consider 3 rows, 3 columns - 3*3 kernel; all elements considered
 */
void gradients(Mat &ixframe, Mat &iyframe, Mat &itframe) {
  int i, j;
  
  for(i=1; i<cframe_mod.rows-1; i++) {
    for(j=1; j<cframe_mod.cols-1; j++) {
	ixframe.at<float>(i,j) = -cframe_mod.at<float>(i-1,j-1) + cframe_mod.at<float>(i-1,j+1);
      	ixframe.at<float>(i,j) = 2*(-cframe_mod.at<float>(i,j-1) + cframe_mod.at<float>(i,j+1));
	ixframe.at<float>(i,j) += -cframe_mod.at<float>(i+1,j-1) + cframe_mod.at<float>(i+1,j+1);
	ixframe.at<float>(i,j) /= 3;
	
	iyframe.at<float>(i,j) = -cframe_mod.at<float>(i-1,j-1) + cframe_mod.at<float>(i+1,j-1);
	iyframe.at<float>(i,j) = 2*(-cframe_mod.at<float>(i-1,j) + cframe_mod.at<float>(i+1,j));
	iyframe.at<float>(i,j) += -cframe_mod.at<float>(i-1,j+1) + cframe_mod.at<float>(i+1,j+1);
	iyframe.at<float>(i,j) /= 3;
	
	itframe.at<float>(i,j) = nframe_mod.at<float>(i-1,j) - pframe_mod.at<float>(i-1,j);
	itframe.at<float>(i,j) += 2*(nframe_mod.at<float>(i,j) - pframe_mod.at<float>(i,j));
	itframe.at<float>(i,j) += nframe_mod.at<float>(i+1,j) - pframe_mod.at<float>(i+1,j);
	
	itframe.at<float>(i,j) += nframe_mod.at<float>(i-1,j-1) - pframe_mod.at<float>(i-1,j-1);
	itframe.at<float>(i,j) += 2*(nframe_mod.at<float>(i,j-1) - pframe_mod.at<float>(i,j-1));
	itframe.at<float>(i,j) += nframe_mod.at<float>(i+1,j-1) - pframe_mod.at<float>(i+1,j-1);

	itframe.at<float>(i,j) += nframe_mod.at<float>(i-1,j+1) - pframe_mod.at<float>(i-1,j+1);
	itframe.at<float>(i,j) += 2*(nframe_mod.at<float>(i,j+1) - pframe_mod.at<float>(i,j+1));
	itframe.at<float>(i,j) += nframe_mod.at<float>(i+1,j+1) - pframe_mod.at<float>(i+1,j+1);
		
 	itframe.at<float>(i,j) /= 9;
    }
  }
}
