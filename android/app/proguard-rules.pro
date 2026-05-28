# Flutter & Firebase ProGuard rules

# Keep Firebase classes
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Keep Google Play Services
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

# Keep ReLinker (used by Flutter JNI)
-keep class com.getkeepsafe.relinker.** { *; }
-dontwarn com.getkeepsafe.relinker.**

# Keep Flutter embedding
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**
