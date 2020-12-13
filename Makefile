ARCHS =  arm64
TARGET = iphone:14.1:8.0
FINALPACKAGE = 1
include $(THEOS)/makefiles/common.mk

TOOL_NAME = succession_c

succession_c_FRAMEWORKS = SpringBoardServices
succession_c_FRAMEWORKS = UIKit Foundation
succession_c_FILES = main.m 
succession_c_CFLAGS = -fobjc-arc -I/usr/include
succession_c_LIBRARIES += curl


succession_c_CODESIGN_FLAGS = -Sent.plist


include $(THEOS_MAKE_PATH)/tool.mk
