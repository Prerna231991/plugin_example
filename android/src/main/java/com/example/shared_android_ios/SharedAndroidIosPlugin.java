package com.example.shared_android_ios;

import android.content.Intent;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
  import io.flutter.embedding.engine.plugins.activity.ActivityAware  ;


import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;

  import android.app.Activity;

/** SharedAndroidIosPlugin */
public class SharedAndroidIosPlugin implements FlutterPlugin, MethodCallHandler,ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Activity activity;
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "shared_android_ios");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("share")) {
     share((String) call.argument("message"),"subject");
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity( @NonNull ActivityPluginBinding activityPluginBinding) {
    this.activity = activityPluginBinding.getActivity() ;

    // TODO: your plugin is now attached to an Activity
  }

  @Override
  public void  onDetachedFromActivityForConfigChanges() {
    this.activity = null;
     // TODO: the Activity your plugin was attached to was
    // destroyed to change configuration.
    // This call will be followed by onReattachedToActivityForConfigChanges().
  }
        @Override
  public void  onReattachedToActivityForConfigChanges(@NonNull  ActivityPluginBinding activityPluginBinding) {
    // TODO: your plugin is now attached to a new Activity
    // after a configuration change.
     this.activity = activityPluginBinding.getActivity() ;
  }
      @Override
  public void  onDetachedFromActivity() {
    // TODO: your plugin is no longer associated with an Activity.
    // Clean up references.
     this.activity = null;
  }
  void share(String text,String subject)
  {
    if(text == null || text.isEmpty())
    {
     // throw new IllegalArgumentExecption("text not null");
    }
     Intent sendIntent = new Intent();  
        sendIntent.setAction(Intent.ACTION_SEND);  
        sendIntent.putExtra(Intent.EXTRA_TEXT,text);  
        sendIntent.putExtra(Intent.EXTRA_SUBJECT,subject);
        sendIntent.setType("text/plain");  
        Intent.createChooser(sendIntent,"Share via");  
        activity.startActivity(sendIntent); 
  }
}