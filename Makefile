ARCHS = arm64 arm64e
TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard



include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Avya
export SDKVERSION = 13.7
Avya_LIBRARIES = activator

Avya_FILES = Tweak.xm
Avya_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += avyapre
include $(THEOS_MAKE_PATH)/aggregate.mk
