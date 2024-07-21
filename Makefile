RM			= rm -f
MKDIR		= mkdir -p

SOURCES		= $(shell find src -type f -iname "*.c" -o -iname "*.s")
OBJECTS		= $(patsubst src/%.s,out/%.o,$(patsubst src/%.c,out/%.o,$(SOURCES)))
TARGET		= ./out/sxf

CC			= cc65
CFLAGS		= -std=c++17 -Wall -Wextra -Wpedantic

AS			= ca65
ASFLAGS		= 

LD			= ld65
LDFLAGS		= 

FCEUX		= fceux

ifeq ($(origin DEBUG), environment)
	CFLAGS += -Og -g -DSXF_DEBUG
else
	CFLAGS += -O2
endif

all: sxf

clean:
	$(RM) $(TARGET) $(OBJECTS)

sxf: $(OBJECTS)
	$(LD) -o $(TARGET) $^ $(LDFLAGS)

out/%.o: src/%.c src/%.s | create_dirs
	$(CXX) $(CXXFLAGS) -c $^ -o $@ $(LDFLAGS)

create_dirs:
	@$(MKDIR) $(sort $(dir $(OBJECTS)))

test:
	$(FCEUX)
