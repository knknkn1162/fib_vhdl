GHDLC=ghdl
WORKDIR=.
VCDFILE=${WORKDIR}/out.vcd
FLAGS=--warn-error --workdir=${WORKDIR}/
#TB_OPTION=--assert-level=error
MODULES=\
	decoder \
	num2str10 \
	calc
TESTS=\
	num2str10 \
	calc
OBJS=$(addsuffix .o, ${MODULES})
TESTBENCHES=$(addsuffix _tb, ${TESTS})


.PHONY: all clean open
all: $(OBJS) $(TESTBENCHES)
clean:
	git ls-files --others --ignored --exclude-standard | xargs rm -rfv
open:
	open out.vcd

%_tb: %_tb.o
	$(GHDLC) -e $(FLAGS) $@
	$(GHDLC) -r ${FLAGS} $@ --vcd=${VCDFILE} ${TB_OPTION}

%.o: %.vhdl
	$(GHDLC) -a $(FLAGS) $<
