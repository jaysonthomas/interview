OBJS:=         main.o display.o lkalg.o

CPPFLAGS:= -I/usr/local/include/opencv4 -I/usr/local/include
CVLIBS:= -L/usr/local/lib/ -lopencv_videoio -lopencv_core -lopencv_imgproc -lopencv_highgui -lopencv_ml -lopencv_video -lopencv_features2d -lopencv_calib3d -lopencv_objdetect -lopencv_flann

main:  		$(OBJS) 
			g++ $(OBJS) $(CVLIBS) -O3 -ffast-math -o main -Wall -g

main.o:         main.h
			g++ $(CPPFLAGS) -c main.cpp -Wall -g

lkalg.o:        lkalg.h main.h
			g++ $(CPPFLAGS) -c lkalg.cpp -Wall -g

display.o:       display.h main.h
			g++ $(CPPFLAGS) -c display.cpp -Wall -g

clean:
			rm -rf *~ *.o main *.png

# Removed -lopencv_contrib -lopencv_legacy