ARCHS = armv7 arm64 arm64e
TARGET = iphone:14.1:8.0
FINALPACKAGE = 1
include $(THEOS)/makefiles/common.mk

TOOL_NAME = SuccessionCLIhelper

SuccessionCLIhelper_PRIVATE_FRAMEWORKS = SpringBoardServices UIKit Foundation
SuccessionCLIhelper_FILES = hardware.m
SuccessionCLIhelper_CFLAGS = -fobjc-arc -w
SuccessionCLIhelper_CODESIGN_FLAGS = -Sent.plist


include $(THEOS_MAKE_PATH)/tool.mk
SUBPROJECTS += device_info
include $(THEOS_MAKE_PATH)/aggregate.mk
