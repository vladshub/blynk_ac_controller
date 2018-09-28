# 
# To build on RaspberryPi:
# 1. Install WiringPi: http://wiringpi.com/download-and-install/
# 2. Run:
#    make target=raspberry
#    sudo blynk --token=YourAuthToken
#

CC ?= gcc
CXX ?= g++
CXXFLAGS += -I ./blynk-library/src/ -I ./blynk-library/linux -DLINUX
LDFLAGS += -lrt -lpthread

ifeq ($(build),debug)
	CXXFLAGS += -c -g2 -O0 \
		-Wall -Weffc++ \
		-Wextra -Wcast-align \
		-Wchar-subscripts  -Wcomment -Wconversion \
		-Wdisabled-optimization \
		-Wfloat-equal  -Wformat  -Wformat=2 \
		-Wformat-nonliteral -Wformat-security  \
		-Wformat-y2k \
		-Wimplicit  -Wimport  -Winit-self  -Winline \
		-Winvalid-pch   \
		-Wunsafe-loop-optimizations  -Wlong-long -Wmissing-braces \
		-Wmissing-field-initializers -Wmissing-format-attribute   \
		-Wmissing-include-dirs -Wmissing-noreturn \
		-Wpacked  -Wparentheses  -Wpointer-arith \
		-Wredundant-decls -Wreturn-type \
		-Wsequence-point  -Wshadow -Wsign-compare  -Wstack-protector \
		-Wstrict-aliasing -Wstrict-aliasing=2 -Wswitch  -Wswitch-default \
		-Wswitch-enum -Wtrigraphs  -Wuninitialized \
		-Wunknown-pragmas  -Wunreachable-code -Wunused \
		-Wunused-function  -Wunused-label  \
		-Wunused-value  -Wunused-variable \
		-Wvolatile-register-var  -Wwrite-strings
	
	# Disable some warnings
	CXXFLAGS += -Wno-variadic-macros -Wno-unused-parameter -Wno-vla
	
	# Uncomment this to get pedantic warnings:
	#CXXFLAGS += -pedantic -Wvariadic-macros -Wunused-parameter -Waggregate-return -Wcast-qual -Wpadded
else
	CXXFLAGS += -c -O3 -w
	LDFLAGS += -s
endif

ifeq ($(target),raspberry)
	CXXFLAGS += -DRASPBERRY
	LDFLAGS += -lwiringPi
endif

SOURCES=src/main.cc #\
#	./blynk-library/src/utility/BlynkDebug.cpp \
#	./blynk-library/src/utility/BlynkHandlers.cpp \
#	./blynk-library/src/utility/BlynkTimer.cpp

OBJECTS=$(SOURCES:.cc=.o)
EXECUTABLE=blynk

all: $(SOURCES) $(EXECUTABLE)

clean:
	-rm $(OBJECTS) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS) 
	$(CXX) $(OBJECTS) $(LDFLAGS) -o $@

.cpp.o:
	$(CXX) $(CXXFLAGS) $< -o $@