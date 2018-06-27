LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := unzip_recovery
LOCAL_MODULE_STEM := unzip
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := \
	match.c \
	inflate.c \
	crc32.c \
	ttyio.c \
	extract.c \
	globals.c \
	unreduce.c \
	envargs.c \
	ubz2err.c \
	unzip.c \
	unshrink.c \
	fileio.c \
	explode.c \
	zipinfo.c \
	crypt.c \
	list.c \
	process.c \
	unix/unix.c

LOCAL_LDFLAGS :=
LOCAL_CFLAGS := -DACORN_FTYPE_NFS -DWILD_STOP_AT_DIR -DLARGE_FILE_SUPPORT \
	-DUNICODE_SUPPORT -DUNICODE_WCHAR -DUTF8_MAYBE_NATIVE -DNO_LCHMOD \
	-DDATE_FORMAT=DF_YMD -DUSE_BZIP2 -DIZ_HAVE_UXUIDGID -DNOMEMCPY \
	-DNO_WORKING_ISPRINT -DNO_LANGINFO_H -Wno-format-security

ifneq ($(TARGET_ARCH), arm64)
    ifneq ($(TARGET_ARCH), x86_64)
        LOCAL_LDFLAGS += -Wl,-dynamic-linker,/sbin/linker
    else
        LOCAL_LDFLAGS += -Wl,-dynamic-linker,/sbin/linker64
    endif
else
    LOCAL_LDFLAGS += -Wl,-dynamic-linker,/sbin/linker64
endif

LOCAL_C_INCLUDES := \
	external/bzip2/include

LOCAL_STATIC_LIBRARIES := libbz
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
include $(BUILD_EXECUTABLE)
