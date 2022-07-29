#include "main.h"
#include "display.h"


/*
 * Normalize image and display
 */
void display(Mat &frame, char* win_frame, char disp_option) {
  Mat disp_frame, output_frame;
  disp_frame = frame.clone();  
 
  if(disp_option == YES) {
      normalize(disp_frame);  
      imshow(win_frame, disp_frame);
      return;
  }

  imshow(win_frame, frame);
}


void normalize(Mat &frame) {
  int i, j;
  float min = 10000, max = -10000;
  
  for(i=0; i<frame.rows; i++) {
    for(j=0; j<frame.cols; j++) {
      if(frame.at<float>(i,j) > max)
	max = frame.at<float>(i,j);
      else if(frame.at<float>(i,j) < min)
	min = frame.at<float>(i,j);
    }
  }

  for(i=0; i<frame.rows; i++) {
    for(j=0; j<frame.cols; j++) { 
      frame.at<float>(i,j) = map_pix(frame.at<float>(i,j), min, max, 0, 1);
    }
  }
}


void print_dir(){
  int max = 0;
  int i, index = -1;
  
  for(i = 0; i < 8; i++){
    if(bins[i] > max){
      max = bins[i];
      index = i;
    }
    bins[i] = 0;
  }
  if(index != -1){
    switch (index){
      case 0:
	printf("HORIZONTAL LEFT->RIGHT\n");
	break;
      case 1:
	printf("----DIAGONAL LEFT,DOWN->RIGHT,UP\n");
	break;
      case 2:
	printf("VERTICAL DOWN->UP\n");
	break;
      case 3:
	printf("----DIAGONAL RIGHT,DOWN->LEFT,UP\n");
	break;
      case 4:
	printf("HORIZONTAL RIGHT->LEFT\n");
	break;
      case 5:
	printf("----DIAGONAL RIGHT,UP->LEFT,DOWN\n");
	break;
      case 6:
	printf("VERTICAL UP->DOWN\n");
	break;
      case 7:
	printf("----DIAGONAL LEFT,UP->RIGHT,DOWN\n");
	break;
    }
    
  }
}

/*------------------------------------------------------------------------------
 * Function: map
 * 
 * Maps a value from the input range: in_min - in_max to the
 * output-range: out_min - out_max
 */
float map_pix(float x, float in_min, float in_max, float out_min, float out_max)
{
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

