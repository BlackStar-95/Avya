ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard
THEOS_DEVICE_IP = 192.168.1.46
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Avya
Avya_LIBRARIES = activator

Avya_FILES = Tweak.xm
Avya_CFLAGS = -fobjc-arc
Avya_FRAMEWORKS = UIKit
Avya_EXTRA_FRAMEWORKS += Cephei Alderis

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += avyapre
include $(THEOS_MAKE_PATH)/aggregate.mk
