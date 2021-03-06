CFLAGS =

all: fun

debug: CFLAGS += -DDEBUG -g
debug: fun

fun: fun.o machine.o
	gcc -o $@ $^ -ll $(CFLAGS)

%.o: %.c
	gcc -c $^ $(CFLAGS)

fun.c: fun.yacc lex.yy.c
	yacc -o $@ $<

lex.yy.c: fun.lex
	lex -o $@ $^

basic-test: fun
	./fun < test/test.integer.fun
	./fun < test/test.quote.fun
	./fun < test/test.lambda.fun
	./fun < test/test.let.fun
	./fun < test/test.letx.fun
	./fun < test/test.application.fun

complex-test: fun
	#./fun < test/test.lambda0.fun
	#./fun < test/test.lambda1.fun
	#./fun < test/test.lambda2.fun
	#./fun < test/test.lambda3.fun
	./fun < test/test.cons.fun
	#./fun < test/test.fst.fun
	#./fun < test/test.snd.fun

clean:
	rm -rf fun lex.yy.c machine.o fun.o fun.c debug.log

mrproper: clean
	rm -rf *~ \#*\#
