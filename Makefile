ARCHS = arm64 arm64e
THEOS_DEVICE_IP = 192.168.50.75
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Avya
Avya_LIBRARIES = activator

Avya_FILES = Tweak.xm
Avya_CFLAGS = -fobjc-arc
Avya_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += avyapre
include $(THEOS_MAKE_PATH)/aggregate.mk
