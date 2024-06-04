CC = clang
FRAMEWORKS = -framework Foundation -framework AppKit -framework CoreFoundation
CFLAGS = -Wall

TARGET = trash
SOURCES = trash.m
PREFIX ?= /usr/local/bin

.PHONY: all clean

TEST_DIR = test
TEST_FILES = file1.txt file2.txt file3.txt

all: $(TARGET)

$(TARGET): $(SOURCES)
		$(CC) $(CFLAGS) $(FRAMEWORKS) -o $@ $<

clean:
		rm -f $(TARGET)

install: $(TARGET)
		mkdir -p $(PREFIX)
		cp $(TARGET) $(PREFIX)
		chmod +x $(PREFIX)/$(TARGET)

uninstall:
		rm -f $(PREFIX)/$(TARGET)

test: $(TARGET)
		mkdir -p $(TEST_DIR)
		touch $(addprefix $(TEST_DIR)/, $(TEST_FILES))
		./$(TARGET) $(addprefix $(TEST_DIR)/, $(TEST_FILES))
		rm -rf $(TEST_DIR)
