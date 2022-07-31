OBJS:=         main.o display.o lkalg.o

CV_LIBS:= 	-I/usr/local/include/opencv4 -I/usr/local/include  -L/usr/local/lib/ -lopencv_core -lopencv_imgproc -lopencv_highgui -lopencv_ml -lopencv_video -lopencv_features2d -lopencv_calib3d -lopencv_objdetect -lopencv_contrib -lopencv_legacy -lopencv_flann


main:  		$(OBJS) 
			g++ $(OBJS) $(CV_LIBS) -O3 -ffast-math -o main -Wall -g

main.o:         main.h
			g++ -c main.cpp -Wall -g

lkalg.o:        lkalg.h main.h
			g++ -c lkalg.cpp -Wall -g

display.o:       display.h main.h
			g++ -c display.cpp -Wall -g

clean:
			rm -rf *~ *.o main *.png
