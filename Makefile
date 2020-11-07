AMP = @

CC = ${AMP}gcc
CC_FLAGS = -fPIC -Wall

INCLUDE_FLAG = -Iinclude
LINK_FLAG = -lshakespeare

AR = ${AMP}ar
RM = ${AMP}rm -f

SHAKESPEARE_NAMES = 
SHAKESPEARE_NAMES += types
SHAKESPEARE_NAMES += shakespeare

SHAKESPEARE_OBJ_NAMES = ${addsuffix .o, ${SHAKESPEARE_NAMES}}
SHAKESPEARE_OBJS = ${addprefix build/, ${SHAKESPEARE_OBJ_NAMES}}



SHAKESPEARE_EXAMPLE_NAMES = 
SHAKESPEARE_EXAMPLE_NAMES += romeo

SHAKESPEARE_EXAMPLE_EXES = ${addprefix build/examples/, ${SHAKESPEARE_EXAMPLE_NAMES}}



SHAKESPEARE_STATIC_LIB = build/libshakespeare.a
SHAKESPEARE_DYNAMIC_LIB = build/libshakespeare.so

default: clean lib examples

lib: ${SHAKESPEARE_STATIC_LIB} ${SHAKESPEARE_DYNAMIC_LIB}

examples: ${SHAKESPEARE_EXAMPLE_EXES}

debug:
	${eval AMP := }


${SHAKESPEARE_OBJS}: build/%.o: lib/%.c include/shakespeare/%.h
	${CC} -c ${CC_FLAGS} $< -o $@ ${INCLUDE_FLAG}

${SHAKESPEARE_EXAMPLE_EXES}: build/examples/%: examples/%.c
	${CC} -o ${CC_FLAGS} $< -o $@ ${INCLUDE_FLAG} ${SHAKESPEARE_STATIC_LIB}

${SHAKESPEARE_STATIC_LIB}: ${SHAKESPEARE_OBJS}
	${AR} rcs $@ $^

${SHAKESPEARE_DYNAMIC_LIB}: ${SHAKESPEARE_OBJS}
	${CC} -shared $^ -o $@


redo: clean default

move:
	sudo cp ${BIN} /usr/bin

clean:
	${RM} ${SHAKESPEARE_OBJS}
	${RM} ${SHAKESPEARE_STATIC_LIB}
	${RM} ${SHAKESPEARE_DYNAMIC_LIB}
	${RM} ${SHAKESPEARE_EXAMPLE_EXES}


