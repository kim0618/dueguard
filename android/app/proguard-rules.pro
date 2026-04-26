# ===== flutter_local_notifications =====
-keep class com.dexterous.flutterlocalnotifications.** { *; }
-keep class com.dexterous.** { *; }

# ===== Gson - keep all type info for serialization =====
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod
-keepattributes InnerClasses
-keepattributes Exceptions
-keep class com.google.gson.** { *; }
-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer
-keep class com.google.gson.reflect.TypeToken { *; }
-keep class * extends com.google.gson.reflect.TypeToken

-keepclassmembers,allowobfuscation class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# ===== Timezone (used by flutter_local_notifications) =====
-keep class org.threeten.bp.** { *; }
-keep class net.time4j.** { *; }

# ===== Isar database =====
-keep class com.example.** { *; }
-keep class **.*$Schema { *; }

# ===== Permission handler =====
-keep class com.baseflow.permissionhandler.** { *; }

# ===== Path provider =====
-keep class io.flutter.plugins.pathprovider.** { *; }

# ===== Shared preferences =====
-keep class io.flutter.plugins.sharedpreferences.** { *; }

# ===== General Flutter plugins safety =====
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugin.** { *; }

# ===== Play Core (we don't use deferred components, ignore missing) =====
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }
