#!/bin/bash

source ./scripts/variables.sh

# Build iOS
cd ./rust

cargo lipo --release

cbindgen ./src/lib.rs -c cbindgen.toml | grep -v \#include | uniq | cat > target/bindings.h

cp "./target/universal/release/lib${LIB_NAME}.a" "../ios/lib${LIB_NAME}.a"

# build for macos
cargo build
cp "./target/debug/lib${LIB_NAME}.dylib" "../macos/lib${LIB_NAME}.dylib"
# build for linux
cp "./target/debug/lib${LIB_NAME}.dylib" "../linux/lib${LIB_NAME}.dylib"


echo "#import <Flutter/Flutter.h>

@interface P4dRustBindingPlugin : NSObject<FlutterPlugin>
@end" > ../ios/Classes/P4dRustBindingPlugin.h

cat ./target/bindings.h >> ../ios/Classes/P4dRustBindingPlugin.h




CC_aarch64_linux_android="${ANDROID_PREBUILD_BIN}/aarch64-linux-android${API_LEVEL}-clang" \
AR_aarch64_linux_android="${ANDROID_PREBUILD_BIN}/aarch64-linux-android-ar" \
CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER="${ANDROID_PREBUILD_BIN}/aarch64-linux-android${API_LEVEL}-clang" \
  cargo build --target aarch64-linux-android --release

CC_armv7_linux_androideabi="${ANDROID_PREBUILD_BIN}/armv7a-linux-androideabi${API_LEVEL}-clang" \
AR_armv7_linux_androideabi="${ANDROID_PREBUILD_BIN}/arm-linux-androideabi-ar" \
CARGO_TARGET_ARMV7_LINUX_ANDROIDEABI_LINKER="${ANDROID_PREBUILD_BIN}/armv7a-linux-androideabi${API_LEVEL}-clang" \
  cargo build --target armv7-linux-androideabi --release

CC_i686_linux_android="${ANDROID_PREBUILD_BIN}/i686-linux-android${API_LEVEL}-clang" \
AR_i686_linux_android="${ANDROID_PREBUILD_BIN}/i686-linux-android-ar" \
CARGO_TARGET_I686_LINUX_ANDROID_LINKER="${ANDROID_PREBUILD_BIN}/i686-linux-android${API_LEVEL}-clang" \
  cargo  build --target i686-linux-android --release

CC_x86_64_linux_android="${ANDROID_PREBUILD_BIN}/x86_64-linux-android${API_LEVEL}-clang" \
AR_x86_64_linux_android="${ANDROID_PREBUILD_BIN}/x86_64-linux-android-ar" \
CARGO_TARGET_X86_64_LINUX_ANDROID_LINKER="${ANDROID_PREBUILD_BIN}/x86_64-linux-android${API_LEVEL}-clang" \
  cargo  build --target x86_64-linux-android --release

for i in "${!ANDROID_ARCHS[@]}";
  do
    mkdir -p "../android/src/main/jniLibs/${ANDROID_FOLDER[$i]}"
    cp "./target/${ANDROID_ARCHS[$i]}/release/lib${LIB_NAME}.so" "../android/src/main/jniLibs/${ANDROID_FOLDER[$i]}/lib${LIB_NAME}.so"
done

#echo "hello tom" > read.txt
#cat read.txt
