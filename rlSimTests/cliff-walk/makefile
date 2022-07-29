OBJS:= 	convgCheck.o main.o memMng.o rlMain.o rlOp.o 

rl:	 	$(OBJS)
		gcc $(OBJS) -o rl -Wall -g

main.o: 	
		gcc -c main.c -Wall -g

rlMain.o: 	rlMain.h
		gcc -c rlMain.c -Wall -g

rlOp.o:	 	rlOp.h
		gcc -c rlOp.c -Wall -g

memMng.o:	memMng.h
		gcc -c memMng.c -Wall -g

convgCheck.o:	convgCheck.h
		gcc -c convgCheck.c -Wall -g

clean:
	rm -rf *~ *.o

