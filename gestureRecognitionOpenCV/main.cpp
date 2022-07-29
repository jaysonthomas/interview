#include "main.h"
#include "lkalg.h"
#include "display.h"


Mat output;
Mat cframe_mod, nframe_mod, pframe_mod;
vector<Point> v;
int bins[8];


int main( int argc, const char** argv )
{
  cv::VideoCapture cap;
  if(argc > 1) 
    cap.open(string(argv[1]));
  else
    cap.open(CV_CAP_ANY);

  if(!cap.isOpened())
    printf("Error: could not load a camera or video.\n");

  namedWindow("INPUT", 1);
  namedWindow("IXFRAME", 1);
  namedWindow("IYFRAME", 1);
  namedWindow("ITFRAME", 1);
  namedWindow("OUTPUT", 1);
  
  Mat cframe, nframe, pframe;
  Mat ixframe, iyframe, itframe;
  
  cap >> pframe;
  cvtColor( pframe, pframe, CV_BGR2GRAY );
  resize(pframe, pframe_mod, Size(pframe.cols/2, pframe.rows/2), 0.5, 0.5, INTER_NEAREST);
  pframe_mod.convertTo(pframe_mod, CV_32F, 1.0/255.0);

  cap >> cframe;
  cvtColor( cframe, cframe, CV_BGR2GRAY );
  resize(cframe, cframe_mod, Size(cframe.cols/2, cframe.rows/2), 0.5, 0.5, INTER_NEAREST);
  cframe_mod.convertTo(cframe_mod, CV_32F, 1.0/255.0);
  
  ixframe.create(cframe_mod.size(), CV_32FC1);
  iyframe.create(cframe_mod.size(), CV_32FC1);
  itframe.create(cframe_mod.size(), CV_32FC1);
  
  int frame_count = 3;
  
  for(;;)
  {
    // Dominant direction calculation happens every 25 frames
    if(frame_count % 25){
      print_dir();
    }
    
    waitKey(20);
    cap >> nframe;
    output = nframe.clone();
    cvtColor( nframe, nframe, CV_BGR2GRAY );
    resize(nframe, nframe_mod, Size(nframe.cols/2, nframe.rows/2), 0.5, 0.5, INTER_NEAREST);
    nframe_mod.convertTo(nframe_mod, CV_32F, 1.0/255.0);
    
    if(!nframe.data) {
      printf("Error: no frame data.\n");
      break;
    }
    
    v.clear();
    lkalg(ixframe, iyframe, itframe);
    pframe_mod = cframe_mod.clone();
    cframe_mod = nframe_mod.clone();
    
    frame_count++;
  }
}


