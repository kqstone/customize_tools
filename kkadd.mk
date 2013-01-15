include $(PORT_BUILD)/localvar.mk
include $(PORT_BUILD)/porting.mk

RELEASE_FLASHABLE = $(PORT_ROOT)/customize_tools/release_flashablezip.sh
RELEASE_OTA       = $(PORT_ROOT)/customize_tools/release_ota.sh
FORMAT_FRAMEWORK  = $(PORT_ROOT)/customize_tools/formatframework.sh


fullota: BUILD_NUMBER := 3.1.11

releasezip: flashzip otazip
	
flashzip: out/fullota.zip
	$(RELEASE_FLASHABLE) $(BUILD_NUMBER) $(PORT_PRODUCT) $(PORT_ROOT)

otazip: out/target_files.zip
	$(RELEASE_OTA) $(BUILD_NUMBER) $(PORT_PRODUCT) $(PORT_ROOT)

workspacefix: workspace
	$(FORMAT_FRAMEWORK) patch

firstpatchfix: firstpatch
	$(FORMAT_FRAMEWORK) work

%.phone : out/%.jar
	adb remount
	adb push $< /system/framework/$*
	adb shell chmod 644 /system/framework/$*.jar
	adb shell busybox killall system_server

%.platform : out/%
	java -jar $(TOOL_DIR)/signapk.jar $(PORT_ROOT)/build/security/platform.x509.pem $(PORT_ROOT)/build/security/platform.pk8  $< $<.signed
	adb remount
	adb push $<.signed /system/app/$*
	adb shell chmod 644 /system/app/$*



