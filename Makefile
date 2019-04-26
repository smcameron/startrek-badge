
ECHO=echo

ifeq (${V},1)
Q=
else
Q=@
endif

OPENSCAD=$(ECHO) '  OPENSCAD' $< && openscad -o $@ $<

all:	startrek-badge.stl

%.stl:	%.scad
	$(Q)$(OPENSCAD)

clean:
	rm -f startrek-badge.stl

