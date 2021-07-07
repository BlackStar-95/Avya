ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk
SYSROOT=$(THEOS)/sdks/iPhoneOS14.4.sdk

BUNDLE_NAME = AvyaPre
AvyaPre_FILES = AvyRootListController.m
AvyaPre_FRAMEWORKS = UIKit
AvyaPre_PRIVATE_FRAMEWORKS = Preferences
AvyaPre_INSTALL_PATH = /Library/PreferenceBundles
AvyaPre_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/AvyaPre.plist$(ECHO_END)
