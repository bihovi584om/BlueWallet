# script thats used to build & sign release APK in preparation for Detox e2e testing.

# deleting old artifacts
find android | grep '\.apk' --color=never | xargs -l rm

# creating fresh keystore
rm detox.keystore
keytool -genkeypair -v -keystore detox.keystore -alias detox  -keyalg RSA -keysize 2048 -validity 10000 -storepass 123456 -keypass 123456 -dname  'cn=Unknown, ou=Unknown, o=Unknown, c=Unknown'

# building release APK
cd android && ./gradlew assembleRelease assembleAndroidTest -DtestBuildType=release && cd ..

# signing
echo wheres waldo?
find $ANDROID_HOME | grep apksigner | grep -v jar
mv ./android/app/build/outputs/apk/release/app-release-unsigned.apk ./android/app/build/outputs/apk/release/app-release.apk
$ANDROID_HOME/build-tools/35.0.0/apksigner sign --ks detox.keystore   --ks-pass=pass:123456 ./android/app/build/outputs/apk/release/app-release.apk
$ANDROID_HOME/build-tools/35.0.0/apksigner sign --ks detox.keystore   --ks-pass=pass:123456 ./android/app/build/outputs/apk/androidTest/release/app-release-androidTest.apk
