package com.heaven.flutter_trip;

import android.os.Bundle;

import com.sensong.asr_plugin.AsrPlugin;

import org.devio.flutter.splashscreen.SplashScreen;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    SplashScreen.show(this,true);
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    ///对自己的插件的一个注册
    registerSelfPlugin();
  }

  private void registerSelfPlugin() {
    AsrPlugin.registerWith(registrarFor("com.sensong.asr_plugin.AsrPlugin"));
  }
}
