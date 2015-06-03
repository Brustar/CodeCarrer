LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := cocos2dlua_shared

LOCAL_MODULE_FILENAME := libcocos2dlua

LOCAL_SRC_FILES := \
../../Classes/AppDelegate.cpp \
../../Classes/ide-support/SimpleConfigParser.cpp \
../../Classes/PB/EncryDecry.c \
../../Classes/PB/pb.c \
../../Classes/DES/des.cpp \
../../Classes/zip/luazip.c \
../../Classes/zzip/dir.c \
../../Classes/zzip/err.c \
../../Classes/zzip/file.c \
../../Classes/zzip/info.c \
../../Classes/zzip/plugin.c \
../../Classes/zzip/stat.c \
../../Classes/zzip/write.c \
../../Classes/zzip/zip.c \
../../Classes/MD5/compat-5.2.c \
../../Classes/MD5/md5.c \
../../Classes/MD5/md5lib.c \
hellolua/main.cpp 

LOCAL_C_INCLUDES := \
$(LOCAL_PATH)/../../Classes/protobuf-lite \
$(LOCAL_PATH)/../../Classes/runtime \
$(LOCAL_PATH)/../../Classes \
$(LOCAL_PATH)/../../../cocos2d-x/external \
$(LOCAL_PATH)/../../../cocos2d-x/tools/simulator/libsimulator/lib

# _COCOS_HEADER_ANDROID_BEGIN
# _COCOS_HEADER_ANDROID_END

LOCAL_STATIC_LIBRARIES := cocos2d_lua_static
LOCAL_STATIC_LIBRARIES += cocos2d_simulator_static

# _COCOS_LIB_ANDROID_BEGIN
# _COCOS_LIB_ANDROID_END

include $(BUILD_SHARED_LIBRARY)

$(call import-module,scripting/lua-bindings/proj.android)
$(call import-module,tools/simulator/libsimulator/proj.android)

# _COCOS_LIB_IMPORT_ANDROID_BEGIN
# _COCOS_LIB_IMPORT_ANDROID_END
