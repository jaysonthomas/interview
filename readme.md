# Todo
- Gesture recognition
  - Brief description [Done]
  - Explain how to run the software
- Particle filter
  - Convert to python
  - Brief explanation of functionality
- RL test
  - Brief explanation of functionality
- 5DOF arm kinematics
  - Add code
  - Brief description

# Gesture recognition using OpenCV
Input: a video file or a camera feed. 

The Lucas Kanade algorithm is used to detect movements in the input.  
No frames are skipped - at each time step 3 frames are considered.

- Gradient Calculation  
A 3x3 sobel like kernel is used giving more priority to middle pixels to compute the Ix, Iy and It gradients per frame. A neighbourhood of pixels rather than just 2 pixels is considered to make the output more robust to noise interference.

- Vector Calculation  
Lucas Kanade equations are applied per region to calculate the vectors Vx and Vy. 
The region size changes in proportion to the frame size. This proportion which was selected based on tests performed, guarantees that:
    - a region is neither too small to avoid noise interference
    - nor too big so as not to go against the Lucas Kanade assumption that a region consists
of vectors that have constant velocities.

- Plotting Vectors on screen  
We exclude vectors that are too small caused due to background noise and vectors that are too long caused by Lucas Kanade's algorithm failing at edges.

- Gesture recognition  
Each direction is mapped onto an 8 bin histogram [0-360 degrees] spanning 45 degrees each and accumulated over 25 frames. A direction when added to its corresponding bin is also weighted according to its magnitude. The histogram peak decides the dominant gesture direction.

- Final output  
The display includes
    - Ix, Iy, It frames
    - Output frame with the vectors Vx and Vy displayed for each region
    - Dominant direction per 25 frames displayed on the terminal